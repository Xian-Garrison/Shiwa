//
//  GrowthRecordViewCell.h
//  Shiwa
//
//  Created by Xian on 8/5/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GrowthRecordViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *m_datetemperature;
@property (strong, nonatomic) IBOutlet UIButton *m_lockButton;
@property (strong, nonatomic) IBOutlet UIImageView *m_weatherImage;
@property (strong, nonatomic) IBOutlet UIImageView *m_babyImage;
@property (strong, nonatomic) IBOutlet UILabel *m_babyDescription;
@property (strong, nonatomic) IBOutlet UILabel *m_postTime;
@property (strong, nonatomic) IBOutlet UILabel *m_postPlace;
@property (strong, nonatomic) IBOutlet UIButton *m_postButton;

@end
