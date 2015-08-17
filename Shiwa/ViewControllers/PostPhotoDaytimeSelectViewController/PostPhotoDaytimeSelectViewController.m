//
//  PostPhotoDaytimeSelectViewController.m
//  Shiwa
//
//  Created by Xian on 8/8/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import "PostPhotoDaytimeSelectViewController.h"

@interface PostPhotoDaytimeSelectViewController ()
@property (nonatomic, retain) NSDate * curDate;
@property (nonatomic, retain) NSDateFormatter * formatter;
@end

@implementation PostPhotoDaytimeSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.curDate = [NSDate date];
    self.formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    
    [self refreshTitle];
}

-(void)refreshTitle {
    self.m_dateString.text = self.curDate ? [_formatter stringFromDate:_curDate] : @"No date selected";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onDateBtn:(id)sender {
    if(!self.datePicker)
        self.datePicker = [THDatePickerViewController datePicker];
    self.datePicker.date = self.curDate;
    self.datePicker.delegate = self;
    [self.datePicker setAllowClearDate:NO];
    [self.datePicker setClearAsToday:YES];
    [self.datePicker setAutoCloseOnSelectDate:NO];
    [self.datePicker setAllowSelectionOfSelectedDate:YES];
    [self.datePicker setDisableHistorySelection:YES];
    [self.datePicker setDisableYearSwitch:YES];
    [self.datePicker setDisableFutureSelection:NO];
    [self.datePicker setDateTimeZoneWithName:@"UTC"];
    //[self.datePicker setAutoCloseCancelDelay:5.0];
    [self.datePicker setSelectedBackgroundColor:[UIColor colorWithRed:38/255.0 green:198/255.0 blue:218/255.0 alpha:1.0]];
    [self.datePicker setCurrentDateColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]];
    [self.datePicker setCurrentDateColorSelected:[UIColor whiteColor]];
    
    [self.datePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
        int tmp = (arc4random() % 30)+1;
        return (tmp % 5 == 0);
    }];
    //[self.datePicker slideUpInView:self.view withModalColor:[UIColor lightGrayColor]];
    [self presentSemiViewController:self.datePicker withOptions:@{
                                                                  KNSemiModalOptionKeys.pushParentBack    : @(NO),
                                                                  KNSemiModalOptionKeys.animationDuration : @(1.0),
                                                                  KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                                                                  }];

}

- (IBAction)onBackBtn:(id)sender {
    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSString stringWithFormat:@"%@ %@", self.m_dateString.text, self.m_timeString.text] forKey:@"total"];
    
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"SecVCPopped" object:self userInfo:userInfo];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onTimeBtn:(id)sender {
/*
    //Init the datePicker view and set self as delegate
    SBFlatDatePicker *datePicker = [[SBFlatDatePicker alloc] initWithFrame:self.view.bounds];
    [datePicker setDelegate:self];
    
    //OPTIONAL: Choose the background color
    [datePicker setBackgroundColor:[UIColor whiteColor]];
    
    //Set the data picker as view of the new view controller
    //[self.contentView addSubview:datePicker];
    [self setView:datePicker];
*/
    
}

- (void)datePickerDonePressed:(THDatePickerViewController *)datePicker {
    self.curDate = datePicker.date;
    [self refreshTitle];
    //[self.datePicker slideDownAndOut];
    [self dismissSemiModalView];
}

- (void)datePickerCancelPressed:(THDatePickerViewController *)datePicker {
    //[self.datePicker slideDownAndOut];
    [self dismissSemiModalView];
}
@end
