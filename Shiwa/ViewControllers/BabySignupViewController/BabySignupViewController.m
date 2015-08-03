//
//  BabySignupViewController.m
//  Shiwa
//
//  Created by Xian on 7/30/15.
//  Copyright (c) 2015 Xian. All rights reserved.
//

#import "BabySignupViewController.h"
#import "ComboBoxView.h"

@interface BabySignupViewController () <ComboBoxViewDelegate>
@property (strong, nonatomic) IBOutlet ComboBoxView *year_comboBox;
@property (strong, nonatomic) IBOutlet ComboBoxView *month_comboBox;
@property (strong, nonatomic) IBOutlet ComboBoxView *day_comboBox;
@property (strong, nonatomic) IBOutlet ComboBoxView *provice_comboBox;
@property (strong, nonatomic) IBOutlet ComboBoxView *city_comboBox;
@property (strong, nonatomic) IBOutlet ComboBoxView *baby_yearcomboBox;
@property (strong, nonatomic) IBOutlet ComboBoxView *baby_monthcomboBox;
@property (strong, nonatomic) IBOutlet ComboBoxView *baby_daycomboBox;

@end

@implementation BabySignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //to change the status bar color to white
    [self.m_signupView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 920)];
    [self setNeedsStatusBarAppearanceUpdate];

    //keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldChange:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.m_NickName.borderStyle = UITextBorderStyleRoundedRect;
    self.m_UserEmail.borderStyle = UITextBorderStyleRoundedRect;
    self.m_babyName.borderStyle = UITextBorderStyleRoundedRect;
    
    NSMutableArray *yearvalues = [NSMutableArray array];
    for (int i = 1971; i <= 2015; i++)
    {
        NSString *year_string =[NSString stringWithFormat:@"%d年", i];
        [yearvalues addObject:year_string];
    }
    
    [self.year_comboBox setTitleColor:[UIColor blackColor]];
    [self.year_comboBox setPromptMessage:@"1970年"];
    [self.year_comboBox updateWithAvailableComboBoxItems:yearvalues];
//    [self.year_comboBox setComboBoxBorderColor:[UIColor grayColor]];
    [self.year_comboBox.layer setCornerRadius:5.0];
    [self.year_comboBox.layer setBorderWidth:1.0];
    
    [self.baby_yearcomboBox setTitleColor:[UIColor blackColor]];
    [self.baby_yearcomboBox setPromptMessage:@"1970年"];
    [self.baby_yearcomboBox updateWithAvailableComboBoxItems:yearvalues];
//    [self.baby_yearcomboBox setComboBoxBorderColor:[UIColor blackColor]];
    [self.baby_yearcomboBox.layer setCornerRadius:5.0];
    [self.baby_yearcomboBox.layer setBorderWidth:1.0];
//    [self.baby_yearcomboBox.layer setBorderColor:[UIColor blackColor].CGColor];
    
    NSMutableArray *monthvalues = [NSMutableArray array];
    for (int i = 2; i <= 12; i++)
    {
        NSString *month_string =[NSString stringWithFormat:@"%d月", i];
        [monthvalues addObject:month_string];
    }
    
    [self.month_comboBox setTitleColor:[UIColor blackColor]];
    [self.month_comboBox setPromptMessage:@"1月"];
    [self.month_comboBox updateWithAvailableComboBoxItems:monthvalues];
//    [self.month_comboBox setComboBoxBorderColor:[UIColor blackColor]];
    [self.month_comboBox.layer setCornerRadius:5.0];
    [self.month_comboBox.layer setBorderWidth:1.0];
//    [self.month_comboBox.layer setBorderColor:[UIColor blackColor].CGColor];
    
    [self.baby_monthcomboBox setTitleColor:[UIColor blackColor]];
    [self.baby_monthcomboBox setPromptMessage:@"1月"];
    [self.baby_monthcomboBox updateWithAvailableComboBoxItems:monthvalues];
//    [self.baby_monthcomboBox setComboBoxBorderColor:[UIColor blackColor]];
    [self.baby_monthcomboBox.layer setCornerRadius:5.0];
    [self.baby_monthcomboBox.layer setBorderWidth:1.0];
//    [self.baby_monthcomboBox.layer setBorderColor:[UIColor blackColor].CGColor];
    
    NSMutableArray *dayvalues = [NSMutableArray array];
    for (int i = 2; i <= 31; i++)
    {
        NSString *day_string =[NSString stringWithFormat:@"%d日", i];
        [dayvalues addObject:day_string];
    }
    
    [self.day_comboBox setTitleColor:[UIColor blackColor]];
    [self.day_comboBox setPromptMessage:@"1日"];
    [self.day_comboBox updateWithAvailableComboBoxItems:dayvalues];
//    [self.day_comboBox setComboBoxBorderColor:[UIColor blackColor]];
    [self.day_comboBox.layer setCornerRadius:5.0];
    [self.day_comboBox.layer setBorderWidth:1.0];
//    [self.day_comboBox.layer setBorderColor:[UIColor blackColor].CGColor];
    
    [self.baby_daycomboBox setTitleColor:[UIColor blackColor]];
    [self.baby_daycomboBox setPromptMessage:@"1日"];
    [self.baby_daycomboBox updateWithAvailableComboBoxItems:dayvalues];
//    [self.baby_daycomboBox setComboBoxBorderColor:[UIColor blackColor]];
    [self.baby_daycomboBox.layer setCornerRadius:5.0];
    [self.baby_daycomboBox.layer setBorderWidth:1.0];
//    [self.baby_daycomboBox.layer setBorderColor:[UIColor blackColor].CGColor];

    NSMutableArray *provincevalues = [NSMutableArray arrayWithObjects:@"上海", @"辽宁", nil];
    
    
    [self.provice_comboBox setTitleColor:[UIColor blackColor]];
    [self.provice_comboBox setPromptMessage:@"北京"];
    [self.provice_comboBox updateWithAvailableComboBoxItems:provincevalues];
//    [self.provice_comboBox setComboBoxBorderColor:[UIColor blackColor]];
    [self.provice_comboBox.layer setCornerRadius:5.0];
    [self.provice_comboBox.layer setBorderWidth:1.0];
//    [self.provice_comboBox.layer setBorderColor:[UIColor blackColor].CGColor];
    
    NSMutableArray *cityvalues = [NSMutableArray arrayWithObjects:@"通州", @"沈阳市", @"上海市", nil];
    
    
    [self.city_comboBox setTitleColor:[UIColor blackColor]];
    [self.city_comboBox setPromptMessage:@"朝阳"];
    [self.city_comboBox updateWithAvailableComboBoxItems:cityvalues];
//    [self.city_comboBox setComboBoxBorderColor:[UIColor blackColor]];
    [self.city_comboBox.layer setCornerRadius:5.0];
    [self.city_comboBox.layer setBorderWidth:1.0];
//    [self.city_comboBox.layer setBorderColor:[UIColor blackColor].CGColor];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ComboBoxViewDelegate Methods

- (void)expandedComboBoxView:(ComboBoxView *)comboBoxView
{
    
}

- (void)collapseComboBoxView:(ComboBoxView *)comboBoxView
{
    
}

- (void)selectedItemAtIndex:(NSInteger)selectedIndex fromComboBoxView:(ComboBoxView *)comboBoxView
{
    
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)animationView:(CGFloat)yPos {
    if(yPos == self.view.frame.origin.y)
        return;
    //	self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3
                     animations:^{
                         CGRect rt = self.view.frame;
                         rt.origin.y = yPos/* + 64*/;
                         self.view.frame = rt;
                     }completion:^(BOOL finished) {
                         //						 self.view.userInteractionEnabled = YES;
                     }];
}

#pragma mark - KeyBoard notifications
- (void)textFieldChange:(id)notification {
    NSString *nickName = self.m_NickName.text;
    NSString *babyName = self.m_babyName.text;
    NSString *emailAddress = self.m_UserEmail.text;
    
    if (![nickName isEqualToString:@""] && ![babyName isEqualToString:@""] && ![emailAddress isEqualToString:@""])
    {
        self.m_SignupButton.alpha = 1;
    }
    else
    {
        self.m_SignupButton.alpha = 0.5;
    }
}

- (void)keyboardWillShow:(NSNotification*)notify {
    
    [self animationView:0];
}

- (void)keyboardWillHide:(NSNotification*)notify {
    [self animationView:0];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.m_NickName) {
        [self.m_UserEmail becomeFirstResponder];
    }
    else if (textField == self.m_UserEmail) {
        [self.m_babyName becomeFirstResponder];
    }
    else if (textField == self.m_babyName) {
        [textField resignFirstResponder];
    }
    
    return YES;
}
@end
