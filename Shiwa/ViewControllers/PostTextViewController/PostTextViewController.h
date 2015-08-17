//
//  PostTextViewController.h
//  Shiwa
//
//  Created by Xian on 8/7/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHMultipleSelect.h"

@interface PostTextViewController : UIViewController <SHMultipleSelectDelegate>
{
    NSMutableArray *_dataSource;
}
@property (strong, nonatomic) IBOutlet UITextField *m_postContext;
@property (strong, nonatomic) IBOutlet UIButton *m_circleButton;
@property (strong, nonatomic) IBOutlet UILabel *m_postDatetime;
@property (strong, nonatomic) IBOutlet UIButton *m_releaseButton;
@property (strong, nonatomic) IBOutlet UIImageView *m_postTypeImage;
@property (strong, nonatomic) IBOutlet UILabel *m_postTypeLabel;

@property (strong, nonatomic) IBOutlet UIButton *m_eventButton;
@property (strong, nonatomic) IBOutlet UILabel *m_eventLabel;

@property (strong, nonatomic) IBOutlet UIButton *m_locationButton;
@property (strong, nonatomic) IBOutlet UIImageView *m_locationImage;
@property (strong, nonatomic) IBOutlet UILabel *m_locationText;

- (IBAction)onBackBtn:(id)sender;
- (IBAction)onReleaseBtn:(id)sender;
- (IBAction)onLocationBtn:(id)sender;
- (IBAction)onCircleBtn:(id)sender;
- (IBAction)onEventBtn:(id)sender;
- (IBAction)onEdittimeBtn:(id)sender;

@property (assign)  BOOL bLocationSelected;
@end
