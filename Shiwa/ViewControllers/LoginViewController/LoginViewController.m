//
//  LoginViewController.m
//  Shiwa
//
//  Created by Xian on 7/28/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //to change the status bar color to white
    [self setNeedsStatusBarAppearanceUpdate];
    
    //keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldChange:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
}

- (void)showError:(NSString *)message {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

//to change the status bar color to white
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated
{
    //to change the border style of input boxes to Round Rect
    self.m_PhoneNumber.borderStyle = UITextBorderStyleRoundedRect;
    self.m_Password.borderStyle = UITextBorderStyleRoundedRect;
    self.m_phoneCountryNum.layer.zPosition = 1;
    self.m_countryNumLabel.layer.zPosition = 1;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onLoginBtn:(id)sender {
    [self performSegueWithIdentifier:@"login2Home" sender:nil];
}

- (IBAction)onForgotBtn:(id)sender {
    [self performSegueWithIdentifier:@"login2Forgot" sender:nil];
}

- (IBAction)onSignupBtn:(id)sender {
    [self performSegueWithIdentifier:@"login2Signup" sender:nil];
}


-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)animationView:(CGFloat)yPos {
    if(yPos == self.view.frame.origin.y)
        return;
    //	self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3
                     animations:^{
                         CGRect rt = self.view.frame;
                         rt.origin.y = yPos/* + 64*/;
                         self.view.frame = rt;
                     }completion:^(BOOL finished) {
                         //						 self.view.userInteractionEnabled = YES;
                     }];
}

#pragma mark - KeyBoard notifications
- (void)textFieldChange:(id)notification {
    NSString *phoneNum = self.m_PhoneNumber.text;
    NSString *password = self.m_Password.text;
    
    if (![phoneNum isEqualToString:@""] && ![password isEqualToString:@""])
    {
        self.m_LoginButton.alpha = 1;
    }
    else
    {
        self.m_LoginButton.alpha = 0.5;
    }
}

- (void)keyboardWillShow:(NSNotification*)notify {
    
    [self animationView:0];
}

- (void)keyboardWillHide:(NSNotification*)notify {
    [self animationView:0];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.m_PhoneNumber) {
        [self.m_Password becomeFirstResponder];
    }
    else if (textField == self.m_Password) {
        [textField resignFirstResponder];
    }
    
    return YES;
}

@end
