//
//  PostPhotoDaytimeViewController.m
//  Shiwa
//
//  Created by Xian on 8/8/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import "PostPhotoDaytimeViewController.h"

@interface PostPhotoDaytimeViewController ()
@property (nonatomic, retain) NSDate * curDateTime;
@property (nonatomic, retain) NSDateFormatter * formatter;
@end

@implementation PostPhotoDaytimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNeedsStatusBarAppearanceUpdate];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(recvData:)
                                                 name:@"SecVCPopped"
                                               object:nil];

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void) recvData:(NSNotification *) notification
{
    NSDictionary* userInfo = notification.userInfo;
    NSString *messageTotal = [userInfo objectForKey:@"total"];
    self.m_selectedDateTime.text = messageTotal;
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

- (IBAction)onBackBtn:(id)sender {
    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSString stringWithString:self.m_selectedDateTime.text] forKey:@"total"];
    
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"SecVCPopped" object:self userInfo:userInfo];
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
