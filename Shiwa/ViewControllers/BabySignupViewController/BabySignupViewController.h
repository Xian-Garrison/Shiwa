//
//  BabySignupViewController.h
//  Shiwa
//
//  Created by Xian on 7/30/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComboBoxView.h"

@interface BabySignupViewController : UIViewController <UIImagePickerControllerDelegate, ComboBoxViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *m_photoButton;
@property (strong, nonatomic) IBOutlet UITextField *m_NickName;
@property (strong, nonatomic) IBOutlet UITextField *m_UserEmail;
@property (strong, nonatomic) IBOutlet UIScrollView *m_signupView;
@property (strong, nonatomic) IBOutlet UITextField *m_babyName;
@property (strong, nonatomic) IBOutlet UIButton *m_SignupButton;

- (IBAction)onSignupBtn:(id)sender;
- (IBAction)onPhotoBtn:(id)sender;

@end
