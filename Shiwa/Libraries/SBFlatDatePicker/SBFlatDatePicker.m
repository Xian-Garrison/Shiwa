//
//  SBFlatDatePicker.m
//  SBFlatDatePicker
//
//  Created by Solomon Bier on 2/19/15.
//  Copyright (c) 2015 Solomon Bier. All rights reserved.
//

#import "SBFlatDatePicker.h"
#import "SBFlatDatePickerDelegate.h"

//Check screen macros
#define IS_WIDESCREEN (fabs ( (double)[[UIScreen mainScreen] bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0 )
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)


//Editable macros
#define TEXT_COLOR [UIColor colorWithWhite:0.5 alpha:1.0]
#define SELECTED_TEXT_COLOR [UIColor whiteColor]
#define LINE_COLOR [UIColor colorWithWhite:0.80 alpha:1.0]
#define SAVE_AREA_COLOR [UIColor colorWithWhite:0.95 alpha:1.0]
#define BAR_SEL_COLOR [UIColor colorWithRed:.45 green:.76 blue:.19 alpha:.8]
#define SAVE_BUTTON_COLOR [UIColor colorWithRed:.45 green:.76 blue:.19 alpha:1]

//Editable constants
static const float VALUE_HEIGHT = 65.0;
static const float SAVE_AREA_HEIGHT = 70.0;
static const float SAVE_AREA_MARGIN_TOP = 20.0;


//Editable values
float PICKER_HEIGHT = 600;
NSString *FONT_NAME = @"HelveticaNeue";
NSString *BOLD_FONT_NAME = @"HelveticaNeue-Medium";

NSString *NOW = @"Now";

//Static macros and constants
#define SELECTOR_ORIGIN (PICKER_HEIGHT/2.0-VALUE_HEIGHT/2.0)
#define SAVE_AREA_ORIGIN_Y self.bounds.size.height-SAVE_AREA_HEIGHT
#define PICKER_ORIGIN_Y SAVE_AREA_ORIGIN_Y-SAVE_AREA_MARGIN_TOP-PICKER_HEIGHT
#define BAR_SEL_ORIGIN_Y PICKER_HEIGHT/2.0-VALUE_HEIGHT/2.0


//Custom UIButton
@implementation SBPickerButton

- (id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setBackgroundColor:SAVE_BUTTON_COLOR];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:SELECTED_TEXT_COLOR forState:UIControlStateHighlighted];
        [self.titleLabel setFont:[UIFont fontWithName:FONT_NAME size:18.0]];
        self.layer.cornerRadius = 8.0f;
        self.clipsToBounds = YES;
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat outerMargin = 5.0f;
    CGRect outerRect = CGRectInset(self.bounds, outerMargin, outerMargin);
    CGFloat radius = 6.0;
    
    CGMutablePathRef outerPath = CGPathCreateMutable();
    CGPathMoveToPoint(outerPath, NULL, CGRectGetMidX(outerRect), CGRectGetMinY(outerRect));
    CGPathAddArcToPoint(outerPath, NULL, CGRectGetMaxX(outerRect), CGRectGetMinY(outerRect), CGRectGetMaxX(outerRect), CGRectGetMaxY(outerRect), radius);
    CGPathAddArcToPoint(outerPath, NULL, CGRectGetMaxX(outerRect), CGRectGetMaxY(outerRect), CGRectGetMinX(outerRect), CGRectGetMaxY(outerRect), radius);
    CGPathAddArcToPoint(outerPath, NULL, CGRectGetMinX(outerRect), CGRectGetMaxY(outerRect), CGRectGetMinX(outerRect), CGRectGetMinY(outerRect), radius);
    CGPathAddArcToPoint(outerPath, NULL, CGRectGetMinX(outerRect), CGRectGetMinY(outerRect), CGRectGetMaxX(outerRect), CGRectGetMinY(outerRect), radius);
    CGPathCloseSubpath(outerPath);
    
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, (self.state != UIControlStateHighlighted) ? SAVE_BUTTON_COLOR.CGColor : SELECTED_TEXT_COLOR.CGColor);
    CGContextAddPath(context, outerPath);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self setNeedsDisplay];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    [self setNeedsDisplay];
}

@end

//Custom scrollView
@interface SBPickerScrollView ()
@property (nonatomic, strong) NSArray *arrValues;
@property (nonatomic, strong) UIFont *cellFont;
@property (nonatomic, strong) UIFont *boldCellFont;
@property (nonatomic, assign, getter = isScrolling) BOOL scrolling;

@end

@implementation SBPickerScrollView

//Constants
const float LBL_BORDER_OFFSET = 8.0;

//Configure the tableView
- (id)initWithFrame:(CGRect)frame andValues:(NSArray *)arrayValues
      withTextAlign:(NSTextAlignment)align andTextSize:(float)txtSize {
    
    if(self = [super initWithFrame:frame]) {
        [self setScrollEnabled:YES];
        [self setShowsVerticalScrollIndicator:NO];
        [self setUserInteractionEnabled:YES];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self setContentInset:UIEdgeInsetsMake(BAR_SEL_ORIGIN_Y, 0.0, BAR_SEL_ORIGIN_Y, 0.0)];
        
        _cellFont = [UIFont fontWithName:FONT_NAME size:txtSize];
        _boldCellFont = [UIFont fontWithName:BOLD_FONT_NAME size:txtSize];
        
        if(arrayValues)
            _arrValues = [arrayValues copy];
    }
    return self;
}


//Dehighlight the last cell
- (void)dehighlightLastCell {
    NSArray *paths = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:_tagLastSelected inSection:0], nil];
    [self setTagLastSelected:-1];
    [self beginUpdates];
    [self reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationNone];
    [self endUpdates];
}

//Highlight a cell
- (void)highlightCellWithIndexPathRow:(NSUInteger)indexPathRow {
    [self setTagLastSelected:indexPathRow];
    NSArray *paths = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:_tagLastSelected inSection:0], nil];
    [self beginUpdates];
    [self reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationNone];
    [self endUpdates];
}


@end

@interface SBFlatDatePicker ()

@property (nonatomic, strong) NSArray *arrHours;
@property (nonatomic, strong) NSArray *arrMinutes;

@property (nonatomic, strong) SBPickerScrollView *svHours;
@property (nonatomic, strong) SBPickerScrollView *svMins;

@property (nonatomic, strong) SBPickerButton *saveButton;

@end

@implementation SBFlatDatePicker


-(void)drawRect:(CGRect)rect {
    [self initialize];
    [self buildControl];
}

- (void)initialize {
    //Set the height of picker if isn't an iPhone 5 or 5s
    [self checkScreenSize];
    
    //Create array Hours
    NSMutableArray *arrHours = [[NSMutableArray alloc] initWithCapacity:24];
    for(int i=0; i<24; i++) {
        [arrHours addObject:[NSString stringWithFormat:@"%@%d",(i<10) ? @"0":@"", i]];
    }
    _arrHours = [NSArray arrayWithArray:arrHours];
    
    NSMutableArray *arrMinutes = [[NSMutableArray alloc] initWithCapacity:60];
    for(int i=0; i<60; i++) {
        [arrMinutes addObject:[NSString stringWithFormat:@"%@%d",(i<10) ? @"0":@"", i]];
    }
    _arrMinutes = [NSArray arrayWithArray:arrMinutes];
    
    //Set the acutal date
    _selectedDate = [NSDate date];
}

- (void)buildControl {
    //Create a view as base of the picker
    UIView *pickerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, PICKER_ORIGIN_Y, self.frame.size.width, PICKER_HEIGHT)];
    [pickerView setBackgroundColor:self.backgroundColor];
    
    //Create bar selector
    UIView *barSel = [[UIView alloc] initWithFrame:CGRectMake(0.0, BAR_SEL_ORIGIN_Y, self.frame.size.width, VALUE_HEIGHT)];
    [barSel setBackgroundColor:BAR_SEL_COLOR];
    
    //Create the second column (hours) of the picker
    _svHours = [[SBPickerScrollView alloc] initWithFrame:CGRectMake(self.frame.size.width*122/320, 0.0, self.frame.size.width*66/320, PICKER_HEIGHT) andValues:_arrHours withTextAlign:NSTextAlignmentCenter  andTextSize:18];
    _svHours.tag = 1;
    [_svHours setDelegate:self];
    [_svHours setDataSource:self];
    
    //Create the third column (minutes) of the picker
    _svMins = [[SBPickerScrollView alloc] initWithFrame:CGRectMake(_svHours.frame.origin.x+self.frame.size.width*66/320, 0.0, self.frame.size.width*66/320, PICKER_HEIGHT) andValues:_arrMinutes withTextAlign:NSTextAlignmentCenter andTextSize:18];
    _svMins.tag = 2;
    [_svMins setDelegate:self];
    [_svMins setDataSource:self];
    
    
    //Layer gradient
    CAGradientLayer *gradientLayerTop = [CAGradientLayer layer];
    gradientLayerTop.frame = CGRectMake(0.0, 0.0, pickerView.frame.size.width, PICKER_HEIGHT/3.0);
    gradientLayerTop.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithWhite:1.0 alpha:0.0].CGColor, (id)self.backgroundColor.CGColor, nil];
    gradientLayerTop.startPoint = CGPointMake(0.0f, 0.7f);
    gradientLayerTop.endPoint = CGPointMake(0.0f, 0.0f);
    
    CAGradientLayer *gradientLayerBottom = [CAGradientLayer layer];
    gradientLayerBottom.frame = CGRectMake(0.0, PICKER_HEIGHT/.5, pickerView.frame.size.width, PICKER_HEIGHT/3.0);
    gradientLayerBottom.colors = gradientLayerTop.colors;
    gradientLayerBottom.startPoint = CGPointMake(0.0f, 0.3f);
    gradientLayerBottom.endPoint = CGPointMake(0.0f, 1.0f);
    
    
    //Create save area
    UIView *saveArea = [[UIView alloc] initWithFrame:CGRectMake(0.0, SAVE_AREA_ORIGIN_Y, self.frame.size.width, SAVE_AREA_HEIGHT)];
    [saveArea setBackgroundColor:SAVE_AREA_COLOR];
    
    
    //Create save button
    _saveButton = [[SBPickerButton alloc] initWithFrame:CGRectMake(10.0, 10.0, self.frame.size.width-20.0, SAVE_AREA_HEIGHT-20.0)];
    [_saveButton setTitle:@"Choose This Date & Time" forState:UIControlStateNormal];
    [_saveButton addTarget:self action:@selector(saveButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //Add pickerView
    [self addSubview:pickerView];
    
    //Add the bar selector
    [pickerView addSubview:barSel];
    
    //Add scrollViews
    [pickerView addSubview:_svHours];
    [pickerView addSubview:_svMins];
    
    //Add gradients
    [pickerView.layer addSublayer:gradientLayerTop];
    [pickerView.layer addSublayer:gradientLayerBottom];
    
    //Add Savearea
    [self addSubview:saveArea];
    
    //Add button save
    [saveArea addSubview:_saveButton];
    
    //Set the time to now
    [self setTime:NOW];
    
    [self setUserInteractionEnabled:YES];
}



#pragma mark - Other methods

//Save button pressed
- (void)saveButtonPressed:(id)sender {
    [self setUserInteractionEnabled:NO];
    
    //Create date
    NSString *time = [self createTimeWithFormat:@"HH:mm" andTimeString:@"%@:%@"];
    
    //Send the date to the delegate
    if([_delegate respondsToSelector:@selector(flatDatePicker:saveTime:)])
        [_delegate flatDatePicker:self saveTime:time];
}

//Center the value in the bar selector
- (void)centerValueForScrollView:(SBPickerScrollView *)scrollView {
    
    //Takes the actual offset
    float offset = scrollView.contentOffset.y;
    
    //Removes the contentInset and calculates the prcise value to center the nearest cell
    offset += scrollView.contentInset.top;
    int mod = (int)offset%(int)VALUE_HEIGHT;
    float newValue = (mod >= VALUE_HEIGHT/2.0) ? offset+(VALUE_HEIGHT-mod) : offset-mod;
    
    //Calculates the indexPath of the cell and set it in the object as property
    NSInteger indexPathRow = (int)(newValue/VALUE_HEIGHT);
    
    //Center the cell
    [self centerCellWithIndexPathRow:indexPathRow forScrollView:scrollView];
}

//Center phisically the cell
- (void)centerCellWithIndexPathRow:(NSUInteger)indexPathRow forScrollView:(SBPickerScrollView *)scrollView {
    
    if(indexPathRow >= [scrollView.arrValues count]) {
        indexPathRow = [scrollView.arrValues count]-1;
    }
    
    float newOffset = indexPathRow*VALUE_HEIGHT;
    
    //Re-add the contentInset and set the new offset
    newOffset -= BAR_SEL_ORIGIN_Y;
    
    [CATransaction begin];
    
    [CATransaction setCompletionBlock:^{
        
        if (![_svMins isScrolling] && ![_svHours isScrolling]) {
            [_saveButton setEnabled:YES];
        }
        
        //Highlight the cell
        [scrollView highlightCellWithIndexPathRow:indexPathRow];
        
        [scrollView setUserInteractionEnabled:YES];
        [scrollView setAlpha:1.0];
    }];
    
    [scrollView setContentOffset:CGPointMake(0.0, newOffset) animated:YES];
    
    [CATransaction commit];
}

//Return a date from a string
- (NSString *)createTimeWithFormat:(NSString *)format andTimeString:(NSString *)timeString {
    return [NSString stringWithFormat:@"%@:%@", _arrHours[_svHours.tagLastSelected], _arrMinutes[_svMins.tagLastSelected]];
} //edit here

//Return a string from a date
- (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format {
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:locale];
    [formatter setDateFormat:format];
    
    return [formatter stringFromDate:date];
}

//Set the time automatically
- (void)setTime:(NSString *)time {
    //Get the string
    NSString *strTime;
    if([time isEqualToString:NOW])
        strTime = [self stringFromDate:[NSDate date] withFormat:@"HH:mm"];
    else
        strTime = (NSString *)time;
    
    //Split
    NSArray *comp = [strTime componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" :"]];
    
    //Set the tableViews
    [_svHours dehighlightLastCell];
    [_svMins dehighlightLastCell];
    
    //Center the other fields
    [self centerCellWithIndexPathRow:([comp[0] intValue])-1 forScrollView:_svHours];
    [self centerCellWithIndexPathRow:[comp[1] intValue] forScrollView:_svMins];
}


//Check the screen size
- (void)checkScreenSize {
    if(IS_WIDESCREEN) {
        //1000
        PICKER_HEIGHT = (self.frame.size.height);
    } else {
        PICKER_HEIGHT = (self.frame.size.height);
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (![scrollView isDragging]) {
        NSLog(@"didEndDragging");
        [(SBPickerScrollView *)scrollView setScrolling:NO];
        [self centerValueForScrollView:(SBPickerScrollView *)scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"didEndDecelerating");
    [(SBPickerScrollView *)scrollView setScrolling:NO];
    [self centerValueForScrollView:(SBPickerScrollView *)scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [_saveButton setEnabled:NO];
    
    SBPickerScrollView *sv = (SBPickerScrollView *)scrollView;
    [sv setScrolling:YES];
    [sv dehighlightLastCell];
}

#pragma - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SBPickerScrollView *sv = (SBPickerScrollView *)tableView;
    return [sv.arrValues count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"reusableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    SBPickerScrollView *sv = (SBPickerScrollView *)tableView;
    
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.textLabel setFont:sv.cellFont];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    [cell.textLabel setFont:(indexPath.row == sv.tagLastSelected) ? sv.boldCellFont : sv.cellFont];
    [cell.textLabel setTextColor:(indexPath.row == sv.tagLastSelected) ? SELECTED_TEXT_COLOR : TEXT_COLOR];
    [cell.textLabel setText:sv.arrValues[indexPath.row]];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return VALUE_HEIGHT;
}


@end
