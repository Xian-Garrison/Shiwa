//
//  ViewController.m
//  Shiwa
//
//  Created by Xian on 7/28/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBtnSignin:(id)sender {
    [self performSegueWithIdentifier:@"main2Login" sender:nil];
}

- (IBAction)onBtnSignup:(id)sender {
}
@end
