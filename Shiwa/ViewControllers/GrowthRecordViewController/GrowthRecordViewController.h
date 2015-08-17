//
//  GrowthRecordViewController.h
//  Shiwa
//
//  Created by Xian on 8/5/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHMultipleSelect.h"

@interface GrowthRecordViewController : UIViewController <SHMultipleSelectDelegate>
{
    NSMutableArray *_dataSource;
}
@property (strong, nonatomic) IBOutlet UITableView *m_growthRecordTable;
@property (strong, nonatomic) IBOutlet UILabel *m_babyName;
@property (strong, nonatomic) IBOutlet UILabel *m_babyTitle;
@property (strong, nonatomic) IBOutlet UILabel *m_babyPos;
@property (strong, nonatomic) IBOutlet UILabel *m_babyAge;
@property (strong, nonatomic) IBOutlet UILabel *m_babyFans;
@property (strong, nonatomic) IBOutlet UILabel *m_babyFriends;
@property (strong, nonatomic) IBOutlet UIButton *m_photoButton;
@property (strong, nonatomic) IBOutlet UIButton *m_backgroundButton;

- (IBAction)onPhotoBtn:(id)sender;
- (IBAction)onBackPhotoBtn:(id)sender;

@end
