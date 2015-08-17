//
//  PostTagViewController.m
//  Shiwa
//
//  Created by Xian on 8/15/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import "PostTagViewController.h"
#import "PostSearchLocationViewController.h"
#import "UzysAssetsPickerController.h"

@interface PostTagViewController ()

@end

@implementation PostTagViewController
{
    BOOL bActivated;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //to change the status bar color to white
    [self setNeedsStatusBarAppearanceUpdate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(recvData:)
                                                 name:@"SecVCPopped"
                                               object:nil];
    
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

- (void) recvData:(NSNotification *) notification
{
    NSDictionary* userInfo = notification.userInfo;
    NSString *messageTotal = [userInfo objectForKey:@"total"];
    self.m_postDatetime.text = messageTotal;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onBackBtn:(id)sender {
    [self performSegueWithIdentifier:@"tag2Record" sender:nil];
}

- (IBAction)onReleaseBtn:(id)sender {
}

- (IBAction)onLocationBtn:(id)sender {
    [self performSegueWithIdentifier:@"tag2Location" sender:nil];
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

- (IBAction)onVideoBtn:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO) {
        return;
    }
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]
        && [[UIImagePickerController availableMediaTypesForSourceType:
             UIImagePickerControllerSourceTypeCamera] containsObject:(NSString *)kUTTypeImage]) {
        
        cameraUI.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *) kUTTypeMovie, nil];
        cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            cameraUI.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        } else if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            cameraUI.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
        
    } else {
        return;
    }
    
    cameraUI.allowsEditing = NO;
    cameraUI.showsCameraControls = YES;
    cameraUI.delegate = self;
    [cameraUI setVideoMaximumDuration:20];
    
    [self presentViewController:cameraUI animated:YES completion:nil];
}

- (IBAction)onPhotoBtn:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO) {
        return;
    }
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]
        && [[UIImagePickerController availableMediaTypesForSourceType:
             UIImagePickerControllerSourceTypeCamera] containsObject:(NSString *)kUTTypeImage]) {
        
        cameraUI.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *) kUTTypeImage, nil];
        cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            cameraUI.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        } else if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            cameraUI.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
        
    } else {
        return;
    }
    
    cameraUI.allowsEditing = NO;
    cameraUI.showsCameraControls = YES;
    cameraUI.delegate = self;
    
    [self presentViewController:cameraUI animated:YES completion:nil];
}

- (IBAction)onEdittimeBtn:(id)sender {
    [self performSegueWithIdentifier:@"tag2Datetime" sender:nil];
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
        [self.m_postTag becomeFirstResponder];
    }
    else if (textField == self.m_postTag) {
        [textField resignFirstResponder];
        
        NSString *tag = self.m_postTag.text;
        NSString *trimmed_tag = [tag stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSArray *tag_items = [trimmed_tag componentsSeparatedByString:@","];
        int tag_count = [tag_items count];
        
        for (int i = 0; i < tag_count; i++)
        {
            NSString *tag_item = (NSString *)tag_items[i];
            NSString *first = [tag_item substringToIndex:1];
            if (![first isEqualToString:@"#"])
            {
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please input # in the front of tag strings." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                break;
            }
        }
    }
    
    return YES;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"tag2Location"]) {
        PostSearchLocationViewController* postSearchLocationViewController = [segue destinationViewController];
        postSearchLocationViewController.segueName = @"tag2Location";
    }
}
@end
