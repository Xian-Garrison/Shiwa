//
//  PhostPhotoViewController.m
//  Shiwa
//
//  Created by Xian on 8/8/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import "PhostPhotoViewController.h"

@interface PhostPhotoViewController ()

@end

@implementation PhostPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)onEditDatetimeBtn:(id)sender {
    [self performSegueWithIdentifier:@"photo2Datetime" sender:nil];
}
@end
