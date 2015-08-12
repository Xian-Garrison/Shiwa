//
//  PostPhotoDaytimeSelectViewController.h
//  Shiwa
//
//  Created by Xian on 8/8/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THDatePickerViewController.h"
#import "SBFlatDatePicker.h"
#import "SBFlatDatePickerDelegate.h"

@interface PostPhotoDaytimeSelectViewController : UIViewController <SBFLatDatePickerDelegate>
- (IBAction)onDateBtn:(id)sender;
- (IBAction)onBackBtn:(id)sender;
- (IBAction)onTimeBtn:(id)sender;
@property (nonatomic, strong) THDatePickerViewController * datePicker;
@property (strong, nonatomic) IBOutlet UILabel *m_dateString;
@property (strong, nonatomic) IBOutlet UILabel *m_timeString;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@end
