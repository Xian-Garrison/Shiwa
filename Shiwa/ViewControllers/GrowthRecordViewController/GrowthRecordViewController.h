//
//  GrowthRecordViewController.h
//  Shiwa
//
//  Created by Xian on 8/5/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GrowthRecordViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *m_growthRecordTable;
@property (strong, nonatomic) IBOutlet UILabel *m_babyName;
@property (strong, nonatomic) IBOutlet UILabel *m_babyTitle;
@property (strong, nonatomic) IBOutlet UILabel *m_babyPos;
@property (strong, nonatomic) IBOutlet UILabel *m_babyAge;
@property (strong, nonatomic) IBOutlet UILabel *m_babyFans;
@property (strong, nonatomic) IBOutlet UILabel *m_babyFriends;


@end
