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
    
    NSDate *curDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *newDateString = [formatter stringFromDate:curDate];
    self.m_automaticDateTime.text = newDateString;
    
    self.m_selectedDateTime.hidden = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void) recvData:(NSNotification *) notification
{
    NSDictionary* userInfo = notification.userInfo;
    NSString *messageTotal = [userInfo objectForKey:@"total"];
    
    self.m_selectedDateTime.hidden = NO;
    [self.m_selectTimeButton setImage:[UIImage imageNamed:@"create_selecttime_fill_image.png"] forState:UIControlStateNormal];
    self.m_selectedDateTime.text = messageTotal;
    self.m_selectedLabel.textColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
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
