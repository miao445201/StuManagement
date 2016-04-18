//
//  RootViewController.m
//  StuManagement
//
//  Created by fitfun on 16/3/19.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"
#import "ImageRollScrollView.h"
#import "ActivityViewController.h"
#import "OrganizationViewController.h"
#import "SpotlightViewController.h"
#import "MineViewController.h"

@interface RootViewController () <UIScrollViewDelegate> {
    UIScrollView *customScrollView;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation RootViewController

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    LoginViewController *loginController = [[LoginViewController alloc] init];
    [self presentViewController:loginController animated:NO completion:^{
        [self setNavigationTitle];
        self.navigationItem.leftBarButtonItem = nil;
        //    self.navigationController.navigationBar.barTintColor = kMainProjColor;
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:kMainProjColor] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[self imageWithBgColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]]];
        [self loadSubViews];
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)setNavigationTitle
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:now];
    NSDictionary *weekDict = @{ @1:@"星期天", @2:@"星期一", @3:@"星期二", @4:@"星期三", @5:@"星期四", @6:@"星期五", @7:@"星期六" };
    
    self.navigationItem.title = [NSString stringWithFormat:@"%ld月%ld日 %@", (long)[comps month], (long)[comps day], weekDict[[NSNumber numberWithInteger:[comps weekday]]]];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                    NSFontAttributeName : [UIFont boldSystemFontOfSize:19]};
//    self.preferredStatusBarStyle = UIStatusBarStyleLightContent;
}



- (void)loadSubViews
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = kLightWhiteColor;
    [self.view addSubview:scrollView];
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
 
    NSInteger gap = 10;
    
    //11111111
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:view1];
    [view1 makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(ScreenWidth);
        make.top.left.right.equalTo(0);
        make.height.equalTo(ScreenWidth/1.8);
    }];
    
    ImageRollScrollView *imageRollView = [[ImageRollScrollView alloc] init];
    [view1 addSubview:imageRollView];
    [imageRollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(gap, gap, gap, gap));
    }];

    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:view2];
    [view2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.bottom).offset(2*gap);
        make.left.right.equalTo(0);
        make.height.equalTo(ScreenWidth/1.9);
    }];
    
    UIImageView *image111 = [[UIImageView alloc] init];
    image111.image = [UIImage imageNamed:@"huodong"];
    image111.contentMode = UIViewContentModeScaleToFill;
    [view2 addSubview:image111];
    UIButton *activity = [[UIButton alloc] init];
    [view2 addSubview:activity];
    [activity makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view2.centerX).multipliedBy(0.5);
        make.top.equalTo(2*gap);
        make.width.equalTo(activity.height);
        make.bottom.equalTo(-4*gap);
    }];
    [image111 makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(activity);
    }];
    
    UILabel *huodongLabel = [[UILabel alloc] init];
    huodongLabel.text = @"活动";
    huodongLabel.font = [UIFont systemFontOfSize:16.0];
    huodongLabel.textAlignment = NSTextAlignmentCenter;
    huodongLabel.textColor = kMainBlackColor;
    [view2 addSubview:huodongLabel];
    [huodongLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-gap);
        make.centerX.equalTo(activity);
    }];
    
    UIView *verticalLine = [[UIView alloc] init];
    verticalLine.backgroundColor = kLightWhiteColor;
    [view2 addSubview:verticalLine];
    [verticalLine makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.centerX.equalTo(0);
        make.width.equalTo(1.5);
    }];
    

    UIImageView *image222 = [[UIImageView alloc] init];
    image222.image = [UIImage imageNamed:@"shetuan"];
    image222.contentMode = UIViewContentModeScaleToFill;
    [view2 addSubview:image222];
    UIButton *organization = [[UIButton alloc] init];
//    organization.backgroundColor = [UIColor orangeColor];
    [view2 addSubview:organization];
    [organization makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(gap);
        make.right.equalTo(-gap);
        make.bottom.equalTo(view2.centerY).offset(-gap);
    }];
    UILabel *shetuanLabel = [[UILabel alloc] init];
    shetuanLabel.text = @"社团";
    shetuanLabel.font = [UIFont systemFontOfSize:16.0];
    shetuanLabel.textAlignment = NSTextAlignmentCenter;
    shetuanLabel.textColor = kMainBlackColor;
    [view2 addSubview:shetuanLabel];
    [shetuanLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(verticalLine).offset(2*gap);
        make.centerY.equalTo(organization);
    }];
    [organization makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shetuanLabel.right).offset(gap);
    }];
    [image222 makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(organization);
    }];

    UIView *line = [[UIView alloc] init];
    line.backgroundColor = kLightWhiteColor;
    [view2 addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view2.centerX);
        make.right.equalTo(0);
        make.centerY.equalTo(0);
        make.height.equalTo(1.5);
    }];

    UIImageView *image333 = [[UIImageView alloc] init];
    image333.image = [UIImage imageNamed:@"xinwen"];
    image333.contentMode = UIViewContentModeScaleToFill;
    [view2 addSubview:image333];
    UIButton *spotlight = [[UIButton alloc] init];
//    spotlight.backgroundColor = [UIColor cyanColor];
    [view2 addSubview:spotlight];
    [spotlight makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2.centerY).offset(gap);
        make.bottom.equalTo(-gap);
        make.right.equalTo(-gap);
    }];
    UILabel *xinwenLabel = [[UILabel alloc] init];
    xinwenLabel.text = @"新闻";
    xinwenLabel.font = [UIFont systemFontOfSize:16.0];
    xinwenLabel.textAlignment = NSTextAlignmentCenter;
    xinwenLabel.textColor = kMainBlackColor;
    [view2 addSubview:xinwenLabel];
    [xinwenLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(verticalLine).offset(2*gap);
        make.centerY.equalTo(spotlight);
    }];
    [spotlight makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(xinwenLabel.right).offset(gap);
    }];
    [image333 makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(spotlight);
    }];
    
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:view3];
    [view3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2.bottom).offset(1);
        make.left.right.equalTo(0);
        make.height.equalTo(ScreenWidth/2.4);
    }];

    UIImageView *image444 = [[UIImageView alloc] init];
    image444.image = [UIImage imageNamed:@"wo"];
    image444.contentMode = UIViewContentModeScaleToFill;
    [view3 addSubview:image444];
    UIButton *mine = [[UIButton alloc] init];
//    mine.backgroundColor = [UIColor blueColor];
    [view3 addSubview:mine];
    [mine makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(gap);
        make.left.equalTo(2*gap);
        make.bottom.equalTo(-gap);
    }];
    UILabel *woLabel =[[UILabel alloc] init];
    woLabel.text = @"我";
    woLabel.font = [UIFont systemFontOfSize:16.0];
    woLabel.textAlignment = NSTextAlignmentCenter;
    woLabel.textColor = kMainBlackColor;
    [view3 addSubview:woLabel];
    [woLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-4*gap);
        make.centerY.equalTo(mine);
        make.width.equalTo(woLabel.height);
    }];
    [mine makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(woLabel.left).offset(-3*gap);
    }];
    [image444 makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(mine);
    }];

    
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view3).offset(3*gap);
    }];

//    NSArray *array = @[imageRollView, activity, organization, spotlight, weather, mine];
//    for (UIButton *button in array) {
//        [self makeView:button toRoundCorner:8 withWidth:0 color:nil];
//    }
    
    [self.view layoutIfNeeded];
    [self makeView:image111 toRoundCorner:image111.frame.size.height/2 withWidth:0 color:nil];
    
    activity.tag = 1;
    organization.tag = 2;
    spotlight.tag = 3;
    mine.tag = 4;
    
    [activity addTarget:self action:@selector(pushToViewController:) forControlEvents:UIControlEventTouchUpInside];
    [organization addTarget:self action:@selector(pushToViewController:) forControlEvents:UIControlEventTouchUpInside];
    [spotlight addTarget:self action:@selector(pushToViewController:) forControlEvents:UIControlEventTouchUpInside];
    [mine addTarget:self action:@selector(pushToViewController:) forControlEvents:UIControlEventTouchUpInside];


    UIImage *image1 = [UIImage imageNamed:@"xinwen111.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"xinwen222.jpg"];
    UIImage *image3 = [UIImage imageNamed:@"xinwen333.jpg"];
    NSArray *images = @[image1, image2, image3];
//    NSArray *texts = @[@"我说今晚月亮好美", @"你说是的", @"写台词送给男生签名照"];
    
    [imageRollView loadImages:images withRollTime:3 optionalText:nil andContentMode:nil];
}

- (void)pushToViewController:(UIButton *)sender
{
    UIViewController *controller = nil;
    switch (sender.tag) {
        case 1:
            controller = [[ActivityViewController alloc] init];
            break;
        case 2:
            controller = [[OrganizationViewController alloc] init];
            break;
        case 3:
            controller = [[SpotlightViewController alloc] init];
            break;
        case 4:
            controller = [[MineViewController alloc] init];
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:controller animated:YES];
}

@end
