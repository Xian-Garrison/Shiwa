//
//  SHMultipleSelect.h
//  Bugzilla
//
//  Created by Shamsiddin Saidov on 07/22/2015.
//  Copyright (c) 2015 shamsiddin.saidov@gmail.com. All rights reserved.
//

#import "SHMultipleSelect.h"

#define MAIN_SCREEN_RECT [[UIScreen mainScreen] bounds]

@interface SHMultipleSelect ()
@end


@implementation SHMultipleSelect

const int selectionRowHeight = 50;
const int selectionLeftMargin = 10;
const int selectionTopMargin = 30;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, MAIN_SCREEN_RECT.size.width, MAIN_SCREEN_RECT.size.height);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        self.layer.opacity = 0;
        
        _table = [[UITableView alloc] init];
        _table.dataSource = self;
        _table.delegate = self;
        _table.scrollEnabled = NO;
        _table.separatorColor = [UIColor clearColor];
        
//        _table.allowsMultipleSelectionDuringEditing = YES;
//        [_table setEditing:YES animated:NO];
        
        _tableScroll = [[UIScrollView alloc] init];
        _coverView = [[UIView alloc] init];
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _rowsCount;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_table cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.layer.opacity = 0;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         if ([_delegate respondsToSelector:@selector(multipleSelectView:clickedBtnAtIndex:withSelectedIndexPaths:)]) {
                             [_delegate multipleSelectView:self clickedBtnAtIndex:indexPath.row withSelectedIndexPaths:_table.indexPathsForSelectedRows];
                         }
                     }];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_table cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString* text = nil;
    if ([_delegate respondsToSelector:@selector(multipleSelectView:titleForRowAtIndexPath:)]) {
        text = [_delegate multipleSelectView:self titleForRowAtIndexPath:indexPath];
    }
    cell.textLabel.text = text;
    BOOL selected = NO;
    
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"profile_menu_people.png"];
    }
    else if (indexPath.row == 1) {
        cell.imageView.image = [UIImage imageNamed:@"profile_menu_global.png"];
        selected = YES;
    }
    else if (indexPath.row == 2) {
        cell.imageView.image = [UIImage imageNamed:@"profile_menu_lock.png"];
    }
    
    if ([_delegate respondsToSelector:@selector(multipleSelectView:setSelectedForRowAtIndexPath:)]) {
        selected = [_delegate multipleSelectView:self setSelectedForRowAtIndexPath:indexPath];
    }
    
    if (selected) {
        [_table selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    cell.accessoryType = ([self isRowSelectedOnTableView:tableView atIndexPath:indexPath]) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

- (BOOL)isRowSelectedOnTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    NSArray *selectedIndexArray = [tableView indexPathsForSelectedRows];
    return ([selectedIndexArray containsObject:indexPath]) ? YES : NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return selectionRowHeight;
}

- (void)show {
    [UIView animateWithDuration:0.2 animations:^{
        self.layer.opacity = 1;
    }];
    
    _coverView.frame = CGRectMake(selectionLeftMargin, 0, MAIN_SCREEN_RECT.size.width - (2 * selectionLeftMargin), 0);
    _coverView.layer.cornerRadius = 7;
    _coverView.clipsToBounds = YES;
    _coverView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_coverView];
    
    _tableScroll.frame = CGRectMake(0, 0, _coverView.width, 0);
    
    // table settings
    CGFloat allRowsHeight = selectionRowHeight * _rowsCount;
    
    if (allRowsHeight + 100 > self.height) {
        _coverView.top = selectionTopMargin;
        _coverView.height = self.height - (2 * selectionTopMargin);
    }
    else {
        _coverView.top = (self.height - allRowsHeight)/2;
        _coverView.height = allRowsHeight;
    }
    
    _tableScroll.top = 0;
    _tableScroll.height = _coverView.height;
    
    _tableScroll.contentSize = CGSizeMake(_tableScroll.width, allRowsHeight);
    [_coverView addSubview:_tableScroll];
    
    _table.frame = CGRectMake(0, 0, _tableScroll.width, allRowsHeight);
    [_tableScroll addSubview:_table];
    
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
}


@end
