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
@property (nonatomic, strong) UILabel *introductLabel;
@property (nonatomic, strong) UILabel *noticeLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UIView *reasonView;
@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation OrganizationDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadSubViews];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)loadSubViews
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.equalTo(self.view);
    }];

    
    self.logoImageView = [[UIImageView alloc] init];
    [scrollView addSubview:self.logoImageView];
    [self.logoImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(20);
        make.size.equalTo(CGSizeMake(90, 90));
    }];

    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = self.title;
    [scrollView addSubview:self.nameLabel];
    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageView).offset(5);
        make.left.equalTo(self.logoImageView.right).offset(15);
        make.right.equalTo(-15);
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(25);
    }];
    
    UIImageView *timeImage = [[UIImageView alloc] init];
    [scrollView addSubview:timeImage];
    [timeImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.bottom).offset(10);
        make.size.equalTo(CGSizeMake(15, 15));
    }];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.text = @"2016-01-01";
    [scrollView addSubview:self.timeLabel];
    [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeImage.right).offset(8);
        make.centerY.equalTo(timeImage);
        make.right.height.equalTo(self.nameLabel);
    }];
    
    UIImageView *introductImage = [[UIImageView alloc] init];
    [scrollView addSubview:introductImage];
    [introductImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeImage);
        make.top.equalTo(timeImage.bottom).offset(10);
        make.size.equalTo(timeImage);
    }];
    
    self.introductLabel = [[UILabel alloc] init];
    self.introductLabel.text = @"xxx";
    [scrollView addSubview:self.introductLabel];
    [self.introductLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.timeLabel);
        make.centerY.equalTo(introductImage);
    }];
    
    UIView *line1 = [self addLineToSuperView:scrollView underView:self.introductLabel withGap:30];
    
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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.16sucai.com/uploadfile/2013/0531/20130531094006354.jpg"]];
        NSData *data2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://cdns2.freepik.com/free-photo/circular-clock_318-25335.jpg"]];
        dispatch_async(dispatch_get_main_queue(), ^() {
            [self.logoImageView setImage:[UIImage imageWithData:data1]];
            [introductImage setImage:[UIImage imageWithData:data2]];
            [timeImage setImage:[UIImage imageWithData:data2]];
        });
    });
    
}

- (void)clickLike
{
    
}

- (void)clickApply
{
    self.reasonView.frame = CGRectMake(ScreenWidth/2, ScreenHeight/2-100, 0, 0);
    [self.view addSubview:self.reasonView];
    
    [UIView animateWithDuration:0.4
                          delay:0.1
         usingSpringWithDamping:0.6
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.reasonView.frame = CGRectMake(ScreenWidth/4, ScreenHeight/2-200, ScreenWidth/2, 200);
                     }
                     completion:nil];
}

- (UIView *)reasonView
{
    if (!_reasonView) {
        _reasonView = [[UIView alloc] init];
        _reasonView.backgroundColor = kMainProjColor;
    }
    return _reasonView;
}



@end
