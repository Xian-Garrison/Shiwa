//
//  PostOptionViewController.m
//  Shiwa
//
//  Created by Xian on 8/7/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import "PostOptionViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UzysAssetsPickerController.h"
#import "PhostPhotoViewController.h"
#import "PostTextViewController.h"
#import "SVProgressHUD.h"

@interface PostOptionViewController ()

@end

@implementation PostOptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNeedsStatusBarAppearanceUpdate];

}

//to change the status bar color to white
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    [super viewWillAppear:animated];
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

- (IBAction)onCloseBtn:(id)sender {
//    [self.tabBarController setSelectedIndex:3];
    [self performSegueWithIdentifier:@"option2Record" sender:nil];
}

- (IBAction)onTextBtn:(id)sender {

    [self performSegueWithIdentifier:@"option2Text" sender:nil];
}

- (IBAction)onCamerarollBtn:(id)sender {
    
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
}

- (void)uzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    [[UIApplication sharedApplication] setStatusBarHidden:self.wasStatusBarHidden withAnimation:UIStatusBarAnimationSlide];
    [self setWantsFullScreenLayout:self.wasFullScreenLayout];
#endif

    [self performSegueWithIdentifier:@"option2Photo" sender:nil];
}

- (IBAction)onTakevideoBtn:(id)sender {
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
    
    cameraUI.allowsEditing = YES;
    cameraUI.showsCameraControls = YES;
    cameraUI.delegate = self;
    [cameraUI setVideoMaximumDuration:20];
    
    [self presentViewController:cameraUI animated:YES completion:nil];

}

- (IBAction)onTakephotoBtn:(id)sender {
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
    
    cameraUI.allowsEditing = YES;
    cameraUI.showsCameraControls = YES;
    cameraUI.delegate = self;
    
    [self presentViewController:cameraUI animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    mUrlMovie = nil;
    
    if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        
        NSURL *videoUrl=(NSURL*)[info objectForKey:UIImagePickerControllerMediaURL];
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoUrl options:nil];
        
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        gen.appliesPreferredTrackTransform = YES;
        CMTime time = CMTimeMakeWithSeconds(0.0, 600);
        NSError *error = nil;
        CMTime actualTime;
        
        CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        mImage = [[UIImage alloc] initWithCGImage:image];
        CGImageRelease(image);
        
        // get video dimension
        AVAssetTrack* videoTrack = [[asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
        CGSize size = [videoTrack naturalSize];
        NSLog(@"size.width = %f size.height = %f", size.width, size.height);
        CGAffineTransform txf = [videoTrack preferredTransform];
        NSLog(@"txf.a = %f txf.b = %f txf.c = %f txf.d = %f txf.tx = %f txf.ty = %f", txf.a, txf.b, txf.c, txf.d, txf.tx, txf.ty);
        
        // convert to mp4 and small dimension and orientation
        NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:asset];
        
        if ([compatiblePresets containsObject:AVAssetExportPresetMediumQuality])
        {
            [SVProgressHUD show];
            
            //Create AVMutableComposition Object.This object will hold our multiple AVMutableCompositionTrack.
            AVMutableComposition* mixComposition = [[AVMutableComposition alloc] init];
            
            //VIDEO TRACK
            AVMutableCompositionTrack *firstTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
            [firstTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration) ofTrack:[[asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:kCMTimeZero error:nil];
            AVMutableVideoCompositionInstruction *mainInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
            mainInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, asset.duration);
            
            //AUDIO TRACK
            if ([[asset tracksWithMediaType:AVMediaTypeAudio] count] > 0)
            {
                AVMutableCompositionTrack *firstAudioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
                [firstAudioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, asset.duration) ofTrack:[[asset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:kCMTimeZero error:nil];
            }
            else
            {
                NSLog(@"warning: video has no audio");
            }
            
            //FIXING ORIENTATION//
            AVMutableVideoCompositionLayerInstruction *firstlayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:firstTrack];
            UIImageOrientation assetOrientation = UIImageOrientationUp;
            
            BOOL bIsAssetPortrait = NO;
            
            if (txf.a == 0 && txf.b == 1.0 && txf.c == -1.0 && txf.d == 0)
            {
                assetOrientation = UIImageOrientationRight;
                bIsAssetPortrait = YES;
            }
            if (txf.a == 0 && txf.b == -1.0 && txf.c == 1.0 && txf.d == 0)
            {
                assetOrientation = UIImageOrientationLeft;
                bIsAssetPortrait = YES;
            }
            if (txf.a == 1.0 && txf.b == 0 && txf.c == 0 && txf.d == 1.0)
            {
                assetOrientation = UIImageOrientationUp;
            }
            if (txf.a == -1.0 && txf.b == 0 && txf.c == 0 && txf.d == -1.0)
            {
                assetOrientation = UIImageOrientationDown;
            }
            
            CGSize szVideo = videoTrack.naturalSize;
            CGFloat fAssetScaleToFitRatio = 1;
            
            if (videoTrack.naturalSize.width > 960 || videoTrack.naturalSize.height > 960)
            {
                fAssetScaleToFitRatio = 960.0 / MAX(videoTrack.naturalSize.width, videoTrack.naturalSize.height);
                
                // calculate new size
                szVideo.width *= fAssetScaleToFitRatio;
                szVideo.height *= fAssetScaleToFitRatio;
            }
            
            CGAffineTransform firstAssetScaleFactor = CGAffineTransformMakeScale(fAssetScaleToFitRatio, fAssetScaleToFitRatio);
            if (bIsAssetPortrait)
            {
                [firstlayerInstruction setTransform:CGAffineTransformConcat(videoTrack.preferredTransform, firstAssetScaleFactor) atTime:kCMTimeZero];
                
                int nTemp = szVideo.width;
                szVideo.width = szVideo.height;
                szVideo.height = nTemp;
            }
            else
            {
                [firstlayerInstruction setTransform:CGAffineTransformConcat(videoTrack.preferredTransform, firstAssetScaleFactor) atTime:kCMTimeZero];
            }
            
            [firstlayerInstruction setOpacity:0.0 atTime:asset.duration];
            
            mainInstruction.layerInstructions = [NSArray arrayWithObjects:firstlayerInstruction,nil];;
            
            AVMutableVideoComposition *mainCompositionInst = [AVMutableVideoComposition videoComposition];
            mainCompositionInst.instructions = [NSArray arrayWithObject:mainInstruction];
            mainCompositionInst.frameDuration = CMTimeMake(1, 30);
            mainCompositionInst.renderSize = szVideo;
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *myPathDocs = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"ShiwaVideo-%d.mp4",arc4random() % 1000]];
            
            NSURL *url = [NSURL fileURLWithPath:myPathDocs];
            
            AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetMediumQuality];
            
            exporter.outputURL = url;
            exporter.outputFileType = AVFileTypeMPEG4;
            exporter.videoComposition = mainCompositionInst;
            exporter.shouldOptimizeForNetworkUse = YES;
            [exporter exportAsynchronouslyWithCompletionHandler:^
             {
                 dispatch_async(dispatch_get_main_queue(), ^
                                {
                                    if (exporter.status == AVAssetExportSessionStatusCompleted)
                                    {
                                        [SVProgressHUD dismiss];
                                        
                                        mUrlMovie = url;
                                        [self dismissViewControllerAnimated:NO completion:nil];
                                        [self performSegueWithIdentifier:@"option2Video" sender:nil];
                                    }
                                    else{
                                        [SVProgressHUD dismiss];
                                    }
                                });
             }];
        }
        else
        {
            NSLog(@"Cannot process this video");
        }

    }
    else {
        mImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        [self dismissViewControllerAnimated:NO completion:nil];
        [self performSegueWithIdentifier:@"option2Photo" sender:nil];
    }
}

- (IBAction)onIssueBtn:(id)sender {
//    [self performSegueWithIdentifier:@"option2Photo" sender:nil];
    
}

@end
