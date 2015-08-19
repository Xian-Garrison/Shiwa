//
//  FriendSearchViewController.m
//  Shiwa
//
//  Created by Xian on 8/14/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import "FriendSearchViewController.h"
#import "FriendSearchViewCell.h"
#import "FriendSearchSectionViewCell.h"
#import "KXMenu.h"

@interface FriendSearchViewController ()

@end

@implementation FriendSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnTableView:)];
    [self.m_friendSearchTable addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onPlusBtn:(UIButton *)sender {
    NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:@"新增亲友"
                     image:[UIImage imageNamed:@"chat_icon.png"]
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"群组讨论"
                     image:[UIImage imageNamed:@"new_friend_icon.png"]
                    target:self
                    action:@selector(pushMenuItem:)],
      
      ];
    
    [KxMenu showMenuInView:self.view
                  fromRect:sender.frame
                 menuItems:menuItems];
}

- (void) pushMenuItem:(id)sender
{
    NSLog(@"%@", sender);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didTapOnTableView:(UIGestureRecognizer *) recognizer {
    CGPoint tapLocation = [recognizer locationInView:self.m_friendSearchTable];
    NSIndexPath *indexPath = [self.m_friendSearchTable indexPathForRowAtPoint:tapLocation];
    
    if (indexPath && indexPath.row > 0) {

    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    int nNum = 4;
    
    return nNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *tableCell;

    if (indexPath.row != 0)
    {

        FriendSearchViewCell *friendViewCell = (FriendSearchViewCell *)[self.m_friendSearchTable dequeueReusableCellWithIdentifier:@"FriendSearchCellID"];
    
        tableCell = friendViewCell;

    }
    else
    {
        FriendSearchSectionViewCell *friendSectionViewCell = (FriendSearchSectionViewCell *)[self.m_friendSearchTable dequeueReusableCellWithIdentifier:@"FriendSectionCellID"];
        
        tableCell = friendSectionViewCell;
    }

    return tableCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int nHeight = 85;
    if (indexPath.row == 0)
        nHeight = 17;
    return nHeight;
}


@end
