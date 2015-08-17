//
//  PostVideoViewController.m
//  Shiwa
//
//  Created by Xian on 8/14/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import "PostVideoViewController.h"
#import "PostSearchLocationViewController.h"
#import "UzysAssetsPickerController.h"

@interface PostVideoViewController ()

@end

@implementation PostVideoViewController
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
                                             selector:@selector(recvData:)
                                                 name:@"SecVCPopped"
                                               object:nil];
    
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

//to change the status bar color to white
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
    [self performSegueWithIdentifier:@"video2Record" sender:nil];
}

- (IBAction)onReleaseBtn:(id)sender {
}

- (IBAction)onLocationBtn:(id)sender {
    [self performSegueWithIdentifier:@"video2Location" sender:nil];
}

- (IBAction)onCircleBtn:(id)sender {
    _dataSource = [[NSMutableArray alloc] initWithObjects:@"亲友团", @"晒娃圈", @"只限本人", nil];
    SHMultipleSelect *multipleSelect = [[SHMultipleSelect alloc] init];
    multipleSelect.delegate = self;
    multipleSelect.rowsCount = _dataSource.count;
    [multipleSelect show];
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

- (IBAction)onEditDatetimeBtn:(id)sender {
    [self performSegueWithIdentifier:@"video2Datetime" sender:nil];
}

- (IBAction)onCameraBtn:(id)sender {
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

#pragma mark - SHMultipleSelectDelegate
- (void)multipleSelectView:(SHMultipleSelect*)multipleSelectView clickedBtnAtIndex:(NSInteger)clickedBtnIndex withSelectedIndexPaths:(NSArray *)selectedIndexPaths {
    
    for (NSIndexPath *indexPath in selectedIndexPaths) {
        if (indexPath.row == 0)
        {
            UIImage *postTypeImage = [UIImage imageNamed:@"profile_person_white_image.png"];
            [self.m_postTypeImage setImage:postTypeImage];
            self.m_postTypeLabel.text = @"亲友团";
        }
        else if (indexPath.row == 1)
        {
            UIImage *postTypeImage = [UIImage imageNamed:@"profile_global_white_image.png"];
            [self.m_postTypeImage setImage:postTypeImage];
            self.m_postTypeLabel.text = @"晒娃圈";
        }
        else if (indexPath.row == 2)
        {
            UIImage *postTypeImage = [UIImage imageNamed:@"profile_lock_white_image.png"];
            [self.m_postTypeImage setImage:postTypeImage];
            self.m_postTypeLabel.text = @"只限本人";
        }
    }
}

- (NSString*)multipleSelectView:(SHMultipleSelect*)multipleSelectView titleForRowAtIndexPath:(NSIndexPath*)indexPath {
    return _dataSource[indexPath.row];
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
    if ([[segue identifier] isEqualToString:@"video2Location"]) {
        PostSearchLocationViewController* postSearchLocationViewController = [segue destinationViewController];
        postSearchLocationViewController.segueName = @"video2Location";
    }
}
@end
