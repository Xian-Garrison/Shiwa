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
    
    [self.m_growthRecordTable setContentInset:UIEdgeInsetsMake(0, 0, 220, 0)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    [super viewWillAppear:animated];
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

- (void)onBtnLock:(id)sender {
    //    m_nCategoryNum = (int)((UIButton*)sender).tag;
    //    [self performSegueWithIdentifier:@"category2Feed" sender:nil];
}

- (void)onBtnPost:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"编辑", @"删除", nil];
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}

- (BOOL)onBtnDelete {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定要删除?", @"确定", nil];
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
    return 1;
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
    [growthRecordViewCell.m_lockButton addTarget:self action:@selector(onBtnLock:) forControlEvents:UIControlEventTouchUpInside];
    growthRecordViewCell.m_lockButton.tag = indexPath.row;
    
    [growthRecordViewCell.m_postButton addTarget:self action:@selector(onBtnPost:) forControlEvents:UIControlEventTouchUpInside];
    growthRecordViewCell.m_postButton.tag = indexPath.row;
    
    tableCell = growthRecordViewCell;
    
    return tableCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int nHeight = 284;
    
    return nHeight;
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self onBtnDelete];
    }
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

@end
