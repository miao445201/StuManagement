//
//  CreateOrgViewController.m
//  StuManagement
//
//  Created by MiY on 16/3/26.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "CreateOrgViewController.h"

@interface CreateOrgViewController () <UITextViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UIButton *logoImageButton;
@property (nonatomic, strong) UITextView *introductionTextView;
@property (nonatomic, strong) UITextView *noticeTextView;
@property (nonatomic) CGFloat keyboardHeight;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation CreateOrgViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setRightNaviItemWithTitle:@"提交申请" OrImageName:nil];
    [self loadSubViews];
    [self addTapGestureToRemoveKeyboard];
    [self registerForKeyboardNotifications];

}

- (void)rightItemTapped
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:@"确认提交创建申请?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消"
                                              style:UIAlertActionStyleDefault
                                            handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action) {
                                                [self showHUDwithMessage:@"已提交申请" imageName:@"success.png"];
                                                [self.navigationController popViewControllerAnimated:YES];
                                            }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)loadSubViews
{
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.equalTo(self.view);
    }];

    self.nameTextField = [[UITextField alloc] init];
    UILabel *nameLeftLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 80, 43)];
    nameLeftLabel.text = @"社团名称:";
    nameLeftLabel.textColor = [UIColor lightGrayColor];
    nameLeftLabel.textAlignment = NSTextAlignmentCenter;
    self.nameTextField.leftView = nameLeftLabel;
    self.nameTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.scrollView addSubview:self.nameTextField];
    
    UILabel *logoLabel = [[UILabel alloc] init];
    logoLabel.text = @"社团logo:";
    logoLabel.textColor = [UIColor lightGrayColor];
    logoLabel.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:logoLabel];
    
    self.logoImageButton = [[UIButton alloc] init];
    self.logoImageButton.backgroundColor = [UIColor magentaColor];
    [self.logoImageButton setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    [self.scrollView addSubview:self.logoImageButton];
    
    UILabel *introductionLabel = [[UILabel alloc] init];
    introductionLabel.text = @"社团介绍:";
    introductionLabel.textColor = [UIColor lightGrayColor];
    introductionLabel.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:introductionLabel];
    
    self.introductionTextView = [[UITextView alloc] init];
    self.introductionTextView.backgroundColor = [UIColor whiteColor];
    self.introductionTextView.delegate = self;
    [self.scrollView addSubview:self.introductionTextView];
    
    UILabel *noticeLabel = [[UILabel alloc] init];
    noticeLabel.text = @"公告:";
    noticeLabel.textColor = [UIColor lightGrayColor];
    noticeLabel.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:noticeLabel];
    
    self.noticeTextView = [[UITextView alloc] init];
    self.noticeTextView.backgroundColor = [UIColor whiteColor];
    self.noticeTextView.delegate = self;
    [self.scrollView addSubview:self.noticeTextView];

    
    [self.nameTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.height.equalTo(43);
        make.width.equalTo(self.view.width);
    }];
   
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:line1];
    [line1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(self.nameTextField.bottom).offset(5);
        make.height.equalTo(0.5);
    }];
    
    [logoLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(self.scrollView.left).offset(80);
        make.top.equalTo(self.nameTextField.bottom).offset(5);
        make.height.equalTo(30);
    }];
    
    [self.logoImageButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoLabel.bottom).offset(5);
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(100, 100));
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:line2];
    [line2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(self.logoImageButton.bottom).offset(30);
        make.height.equalTo(0.5);
    }];
    
    
    
    [introductionLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageButton.bottom).offset(35);
        make.left.right.height.equalTo(logoLabel);
    }];
    
    [self.introductionTextView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(introductionLabel.bottom).offset(5);
        make.right.equalTo(-15);
        make.height.equalTo(150);
    }];
    
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:line3];
    [line3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(self.introductionTextView.bottom).offset(10);
        make.height.equalTo(0.5);
    }];
    
    [noticeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(logoLabel);
        make.top.equalTo(self.introductionTextView.bottom).offset(15);
    }];
    
    [self.noticeTextView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.introductionTextView);
        make.top.equalTo(noticeLabel.bottom).offset(5);
        make.height.equalTo(80);
    }];
    
    
    UIView *line4 = [[UIView alloc] init];
    line4.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:line4];
    [line4 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(self.noticeTextView.bottom).offset(10);
        make.height.equalTo(0.5);
    }];
    
    UIButton *whetherPremium = [[UIButton alloc] init];
    [whetherPremium setTitle:@"是否收费" forState:UIControlStateNormal];
    [whetherPremium setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [whetherPremium setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 250)];
    whetherPremium.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.scrollView addSubview:whetherPremium];
    [whetherPremium makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.right.equalTo(0);
        make.top.equalTo(self.noticeTextView.bottom).offset(10);
        make.height.equalTo(self.nameTextField);
    }];

    UIView *line5 = [[UIView alloc] init];
    line5.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:line5];
    [line5 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(whetherPremium.bottom);
        make.height.equalTo(0.5);
    }];

    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(whetherPremium).offset(80);
    }];

}

//根据键盘高度重置把view往上移
- (void)setViewMovedUp:(BOOL)movedUp
{
    UITextView *textView = nil;
    if ([self.introductionTextView isFirstResponder]) {
        textView = self.introductionTextView;
    } else if ([self.noticeTextView isFirstResponder]) {
        textView = self.noticeTextView;
    }
    
    CGFloat upHeight = 0;
    if (ScreenHeight - self.keyboardHeight > textView.frame.origin.y + textView.frame.size.height + 120) {
        upHeight = 0;
    } else {
        upHeight = textView.frame.origin.y + textView.frame.size.height - (ScreenHeight - self.keyboardHeight) + 120;
    }
    
    if (movedUp) {
        [self.scrollView setContentOffset:CGPointMake(0, upHeight) animated:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }

    
}
//添加收回键盘的手势
- (void)addTapGestureToRemoveKeyboard
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchScrollView)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:recognizer];
    
}
//收回键盘手势的target
- (void)touchScrollView
{
    [self.introductionTextView resignFirstResponder];
    [self.noticeTextView resignFirstResponder];
}

//=========================获取键盘高度=======================
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}
//键盘弹出同事改变offset
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.keyboardHeight = keyboardRect.size.height;
    [self setViewMovedUp:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [self setViewMovedUp:NO];
}
//==========================================================

#pragma mark - UITextView Delegate Methods
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView       //开始输入前
{
//    [self setViewMovedUp:YES];       //点击textview改变offset
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text      //输入中
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];        //当输入回车时，去除第一响应者
        return NO;
    }
    
    return YES;
}

- (void)showHUDwithMessage:(NSString *)message imageName:(NSString *)imageName
{
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithWindow:window];
    [window addSubview:progressHUD];
    [window bringSubviewToFront:progressHUD];
    progressHUD.userInteractionEnabled = NO;
    
    if (imageName) {
        progressHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        progressHUD.mode = MBProgressHUDModeCustomView;
    }
    
    progressHUD.labelText = message;
    [progressHUD show:YES];
    [progressHUD hide:YES afterDelay:2];
}


@end
