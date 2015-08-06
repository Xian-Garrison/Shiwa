//
//  PostSearchLocationViewController.m
//  Shiwa
//
//  Created by Xian on 8/7/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import "PostSearchLocationViewController.h"
#import "SearchLocationViewCell.h"
#import "PostTextViewController.h"

@interface PostSearchLocationViewController ()

@end

@implementation PostSearchLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    int nNum = 4;
    
    return nNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"Cell for Row Index");
    UITableViewCell *tableCell;
    
    SearchLocationViewCell *searchLocationViewCell = (SearchLocationViewCell *)[self.m_searchLocationTable dequeueReusableCellWithIdentifier:@"SearchLocationCellID"];
    
    tableCell = searchLocationViewCell;
    
    return tableCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"location2Text" sender:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int nHeight = 63;
    
    return nHeight;
}

- (IBAction)onBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"location2Text"]) {
        PostTextViewController* postTextViewController = [segue destinationViewController];
        postTextViewController.bLocationSelected = TRUE;
    }
}
@end
