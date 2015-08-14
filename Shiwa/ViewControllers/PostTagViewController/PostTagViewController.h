//
//  PostTagViewController.h
//  Shiwa
//
//  Created by Xian on 8/15/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHMultipleSelect.h"

@interface PostTagViewController : UIViewController<SHMultipleSelectDelegate>
{
    NSMutableArray *_dataSource;
}

@property (strong, nonatomic) IBOutlet UITextField *m_postContext;
@property (strong, nonatomic) IBOutlet UIButton *m_releasebutton;
@property (strong, nonatomic) IBOutlet UIButton *m_eventButton;
@property (strong, nonatomic) IBOutlet UILabel *m_eventLabel;
@property (strong, nonatomic) IBOutlet UIButton *m_locationButton;
@property (strong, nonatomic) IBOutlet UIImageView *m_locationImage;
@property (strong, nonatomic) IBOutlet UILabel *m_locationText;
@property (strong, nonatomic) IBOutlet UITextField *m_postTag;
@property (strong, nonatomic) IBOutlet UILabel *m_postDatetime;

- (IBAction)onBackBtn:(id)sender;
- (IBAction)onReleaseBtn:(id)sender;
- (IBAction)onLocationBtn:(id)sender;
- (IBAction)onEventBtn:(id)sender;
- (IBAction)onVideoBtn:(id)sender;
- (IBAction)onPhotoBtn:(id)sender;

@property (assign) BOOL bLocationSelected;
@end
