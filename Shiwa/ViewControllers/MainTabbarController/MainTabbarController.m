//
//  MainTabbarController.m
//  Shiwa
//
//  Created by Xian on 8/7/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import "MainTabbarController.h"
#import "PostOptionViewController.h"

@interface MainTabbarController ()

@end

@implementation MainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITabBarItem *item = [self.tabBar.items objectAtIndex:0];
    
    item.image = [[UIImage imageNamed:@"tab_home_btn.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    [item setTitlePositionAdjustment:UIOffsetMake(0, 0)];
    
    // interest
    item = [self.tabBar.items objectAtIndex:1];
    
    item.image = [[UIImage imageNamed:@"tab_relative_btn.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    [item setTitlePositionAdjustment:UIOffsetMake(0, 0)];

    UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    plusButton.frame = CGRectMake( self.tabBar.bounds.size.width / 2 - 16, 8, 32, 32);
    [plusButton setImage:[UIImage imageNamed:@"tab_plus_btn.png"] forState:UIControlStateNormal];
    [plusButton setImage:[UIImage imageNamed:@"tab_plus_btn.png"] forState:UIControlStateHighlighted];
    [plusButton addTarget:self action:@selector(plusButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:plusButton];
    
    // notify
    item = [self.tabBar.items objectAtIndex:3];
    
    item.image = [[UIImage imageNamed:@"tab_record_btn.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    [item setTitlePositionAdjustment:UIOffsetMake(0, 0)];
    
    // profile
    item = [self.tabBar.items objectAtIndex:4];
    
    item.image = [[UIImage imageNamed:@"tab_profile_btn.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    [item setTitlePositionAdjustment:UIOffsetMake(0, 0)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)plusButtonAction:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PostOptionViewController *poVC = [storyboard instantiateViewControllerWithIdentifier:@"PostOptionViewController"];
    [self presentViewController:poVC animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
