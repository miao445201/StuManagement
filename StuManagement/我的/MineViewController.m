//
//  MineViewController.m
//  StuManagement
//
//  Created by MiY on 16/3/25.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "MineViewController.h"
#import "MineSubViewController.h"

@interface MineViewController ()

@property (nonatomic, strong) UIImageView *backgroundImage;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation MineViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.navigationItem.title = @"我";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kLightWhiteColor;
    [self  loadSubViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)loadSubViews
{
    self.backgroundImage = [[UIImageView alloc] init];
    [self.backgroundImage loadImageWithUrl:@"http://img01.sogoucdn.com/app/a/100520093/3c28af542f2d49f7-da1566425074a021-9c373de8439e52c5d885c8459d285946.jpg"];
    [self.view addSubview:self.backgroundImage];
    [self.backgroundImage makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.height.equalTo(150);
    }];
    
    self.headImage = [[UIImageView alloc] init];
    [self.headImage loadImageWithUrl:@"http://img02.sogoucdn.com/app/a/100520093/33707f33b97c03ef-e989d519207501fc-417f0b65c0bd38f89fa860dc6e331204.jpg"];
    [self.view addSubview:self.headImage];
    [self.headImage makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundImage);
        make.centerY.equalTo(self.backgroundImage).offset(-10);
        make.size.equalTo(CGSizeMake(80, 80));
    }];
    [self makeView:self.headImage toRoundCorner:40 withWidth:0 color:0];
    
    //给头像添加单击手势
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeadImage)];
    gesture.numberOfTapsRequired = 1;
    [self.headImage addGestureRecognizer:gesture];
    
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = @"孙嘉晖";     //♀♂
    self.nameLabel.font = [UIFont systemFontOfSize:15.0];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.nameLabel];
    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImage.bottom).offset(7);
        make.centerX.equalTo(self.headImage);
    }];
    
    UIButton *activityButton = [[UIButton alloc] init];
    activityButton.backgroundColor = [UIColor whiteColor];
    activityButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [activityButton setTitle:@"我的活动" forState:UIControlStateNormal];
    [activityButton setTitleColor:kMainBlackColor forState:UIControlStateNormal];
    [self.view addSubview:activityButton];
    [activityButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(self.backgroundImage.bottom).offset(30);
        make.height.equalTo(50);
    }];
    
    UIButton *clanButton = [[UIButton alloc] init];
    clanButton.backgroundColor = [UIColor whiteColor];
    [clanButton setTitle:@"我的社团" forState:UIControlStateNormal];
    clanButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [clanButton setTitleColor:kMainBlackColor forState:UIControlStateNormal];
    [self.view addSubview:clanButton];
    [clanButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(activityButton.bottom).offset(1);
        make.height.equalTo(50);
    }];

    UIButton *collectionButton = [[UIButton alloc] init];
    collectionButton.backgroundColor = [UIColor whiteColor];
    [collectionButton setTitle:@"我的收藏" forState:UIControlStateNormal];
    collectionButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [collectionButton setTitleColor:kMainBlackColor forState:UIControlStateNormal];
    [self.view addSubview:collectionButton];
    [collectionButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(clanButton.bottom).offset(1);
        make.height.equalTo(50);
    }];

    UIButton *settingsButton = [[UIButton alloc] init];
    settingsButton.backgroundColor = [UIColor whiteColor];
    [settingsButton setTitle:@"设置" forState:UIControlStateNormal];
    settingsButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [settingsButton setTitleColor:kMainBlackColor forState:UIControlStateNormal];
    [self.view addSubview:settingsButton];
    [settingsButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(collectionButton.bottom).offset(15);
        make.height.equalTo(50);
    }];
    
    //设置按钮点击事件
    activityButton.tag = 0; clanButton.tag = 1; collectionButton.tag = 2; settingsButton.tag = 3;
    [activityButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [clanButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [collectionButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [settingsButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //以下设置文字和图片
    [self.view layoutIfNeeded];
    CGFloat gap = 60;
    [activityButton setTitleEdgeInsets:UIEdgeInsetsMake(0, gap, 0, ScreenWidth - gap - activityButton.titleLabel.frame.size.width)];
    [clanButton setTitleEdgeInsets:UIEdgeInsetsMake(0, gap, 0, ScreenWidth - gap - clanButton.titleLabel.frame.size.width)];
    [collectionButton setTitleEdgeInsets:UIEdgeInsetsMake(0, gap, 0, ScreenWidth - gap - collectionButton.titleLabel.frame.size.width)];
    [settingsButton setTitleEdgeInsets:UIEdgeInsetsMake(0, gap, 0, ScreenWidth - gap - settingsButton.titleLabel.frame.size.width)];
    
    UIImageView *image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wodehuodong"]];
    UIImageView *image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wodeshetuan"]];
    UIImageView *image3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wodeshoucang"]];
    UIImageView *image4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shezhi"]];
    [self.view addSubview:image1];
    [self.view addSubview:image2];
    [self.view addSubview:image3];
    [self.view addSubview:image4];
    [image1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(activityButton);
        make.size.equalTo(CGSizeMake(25, 25));
    }];
    [image2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image1);
        make.centerY.equalTo(clanButton);
        make.size.equalTo(image1);
    }];
    [image3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image1);
        make.centerY.equalTo(collectionButton);
        make.size.equalTo(image1);
    }];
    [image4 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image1);
        make.centerY.equalTo(settingsButton);
        make.size.equalTo(image1);
    }];
    
    UIImageView *image5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou"]];
    UIImageView *image6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou"]];
    UIImageView *image7 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou"]];
    UIImageView *image8 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou"]];
    [self.view addSubview:image5];
    [self.view addSubview:image6];
    [self.view addSubview:image7];
    [self.view addSubview:image8];
    [image5 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-10);
        make.centerY.equalTo(activityButton);
        make.width.height.equalTo(20);
    }];
    [image6 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(image5);
        make.centerY.equalTo(clanButton);
        make.width.height.equalTo(image5);
    }];
    [image7 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(image5);
        make.centerY.equalTo(collectionButton);
        make.width.height.equalTo(image5);
    }];
    [image8 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(image5);
        make.centerY.equalTo(settingsButton);
        make.width.height.equalTo(image5);
    }];
}


- (void)clickHeadImage
{
    
}

- (void)clickButton:(UIButton *)sender
{
    //=====
    if (sender.tag == 3) {
        return;
    }
    //=====
    MineSubViewController *controller = [[MineSubViewController alloc] init];
    switch (sender.tag) {
        case 0:
            controller.title = @"我的活动";
            break;
        case 1:
            controller.title = @"我的社团";
            break;
        case 2:
            controller.title = @"我的收藏";
            break;
        case 3:
            controller.title = @"设置";
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:controller animated:YES];
}






@end
