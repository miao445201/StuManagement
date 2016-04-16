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
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *noticeLabel;

@property (nonatomic, strong) UIButton *applyButton;
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
    self.title = self.data[@"name"];
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
        make.width.equalTo(ScreenWidth);
        make.height.equalTo(120);
    }];
    
    self.logoImageView = [[UIImageView alloc] init];
    [view1 addSubview:self.logoImageView];
    [self.logoImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(15);
        make.bottom.equalTo(-15);
        make.width.equalTo(self.logoImageView.height);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:16.0 weight:0.4];
    [view1 addSubview:self.nameLabel];
    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageView).offset(5);
        make.left.equalTo(self.logoImageView.right).offset(15);
        make.right.equalTo(-15);
        make.height.equalTo(25);
    }];
    
    UIImageView *timeImage = [[UIImageView alloc] init];
    timeImage.image = [UIImage imageNamed:@"shijian"];
    [view1 addSubview:timeImage];
    [timeImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.bottom).offset(10);
        make.size.equalTo(CGSizeMake(15, 15));
    }];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:14];
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
    self.yuanjixiaojiLabel.font = [UIFont systemFontOfSize:14];
    [view1 addSubview:self.yuanjixiaojiLabel];
    [self.yuanjixiaojiLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.timeLabel);
        make.centerY.equalTo(introductImage);
    }];
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:view2];
    [view2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.bottom).offset(15);
        make.left.right.equalTo(0);
//        make.height.equalTo(120).priorityLow();
    }];
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.font = [UIFont systemFontOfSize:16.0];
    self.detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.detailLabel.numberOfLines = 0;
    [view2 addSubview:self.detailLabel];
    [self.detailLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.top.equalTo(15);
    }];
    
    [view2 makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.detailLabel).offset(15);
    }];
    
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:view3];
    [view3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2.bottom).offset(15);
        make.left.right.equalTo(0);
    }];
    
    self.noticeLabel = [[UILabel alloc] init];
    self.noticeLabel.font = [UIFont systemFontOfSize:16.0];
    self.noticeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.noticeLabel.numberOfLines = 0;
    [view3 addSubview:self.noticeLabel];
    [self.noticeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.top.equalTo(15);
    }];
    [view3 makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.noticeLabel).offset(15);
    }];
    
    
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view3).offset(50);
    }];
    
    
    UIButton *likeButton = [[UIButton alloc] init];
    [likeButton setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    [likeButton setImageEdgeInsets:UIEdgeInsetsMake(13, 40, 13, 60)];
    [likeButton setTitle:@"我喜欢" forState:UIControlStateNormal];
    [likeButton setTitleColor:kMainProjColor forState:UIControlStateNormal];
    likeButton.backgroundColor = [UIColor whiteColor];
    likeButton.selected = NO;
    [likeButton addTarget:self action:@selector(clickLike:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:likeButton];
    [likeButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(0);
        make.height.equalTo(50);
        make.right.equalTo(self.view.centerX);
    }];
    
    UIButton *applyButton = [[UIButton alloc] init];
    self.applyButton = applyButton;
    [applyButton setImage:[UIImage imageNamed:@"woyaobaoming"] forState:UIControlStateNormal];
    [applyButton setImageEdgeInsets:UIEdgeInsetsMake(13, 35, 13, 70)];
    [applyButton setTitle:@"我要报名" forState:UIControlStateNormal];
    [applyButton setTitleColor:kMainProjColor forState:UIControlStateNormal];
    applyButton.backgroundColor = [UIColor whiteColor];
    applyButton.selected = NO;
    [applyButton addTarget:self action:@selector(clickApply:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:applyButton];
    [applyButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.centerX);
        make.right.bottom.equalTo(0);
        make.height.equalTo(likeButton);
    }];
    
    [self loadData];
    
}

- (void)loadData
{
    self.nameLabel.text = self.data[@"name"];
    self.logoImageView.image = self.data[@"image"];
    self.timeLabel.text = self.data[@"time"];
    self.yuanjixiaojiLabel.text = self.data[@"yuanjixiaoji"];
    self.detailLabel.text = self.data[@"detail"];
    self.noticeLabel.text = self.data[@"notice"];
}

- (void)clickLike:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setTitle:@"已喜欢" forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"shoucangfilled"] forState:UIControlStateNormal];
        [self showHUDwithMessage:@"已喜欢" imageName:@"success.png"];
    } else {
        [sender setTitle:@"我喜欢" forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
        [self showHUDwithMessage:@"取消喜欢" imageName:@"success.png"];
    }
}

- (void)clickApply:(UIButton *)sender
{
    if (!sender.selected) {
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
    } else {
        sender.selected = NO;
        [sender setImage:[UIImage imageNamed:@"woyaobaoming"] forState:UIControlStateNormal];
        [sender setTitle:@"我要报名" forState:UIControlStateNormal];
        [self showHUDwithMessage:@"取消成功" imageName:@"success.png"];
    }
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
    self.applyButton.selected = YES;
    [self.applyButton setTitle:@"取消报名" forState:UIControlStateNormal];
    [self.applyButton setImage:[UIImage imageNamed:@"yibaodao"] forState:UIControlStateNormal];
    [self showHUDwithMessage:@"报名成功" imageName:@"success.png"];
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
