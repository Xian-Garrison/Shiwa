//
//  ForgotViewController.h
//  Shiwa
//
//  Created by Xian on 7/28/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *m_phoneCountryNum;
@property (strong, nonatomic) IBOutlet UITextField *m_PhoneNumber;
@property (strong, nonatomic) IBOutlet UIButton *m_SendSMSButton;
- (IBAction)onSendSMSBtn:(id)sender;
- (IBAction)onBackBtn:(id)sender;

@end
