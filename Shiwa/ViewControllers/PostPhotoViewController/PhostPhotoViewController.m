//
//  PhostPhotoViewController.m
//  Shiwa
//
//  Created by Xian on 8/8/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import "PhostPhotoViewController.h"
#import "PostSearchLocationViewController.h"
#import "UzysAssetsPickerController.h"


@interface PhostPhotoViewController ()

@end

@implementation PhostPhotoViewController
{
    BOOL bActivated;
    int photoNumber;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
    photoNumber = 3;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)onLocationBtn:(id)sender {
    [self performSegueWithIdentifier:@"photo2Location" sender:nil];
}

- (IBAction)onEditDatetimeBtn:(id)sender {
    [self performSegueWithIdentifier:@"photo2Datetime" sender:nil];
}

- (IBAction)onBackBtn:(id)sender {
    [self performSegueWithIdentifier:@"photo2Option" sender:nil];
}

- (IBAction)onReleaseBtn:(id)sender {
    
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

- (IBAction)onAddBtn:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Use Your Camera", @"Select from Camera Roll", nil];
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self shouldStartCameraController];
    } else if (buttonIndex == 1) {
        [self shouldStartPhotoLibraryPickerController];
    }
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (BOOL)shouldStartCameraController {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO) {
        return NO;
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
        return NO;
    }
    
    cameraUI.allowsEditing = YES;
    cameraUI.showsCameraControls = YES;
    cameraUI.delegate = self;
    
    [self presentViewController:cameraUI animated:YES completion:nil];
    return YES;
}

- (BOOL)shouldStartPhotoLibraryPickerController {
#if 0
    UzysAppearanceConfig *appearanceConfig = [[UzysAppearanceConfig alloc] init];
    appearanceConfig.finishSelectionButtonColor = [UIColor blueColor];
    appearanceConfig.assetsGroupSelectedImageName = @"checker.png";
    appearanceConfig.cellSpacing = 1.0f;
    appearanceConfig.assetsCountInALine = 5;
    [UzysAssetsPickerController setUpAppearanceConfig:appearanceConfig];
#endif
    
    UzysAssetsPickerController *picker = [[UzysAssetsPickerController alloc] init];
    picker.delegate = self;
    picker.maximumNumberOfSelectionVideo = 0;
    picker.maximumNumberOfSelectionPhoto = 9;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
    return YES;
}

- (IBAction)onPhotoBtn1:(id)sender {
    if (photoNumber == 3)
    {
        self.m_photoButton3.hidden = YES;
    }
    else if (photoNumber == 2)
    {
        self.m_photoButton2.hidden = YES;
    }
    else if (photoNumber == 1)
    {
        self.m_photoButton1.hidden = YES;
    }
    photoNumber--;
}

- (IBAction)onPhotoBtn2:(id)sender {
    if (photoNumber == 3)
    {
        self.m_photoButton3.hidden = YES;
    }
    else if (photoNumber == 2)
    {
        self.m_photoButton2.hidden = YES;
    }
    else if (photoNumber == 1)
    {
        self.m_photoButton1.hidden = YES;
    }
    photoNumber--;
}

- (IBAction)onPhotoBtn3:(id)sender {
    if (photoNumber == 3)
    {
        self.m_photoButton3.hidden = YES;
    }
    else if (photoNumber == 2)
    {
        self.m_photoButton2.hidden = YES;
    }
    else if (photoNumber == 1)
    {
        self.m_photoButton1.hidden = YES;
    }
    photoNumber--;
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
    if ([[segue identifier] isEqualToString:@"photo2Location"]) {
        PostSearchLocationViewController* postSearchLocationViewController = [segue destinationViewController];
        postSearchLocationViewController.segueName = @"photo2Location";
    }
}
@end
