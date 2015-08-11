//
//  SignupViewController.h
//  Shiwa
//
//  Created by Xian on 7/29/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController
- (IBAction)onBackBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *m_PhoneNumber;
@property (strong, nonatomic) IBOutlet UIImageView *m_phoneCountryNum;
@property (strong, nonatomic) IBOutlet UITextField *m_Password;
@property (strong, nonatomic) IBOutlet UIButton *m_SignupButton;
@property (strong, nonatomic) IBOutlet UILabel *m_countryNumLabel;
- (IBAction)onSignupBtn:(id)sender;
@end
