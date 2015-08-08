//
//  PostPhotoDaytimeViewController.m
//  Shiwa
//
//  Created by Xian on 8/8/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import "PostPhotoDaytimeViewController.h"

@interface PostPhotoDaytimeViewController ()

@end

@implementation PostPhotoDaytimeViewController

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

- (IBAction)onSelectTimeBtn:(id)sender {
    [self performSegueWithIdentifier:@"datetime2Select" sender:nil];

}
@end
