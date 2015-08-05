//
//  BabySignupViewController.h
//  Shiwa
//
//  Created by Xian on 7/30/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BabySignupViewController : UIViewController
- (IBAction)onBackBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *m_NickName;
@property (strong, nonatomic) IBOutlet UITextField *m_UserEmail;
@property (strong, nonatomic) IBOutlet UIScrollView *m_signupView;
@property (strong, nonatomic) IBOutlet UITextField *m_babyName;
@property (strong, nonatomic) IBOutlet UIButton *m_SignupButton;
- (IBAction)onSignupBtn:(id)sender;

@end
