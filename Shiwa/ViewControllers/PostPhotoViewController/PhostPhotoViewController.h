//
//  PhostPhotoViewController.h
//  Shiwa
//
//  Created by Xian on 8/8/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhostPhotoViewController : UIViewController
- (IBAction)onLocationBtn:(id)sender;
- (IBAction)onEditDatetimeBtn:(id)sender;
- (IBAction)onBackBtn:(id)sender;
- (IBAction)onReleaseBtn:(id)sender;
- (IBAction)onCircleBtn:(id)sender;
- (IBAction)onEventBtn:(id)sender;
- (IBAction)onAddBtn:(id)sender;
- (IBAction)onPhotoBtn1:(id)sender;
- (IBAction)onPhotoBtn2:(id)sender;
- (IBAction)onPhotoBtn3:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *m_postContext;
@property (strong, nonatomic) IBOutlet UILabel *m_postDatetime;
@property (strong, nonatomic) IBOutlet UIButton *m_eventButton;
@property (strong, nonatomic) IBOutlet UILabel *m_eventLabel;
@property (strong, nonatomic) IBOutlet UIButton *m_locationButton;
@property (strong, nonatomic) IBOutlet UIImageView *m_locationImage;
@property (strong, nonatomic) IBOutlet UILabel *m_locationText;
@property (strong, nonatomic) IBOutlet UIButton *m_circleButton;
@property (strong, nonatomic) IBOutlet UIButton *m_photoButton1;
@property (strong, nonatomic) IBOutlet UIButton *m_photoButton2;
@property (strong, nonatomic) IBOutlet UIButton *m_photoButton3;

@property (assign)  BOOL bLocationSelected;
@end
