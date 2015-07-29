//
//  SignupVerifyViewController.h
//  Shiwa
//
//  Created by Xian on 7/29/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupVerifyViewController : UIViewController
- (IBAction)onBackBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *m_VerifyCode;
@property (strong, nonatomic) IBOutlet UIButton *m_VerifyButton;
- (IBAction)onVerifyBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *m_ResendButton;
@property (strong, nonatomic) IBOutlet UILabel *m_ResendLabel;

@end
