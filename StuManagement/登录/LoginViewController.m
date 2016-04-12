//
//  LoginViewController.m
//  StuManagement
//
//  Created by MiY on 16/3/22.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong) UIButton *iamStudent;
@property (nonatomic, strong) UIButton *iamManager;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initSubViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)initSubViews
{
//    CGFloat scaleHeight = ScreenHeight/667.0;
//    CGFloat scaleWidth = ScreenWidth/375.0;
    
    //背景scrollview

    
    //背景
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"denglu111.jpg"]];
//    backgroundImage.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:backgroundImage];
    [backgroundImage makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    //logo
    UIImageView *logoImage = [[UIImageView alloc] init];
    logoImage.backgroundColor = [UIColor colorWithRed:249/255.0 green:75/255.0 blue:58/255.0 alpha:0.9];
    [self.view addSubview:logoImage];
    [logoImage makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(69);
        make.size.equalTo(CGSizeMake(90, 90));
        make.centerX.equalTo(self.view);
    }];
    
    //账号textfield
    UITextField *account = [[UITextField alloc] init];
    account.borderStyle = UITextBorderStyleNone;
    account.placeholder = @"请输入学号";
    account.backgroundColor = [kLightWhiteColor colorWithAlphaComponent:0.9];
    [self.view addSubview:account];
    [account makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(17);
        make.right.equalTo(self.view).offset(-17);
        make.top.equalTo(logoImage.bottom).offset(39);
        make.height.equalTo(43);
    }];
    UILabel *accountLeftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 58, 43)];
    accountLeftLabel.text = @"账号";
    accountLeftLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    accountLeftLabel.textAlignment = NSTextAlignmentCenter;
    account.leftView = accountLeftLabel;
    account.leftViewMode = UITextFieldViewModeAlways;
    
    //密码
    UITextField *password = [[UITextField alloc] init];
    password.borderStyle = UITextBorderStyleNone;
    password.placeholder = @"请输入密码";
    password.backgroundColor = [kLightWhiteColor colorWithAlphaComponent:0.9];
    [self.view addSubview:password];
    [password makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(account);
        make.right.equalTo(account);
        make.top.equalTo(account.bottom).offset(8);
        make.height.equalTo(account);
    }];
    UILabel *passwordLeftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 58, 43)];
    passwordLeftLabel.text = @"密码";
    passwordLeftLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    passwordLeftLabel.textAlignment = NSTextAlignmentCenter;
    password.leftView = passwordLeftLabel;
    password.leftViewMode = UITextFieldViewModeAlways;
    
    //我是学生
    self.iamStudent = [[UIButton alloc] init];
    self.iamStudent.layer.masksToBounds = YES;
    self.iamStudent.layer.cornerRadius = 5.0;
    self.iamStudent.layer.borderWidth = 1.5;
    self.iamStudent.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
    [self.iamStudent setTitle:@"我是学生" forState:UIControlStateNormal];
    [self.iamStudent setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.3] forState:UIControlStateNormal];
    self.iamStudent.backgroundColor = [kLightWhiteColor colorWithAlphaComponent:0.85];
    [self.view addSubview:self.iamStudent];
    [self.iamStudent makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(password.bottom).offset(10);
        make.left.equalTo(account);
        make.right.equalTo(self.view.centerX).offset(-10);
        make.height.equalTo(45);
    }];
    //我是管理员
    self.iamManager = [[UIButton alloc] init];
    self.iamManager.layer.masksToBounds = YES;
    self.iamManager.layer.cornerRadius = 5.0;
    self.iamManager.layer.borderWidth = 1.5;
    self.iamManager.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
    [self.iamManager setTitle:@"我是管理员" forState:UIControlStateNormal];
    [self.iamManager setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.3] forState:UIControlStateNormal];
    self.iamManager.backgroundColor = [kLightWhiteColor colorWithAlphaComponent:0.85];
    [self.view addSubview:self.iamManager];
    [self.iamManager makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iamStudent);
        make.left.equalTo(self.view.centerX).offset(10);
        make.right.equalTo(account);
        make.height.equalTo(45);
    }];
    [self.iamStudent addTarget:self action:@selector(changeUserType:) forControlEvents:UIControlEventTouchUpInside];
    [self.iamManager addTarget:self action:@selector(changeUserType:) forControlEvents:UIControlEventTouchUpInside];

    
    //登录按钮
    UIButton *loginButton = [[UIButton alloc] init];
    loginButton.layer.masksToBounds = YES;
    loginButton.layer.cornerRadius = 4.0;
    [loginButton setTitle:@"登 录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.backgroundColor = [UIColor colorWithRed:249/255.0 green:75/255.0 blue:58/255.0 alpha:0.9];
    [self.view addSubview:loginButton];
    [loginButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(account);
        make.right.equalTo(account);
        make.top.equalTo(self.iamStudent.bottom).offset(16);
        make.height.equalTo(45);
    }];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
}

- (void)changeUserType:(UIButton *)sender
{
    self.iamStudent.layer.borderWidth = 1.5;
    self.iamStudent.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
    [self.iamStudent setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.3] forState:UIControlStateNormal];
    self.iamStudent.backgroundColor = [kLightWhiteColor colorWithAlphaComponent:0.85];
    
    self.iamManager.layer.borderWidth = 1.5;
    self.iamManager.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
    [self.iamManager setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.3] forState:UIControlStateNormal];
    self.iamManager.backgroundColor = [kLightWhiteColor colorWithAlphaComponent:0.85];

    sender.layer.borderWidth = 0;
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.backgroundColor = [UIColor colorWithRed:249/255.0 green:75/255.0 blue:58/255.0 alpha:0.9];
}

- (void)login
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



@end
