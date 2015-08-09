//
//  PostTextViewController.m
//  Shiwa
//
//  Created by Xian on 8/7/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import "PostTextViewController.h"
#import "PostSearchLocationViewController.h"

@interface PostTextViewController ()

@end

@implementation PostTextViewController
{
    BOOL bActivated;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

    self.m_postContext.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    bActivated = FALSE;
    
    NSDateFormatter *formatter;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    
    self.m_postDatetime.text = [formatter stringFromDate:[NSDate date]];
    
    
    
    if (self.bLocationSelected == TRUE)
    {
        UIImage *locationImage = [UIImage imageNamed:@"create_white_location_image.png"];
        [self.m_locationImage setImage:locationImage];
        
        UIImage *btnImage = [UIImage imageNamed:@"create_fill_button.png"];
        [self.m_locationButton setImage:btnImage forState:UIControlStateNormal];
        self.m_locationText.textColor = [UIColor colorWithRed:(255/255.f) green:(255/255.f) blue:(255/255.f) alpha:1.0];
        self.m_locationText.text = @"麦当劳";
    }
    else
    {
        UIImage *locationImage = [UIImage imageNamed:@"create_location_image.png"];
        [self.m_locationImage setImage:locationImage];
        
        UIImage *btnImage = [UIImage imageNamed:@"create_empty_button.png"];
        [self.m_locationButton setImage:btnImage forState:UIControlStateNormal];
        self.m_locationText.textColor = [UIColor colorWithRed:(158/255.f) green:(158/255.f) blue:(158/255.f) alpha:1.0];
        self.m_locationText.text = @"选择地点";
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    //to change the border style of input boxes to Round Rect
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//to change the status bar color to white
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)onBackBtn:(id)sender {
    [self performSegueWithIdentifier:@"text2Option" sender:nil];
}

- (IBAction)onReleaseBtn:(id)sender {
}

- (IBAction)onLocationBtn:(id)sender {
    [self performSegueWithIdentifier:@"text2Location" sender:nil];
}

- (IBAction)onCircleBtn:(id)sender {
}

- (IBAction)onEventBtn:(id)sender {
    bActivated = !bActivated;
    if (bActivated)
    {
        UIImage *btnImage = [UIImage imageNamed:@"create_big_event_fill_image.png"];
        [self.m_eventButton setImage:btnImage forState:UIControlStateNormal];
        self.m_eventLabel.textColor = [UIColor colorWithRed:(77/255.f) green:(208/255.f) blue:(225/255.f) alpha:1.0];
    }
    else
    {
        UIImage *btnImage = [UIImage imageNamed:@"create_big_event_image.png"];
        [self.m_eventButton setImage:btnImage forState:UIControlStateNormal];
        self.m_eventLabel.textColor = [UIColor colorWithRed:(189/255.f) green:(189/255.f) blue:(189/255.f) alpha:1.0];
    }
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

- (void)keyboardWillShow:(NSNotification*)notify {
    [self animationView:0];
}

- (void)keyboardWillHide:(NSNotification*)notify {
    [self animationView:0];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.m_postContext) {
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"text2Location"]) {
        PostSearchLocationViewController* postSearchLocationViewController = [segue destinationViewController];
        postSearchLocationViewController.segueName = @"text2Location";
    }
}
@end
