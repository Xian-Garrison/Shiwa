//
//  ForgotVerifyViewController.h
//  Shiwa
//
//  Created by Xian on 7/28/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotVerifyViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *m_VerifyCode;
@property (strong, nonatomic) IBOutlet UIButton *m_VerifyButton;
- (IBAction)onVerifyButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *m_ResendLabel;
@property (strong, nonatomic) IBOutlet UIButton *m_ResendButton;
- (IBAction)onBackBtn:(id)sender;

@end
