//
//  PostPhotoDaytimeViewController.h
//  Shiwa
//
//  Created by Xian on 8/8/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostPhotoDaytimeViewController : UIViewController
- (IBAction)onSelectTimeBtn:(id)sender;
- (IBAction)onBackBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *m_selectedDateTime;

@end
