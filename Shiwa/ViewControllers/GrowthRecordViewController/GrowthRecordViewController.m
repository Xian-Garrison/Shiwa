//
//  GrowthRecordViewController.m
//  Shiwa
//
//  Created by Xian on 8/5/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import "GrowthRecordViewController.h"
#import "GrowthRecordViewCell.h"
#import "UzysAssetsPickerController.h"

#import "SGActionView.h"
#import "MKInputBoxView.h"

@interface GrowthRecordViewController ()

@end

@implementation GrowthRecordViewController
{
    BOOL bLiked[4];
    UIImagePickerController *mPickerPhoto;
    UIImagePickerController *mPickerBack;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    // Do any additional setup after loading the view.
    
    [self.m_babyName setText:@"成长记  Julian"];
    [self.m_babyTitle setText:@"Julian 成长日记"];
    [self.m_babyPos setText:@"杭州市"];
    [self.m_babyAge setText:@"48 个月"];
    [self.m_babyFans setText:@"粉丝   58k"];
    [self.m_babyFriends setText:@"亲友团  183"];
    
    [self.m_growthRecordTable setContentInset:UIEdgeInsetsMake(0, 0, 220, 0)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnTableView:)];
    [self.m_growthRecordTable addGestureRecognizer:tap];
    
    [self.tabBarController.tabBar setHidden:NO];
    
    for (int i = 0; i < 4; i++)
        bLiked[i] = FALSE;
}

- (void)didTapOnTableView:(UIGestureRecognizer *) recognizer {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"编辑", @"删除", nil];
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
}

//to change the status bar color to white
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onBtnLock:(id)sender {
    _dataSource = [[NSMutableArray alloc] initWithObjects:@"亲友团", @"晒娃圈", @"只限本人", nil];
    SHMultipleSelect *multipleSelect = [[SHMultipleSelect alloc] init];
    multipleSelect.delegate = self;
    multipleSelect.rowsCount = _dataSource.count;
    [multipleSelect show];
}

- (void)onBtnPost:(id)sender {
    [SGActionView showGridMenuWithTitle:@"分享"
                             itemTitles:@[ @"新浪微博", @"微信朋友圈", @"微信好友" ]
                                 images:@[ [UIImage imageNamed:@"profile_weibo_btn"],
                                           [UIImage imageNamed:@"profile_email_btn"],
                                           [UIImage imageNamed:@"profile_wechat_btn"] ]
                         selectedHandle:nil];
}

- (void)onBtnLike:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.m_growthRecordTable];
    NSIndexPath *indexPath = [self.m_growthRecordTable indexPathForRowAtPoint:buttonPosition];
    
    NSLog(@"row = %d", indexPath.row);
    bLiked[indexPath.row] = !bLiked[indexPath.row];
    [self.m_growthRecordTable reloadData];
}

- (BOOL)onBtnDelete {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定要删除?", @"确定", nil];
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
    return 1;
}

- (void)onBtnComment:(id)sender {
    MKInputBoxView *inputBoxView = [MKInputBoxView boxOfType:PlainTextInput];
    [inputBoxView setTitle:@"评论"];
    [inputBoxView setMessage:@"请在这里输入评论。"];
    [inputBoxView setBlurEffectStyle:UIBlurEffectStyleExtraLight];
    
    [inputBoxView setCancelButtonText:@"取消"];
    [inputBoxView setSubmitButtonText:@"提交"];
    
    inputBoxView.customise = ^(UITextField *textField) {
        textField.placeholder = @"请在这里输入评论";
        textField.textColor = [UIColor blackColor];
        textField.layer.cornerRadius = 4.0f;
        return textField;
    };
    /*
     inputBoxView.onSubmit = ^(NSString *value1, NSString *value2) {
     NSLog(@"user: %@", value1);
     NSLog(@"pass: %@", value2);
     };
     */
    inputBoxView.onCancel = ^{
        NSLog(@"Cancel!");
    };
    
    [inputBoxView show];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    int nNum = 4;
    
    return nNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"Cell for Row Index");
    UITableViewCell *tableCell;
    
    GrowthRecordViewCell *growthRecordViewCell = (GrowthRecordViewCell *)[self.m_growthRecordTable dequeueReusableCellWithIdentifier:@"GrowthRecordCellID"];
    
    if (indexPath.row == 0)
    {
        [growthRecordViewCell.m_datetemperature setText:@"3 月 11 日   23˚"];
        [growthRecordViewCell.m_babyDescription setText:@"Julian 一岁照片回顾"];
        [growthRecordViewCell.m_postTime setText:@"21:38"];
        [growthRecordViewCell.m_postPlace setText:@"杭州市"];
        [growthRecordViewCell.m_weatherImage setImage:[UIImage imageNamed:@"profile_rain_image.png"]];
    }
    else if (indexPath.row == 1)
    {
        [growthRecordViewCell.m_datetemperature setText:@"4 月 1 日   23˚"];
        [growthRecordViewCell.m_babyDescription setText:@"Julian 一岁照片回顾"];
        [growthRecordViewCell.m_postTime setText:@"19:23"];
        [growthRecordViewCell.m_postPlace setText:@"上海市"];
        [growthRecordViewCell.m_weatherImage setImage:[UIImage imageNamed:@"profile_cloudy_image.png"]];
    }
    else if (indexPath.row == 2 || indexPath.row == 3)
    {
        [growthRecordViewCell.m_datetemperature setText:@"5 月 1 日   23˚"];
        [growthRecordViewCell.m_babyDescription setText:@"Julian 一岁照片回顾"];
        [growthRecordViewCell.m_postTime setText:@"19:45"];
        [growthRecordViewCell.m_postPlace setText:@"北京市"];
        [growthRecordViewCell.m_weatherImage setImage:[UIImage imageNamed:@"profile_suncloudy_image.png"]];
    }
    [growthRecordViewCell.m_postTypeButton addTarget:self action:@selector(onBtnLock:) forControlEvents:UIControlEventTouchUpInside];
    growthRecordViewCell.m_postTypeButton.tag = indexPath.row;
    
    [growthRecordViewCell.m_postButton addTarget:self action:@selector(onBtnPost:) forControlEvents:UIControlEventTouchUpInside];
    growthRecordViewCell.m_postButton.tag = indexPath.row;
    
    [growthRecordViewCell.m_likeButton addTarget:self action:@selector(onBtnLike:) forControlEvents:UIControlEventTouchUpInside];
    growthRecordViewCell.m_likeButton.tag = indexPath.row;
    
    [growthRecordViewCell.m_commentButton addTarget:self action:@selector(onBtnComment:) forControlEvents:UIControlEventTouchUpInside];
    growthRecordViewCell.m_commentButton.tag = indexPath.row;
    
    if (bLiked[indexPath.row])
    {
        [growthRecordViewCell.m_likeImage setImage:[UIImage imageNamed:@"profile_like_fill_image.png"]];
    }
    else
    {
        [growthRecordViewCell.m_likeImage setImage:[UIImage imageNamed:@"profile_like_image.png"]];
    }
    
    tableCell = growthRecordViewCell;
    
    return tableCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int nHeight = 284;
    
    return nHeight;
}

- (IBAction)onPhotoBtn:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Use Your Camera", @"Media From Library", nil];
    [actionSheet showFromTabBar:self.tabBarController.tabBar];

}

- (IBAction)onBackPhotoBtn:(id)sender {
    mPickerBack = [[UIImagePickerController alloc] init];
    mPickerBack.delegate = self;
    mPickerBack.allowsEditing = NO;
    mPickerBack.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:mPickerBack animated:YES completion:NULL];
}

#pragma mark - SHMultipleSelectDelegate
- (void)multipleSelectView:(SHMultipleSelect*)multipleSelectView clickedBtnAtIndex:(NSInteger)clickedBtnIndex withSelectedIndexPaths:(NSArray *)selectedIndexPaths {
    

}

- (NSString*)multipleSelectView:(SHMultipleSelect*)multipleSelectView titleForRowAtIndexPath:(NSIndexPath*)indexPath {
    return _dataSource[indexPath.row];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"删除"])
    {
        [self onBtnDelete];
    }
    else if ([title isEqualToString:@"Use Your Camera"])
    {
        [self shouldStartCameraController];
    }
    else if ([title isEqualToString:@"Media From Library"])
    {
        [self shouldStartPhotoLibraryPickerController];
    }
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (BOOL)shouldStartCameraController {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO) {
        return NO;
    }
    
    mPickerPhoto.delegate = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]
        && [[UIImagePickerController availableMediaTypesForSourceType:
             UIImagePickerControllerSourceTypeCamera] containsObject:(NSString *)kUTTypeImage]) {
        
        mPickerPhoto.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *) kUTTypeImage, nil];
        mPickerPhoto.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            mPickerPhoto.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        } else if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            mPickerPhoto.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
        
    } else {
        return NO;
    }
    
    mPickerPhoto.allowsEditing = NO;
    mPickerPhoto.showsCameraControls = YES;
    mPickerPhoto.delegate = self;
    
    [self presentViewController:mPickerPhoto animated:YES completion:nil];
    
    return YES;
}

- (BOOL)shouldStartPhotoLibraryPickerController {
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == NO
         && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)) {
        return NO;
    }
    
    mPickerPhoto = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]
        && [[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary] containsObject:(NSString *)kUTTypeImage]) {
        
        mPickerPhoto.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        mPickerPhoto.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *) kUTTypeImage, nil];
        
    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]
               && [[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum] containsObject:(NSString *)kUTTypeImage]) {
        
        mPickerPhoto.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        mPickerPhoto.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *) kUTTypeImage,  nil];
        
    } else {
        return NO;
    }
    
    mPickerPhoto.allowsEditing = NO;
    mPickerPhoto.delegate = self;

    [self presentViewController:mPickerPhoto animated:YES completion:nil];
    
    return YES;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (picker == mPickerPhoto) {
        [self.m_photoButton setImage:image forState:UIControlStateNormal];
        [self.m_photoButton.layer setBorderWidth:2.0f];
        [self.m_photoButton.layer setBorderColor:[[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0] CGColor]];
        [self.m_photoButton.layer setCornerRadius:5.0f];
        [self.m_photoButton setImageEdgeInsets:UIEdgeInsetsMake(2,2,2,2)];
    }
    else if (picker == mPickerBack) {
        [self.m_backgroundButton setImage:image forState:UIControlStateNormal];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
