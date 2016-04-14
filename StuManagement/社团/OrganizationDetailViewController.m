//
//  OrganizationDetailViewController.m
//  StuManagement
//
//  Created by MiY on 16/3/26.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "OrganizationDetailViewController.h"

@interface OrganizationDetailViewController ()

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *yuanjixiaojiLabel;
@property (nonatomic, strong) UILabel *noticeLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UIView *reasonView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UITextView *reasonTextView;

@property (nonatomic) BOOL isTyping;
@property (nonatomic) CGFloat keyboardHeight;
@end

@implementation OrganizationDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kLightWhiteColor;
    [self loadSubViews];
    [self registerForKeyboardNotifications];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

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

- (void)loadSubViews
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.equalTo(self.view);
    }];

    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:view1];
    [view1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.height.equalTo(150);
    }];
    
    self.logoImageView = [[UIImageView alloc] init];
    [view1 addSubview:self.logoImageView];
    [self.logoImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(20);
        make.size.equalTo(CGSizeMake(90, 90));
    }];

    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = self.title;
    [view1 addSubview:self.nameLabel];
    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageView).offset(5);
        make.left.equalTo(self.logoImageView.right).offset(15);
        make.right.equalTo(-15);
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(25);
    }];
    
    UIImageView *timeImage = [[UIImageView alloc] init];
    [view1 addSubview:timeImage];
    [timeImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.bottom).offset(10);
        make.size.equalTo(CGSizeMake(15, 15));
    }];
    
    self.timeLabel = [[UILabel alloc] init];
    [view1 addSubview:self.timeLabel];
    [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeImage.right).offset(8);
        make.centerY.equalTo(timeImage);
        make.right.height.equalTo(self.nameLabel);
    }];
    
    UIImageView *introductImage = [[UIImageView alloc] init];
    [introductImage setImage:[UIImage imageNamed:@"yuanjiyuanxiao"]];
    [view1 addSubview:introductImage];
    [introductImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeImage);
        make.top.equalTo(timeImage.bottom).offset(10);
        make.size.equalTo(timeImage);
    }];
    
    self.yuanjixiaojiLabel = [[UILabel alloc] init];
    [view1 addSubview:self.yuanjixiaojiLabel];
    [self.yuanjixiaojiLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.timeLabel);
        make.centerY.equalTo(introductImage);
    }];
    
    /*
    UILabel *noticeLeft = [[UILabel alloc] init];
    noticeLeft.text = @"公告:";
    [scrollView addSubview:noticeLeft];
    [noticeLeft makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1).offset(18);
        make.left.equalTo(20);
        make.width.equalTo(40);
    }];
    
    self.noticeLabel = [[UILabel alloc] init];
    self.noticeLabel.text = @"测试数据测试数据测试数据测试数据，测试数据测试数据测试数据测试数据。测试数据测试数据测试数据测试数据测试数据，测试数据测试数据测试数据";
    self.noticeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.noticeLabel.numberOfLines = 0;
    [scrollView addSubview:self.noticeLabel];
    [self.noticeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noticeLeft.bottom).equalTo(10);
        make.left.equalTo(noticeLeft.right).offset(-8);
        make.right.equalTo(-20);
    }];
    
    self.numberLabel = [[UILabel alloc] init];
    self.numberLabel.text = @"成员数:16";
    [scrollView addSubview:self.numberLabel];
    [self.numberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(noticeLeft);
        make.top.equalTo(self.noticeLabel.bottom).offset(30);
//        make.width.equalTo(200);
    }];

    [self addLineToSuperView:scrollView underView:self.numberLabel withGap:10];
    
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.noticeLabel).offset(1000);
    }];
    
    UIButton *likeButton = [[UIButton alloc] init];
    [likeButton setTitle:@"我喜欢" forState:UIControlStateNormal];
    [likeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    likeButton.backgroundColor = [UIColor redColor];
    [likeButton addTarget:self action:@selector(clickLike) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:likeButton];
    [likeButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(0);
        make.height.equalTo(50);
        make.right.equalTo(self.view.centerX);
    }];
    
    UIButton *applyButton = [[UIButton alloc] init];
    [applyButton setTitle:@"申请加入" forState:UIControlStateNormal];
    [applyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    applyButton.backgroundColor = [UIColor orangeColor];
    [applyButton addTarget:self action:@selector(clickApply) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:applyButton];
    [applyButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.centerX);
        make.right.bottom.equalTo(0);
        make.height.equalTo(likeButton);
    }];
    */
    [self loadData];
    
}

- (void)loadData
{
//    self.logoImageView.image = seld.data[@""];
}

- (void)clickLike
{
    
}

- (void)clickApply
{
    self.reasonView.alpha = 1.0;
    self.backgroundView.alpha = 1.0;
    self.reasonView.frame = CGRectMake(ScreenWidth/2, ScreenHeight/2-64, 0, 0);
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.reasonView];
    CGFloat width = 250;
    CGFloat height = 230;
    
    [UIView animateWithDuration:0.4
                          delay:0.1
         usingSpringWithDamping:0.7
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.reasonView.frame = CGRectMake((ScreenWidth-width)/2, (ScreenHeight-height)/2-64, width, height);
                     }
                     completion:nil];
}

- (UIView *)reasonView
{
    if (!_reasonView) {
        _reasonView = [[UIView alloc] init];
        _reasonView.clipsToBounds = YES;
        _reasonView.backgroundColor = [UIColor whiteColor];
        [self makeView:_reasonView toRoundCorner:5.0 withWidth:0 color:nil];

        UILabel *label = [[UILabel alloc] init];
        label.text = @"请输入理由";
        [_reasonView addSubview:label];
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(19);
        }];
        
        self.reasonTextView = [[UITextView alloc] init];
        [self makeView:self.reasonTextView toRoundCorner:5.0 withWidth:1.5 color:kMainProjColor];
        [_reasonView addSubview:self.reasonTextView];
        [self.reasonTextView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.right.equalTo(-15);
            make.height.equalTo(65);
            make.top.equalTo(label.bottom).offset(12);
        }];

        UIButton *okButton = [[UIButton alloc] init];
        okButton.backgroundColor = kMainProjColor;
        [okButton setTitle:@"确定" forState:UIControlStateNormal];
        [okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self makeView:okButton toRoundCorner:5.0 withWidth:0 color:nil];
        [okButton addTarget:self action:@selector(clickOk) forControlEvents:UIControlEventTouchUpInside];
        [_reasonView addSubview:okButton];
        [okButton makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.reasonTextView);
            make.height.equalTo(35);
            make.top.equalTo(self.reasonTextView.bottom).offset(12);
        }];
        
        UIButton *cancelButton = [[UIButton alloc] init];
        cancelButton.backgroundColor = kMainProjColor;
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self makeView:cancelButton toRoundCorner:5.0 withWidth:0 color:nil];
        [cancelButton addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
        [_reasonView addSubview:cancelButton];
        [cancelButton makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(okButton);
            make.top.equalTo(okButton.bottom).offset(8);
        }];


    }
    return _reasonView;
}

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundView)];
        gesture.numberOfTapsRequired = 1;
        [_backgroundView addGestureRecognizer:gesture];
    }
    return _backgroundView;
}

- (void)tapBackgroundView
{
    [self.reasonTextView resignFirstResponder];
    if (self.isTyping) {
        self.isTyping = NO;
    } else {
        [UIView animateWithDuration:0.4
                         animations:^{
                             self.reasonView.alpha = 0.0;
                             self.backgroundView.alpha = 0.0;
                         }
                         completion:^(BOOL isFinished) {
                             self.reasonView.frame = CGRectMake(ScreenWidth/2, ScreenHeight/2-100, 0, 0);
                             [self.backgroundView removeFromSuperview];
                             [self.reasonView removeFromSuperview];
                             self.reasonView = nil;
                         }];
    }
}

- (void)clickOk
{
    //do
    
    
    self.isTyping = NO;
    [self tapBackgroundView];
}

- (void)clickCancel
{
    self.isTyping = NO;
    [self tapBackgroundView];
}

- (void)checkReasonView
{
    CGFloat keyboardY = ScreenHeight - self.keyboardHeight;
    CGFloat viewBottonY = self.reasonView.frame.origin.y + self.reasonView.frame.size.height;
    if (keyboardY < viewBottonY + 20 + 64) {
        CGRect frame = self.reasonView.frame;
        frame.origin.y = keyboardY - 20 - frame.size.height - 64;
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.reasonView.frame = frame;
                         }];
    }
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.keyboardHeight = keyboardRect.size.height;
    self.isTyping = YES;
    [self checkReasonView];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    CGFloat width = 250;
    CGFloat height = 230;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.reasonView.frame = CGRectMake((ScreenWidth-width)/2, (ScreenHeight-height)/2 - 64, width, height);
                     }];
}

@end
