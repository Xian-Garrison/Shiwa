//
//  GrowthRecordViewController.m
//  Shiwa
//
//  Created by Xian on 8/5/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import "GrowthRecordViewController.h"
#import "GrowthRecordViewCell.h"

@interface GrowthRecordViewController ()

@end

@implementation GrowthRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    // Do any additional setup after loading the view.
    
    [self.m_babyName setText:@"成长记  Julian"];
    [self.m_babyTitle setText:@"Julian 成长日记"];
    [self.m_babyPos setText:@"杭州市"];
    [self.m_babyAge setText:@"48 个月"];
    [self.m_babyFans setText:@"粉丝   58k"];
    [self.m_babyFriends setText:@"亲友团  183"];
}

//to change the status bar color to white
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    int nNum = 4;
    
    return nNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"Cell for Row Index");
    UITableViewCell *tableCell;
    
    GrowthRecordViewCell *growthRecordViewCell = (GrowthRecordViewCell *)[self.m_growthRecordTable dequeueReusableCellWithIdentifier:@"GrowthRecordCellID"];
    
    if (indexPath.row == 0)
    {
        [growthRecordViewCell.m_datetemperature setText:@"3 月 11 日   23˚"];
        [growthRecordViewCell.m_babyDescription setText:@"Julian 一岁照片回顾"];
        [growthRecordViewCell.m_postTime setText:@"21:38"];
        [growthRecordViewCell.m_postPlace setText:@"杭州市"];
        [growthRecordViewCell.m_weatherImage setImage:[UIImage imageNamed:@"profile_rain_image.png"]];
    }
    else if (indexPath.row == 1)
    {
        [growthRecordViewCell.m_datetemperature setText:@"4 月 1 日   23˚"];
        [growthRecordViewCell.m_babyDescription setText:@"Julian 一岁照片回顾"];
        [growthRecordViewCell.m_postTime setText:@"19:23"];
        [growthRecordViewCell.m_postPlace setText:@"上海市"];
        [growthRecordViewCell.m_weatherImage setImage:[UIImage imageNamed:@"profile_cloudy_image.png"]];
    }
    else if (indexPath.row == 2 || indexPath.row == 3)
    {
        [growthRecordViewCell.m_datetemperature setText:@"5 月 1 日   23˚"];
        [growthRecordViewCell.m_babyDescription setText:@"Julian 一岁照片回顾"];
        [growthRecordViewCell.m_postTime setText:@"19:45"];
        [growthRecordViewCell.m_postPlace setText:@"北京市"];
        [growthRecordViewCell.m_weatherImage setImage:[UIImage imageNamed:@"profile_suncloudy_image.png"]];
    }
    
    tableCell = growthRecordViewCell;
    
    return tableCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int nHeight = 284;
    
    return nHeight;
}

@end
