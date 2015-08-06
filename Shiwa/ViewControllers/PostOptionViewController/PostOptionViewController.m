//
//  PostOptionViewController.m
//  Shiwa
//
//  Created by Xian on 8/7/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import "PostOptionViewController.h"

@interface PostOptionViewController ()

@end

@implementation PostOptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNeedsStatusBarAppearanceUpdate];

}

//to change the status bar color to white
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    [super viewWillAppear:animated];
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

- (IBAction)onCloseBtn:(id)sender {
    [self performSegueWithIdentifier:@"option2Record" sender:nil];
}

- (IBAction)onTextBtn:(id)sender {
    [self performSegueWithIdentifier:@"option2Text" sender:nil];
}

- (IBAction)onCamerarollBtn:(id)sender {
}

- (IBAction)onTakevideoBtn:(id)sender {
}

- (IBAction)onTakephotoBtn:(id)sender {
}
- (IBAction)onIssueBtn:(id)sender {
}
@end
