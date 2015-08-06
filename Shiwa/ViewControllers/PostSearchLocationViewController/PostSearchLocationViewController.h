//
//  PostSearchLocationViewController.h
//  Shiwa
//
//  Created by Xian on 8/7/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostSearchLocationViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *m_searchLocationTable;

- (IBAction)onBackBtn:(id)sender;
@end
