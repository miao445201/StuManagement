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
    [self presentViewController:loginController animated:NO completion:nil];
    
    
    [self setNavigationTitle];
    self.navigationItem.leftBarButtonItem = nil;
//    self.navigationController.navigationBar.barTintColor = kMainProjColor;
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:kMainProjColor] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[self imageWithBgColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]]];

    [self initSubViews];
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



- (void)initSubViews
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
 
    ImageRollScrollView *imageRollView = [[ImageRollScrollView alloc] init];
    
    UIButton *activity = [[UIButton alloc] init];
    activity.backgroundColor = [UIColor redColor];
    [activity setTitle:@"活动" forState:UIControlStateNormal];
    [activity setImage:[UIImage imageNamed:@"huodong"] forState:UIControlStateNormal];
    
    UIButton *organization = [[UIButton alloc] init];
    organization.backgroundColor = [UIColor orangeColor];
    [organization setTitle:@"社团" forState:UIControlStateNormal];
    [organization setImage:[UIImage imageNamed:@"shetuan"] forState:UIControlStateNormal];
    
    UIButton *spotlight = [[UIButton alloc] init];
    spotlight.backgroundColor = [UIColor cyanColor];
    [spotlight setTitle:@"新闻" forState:UIControlStateNormal];
    [spotlight setImage:[UIImage imageNamed:@"xinwen"] forState:UIControlStateNormal];
    
    UIButton *weather = [[UIButton alloc] init];
    weather.backgroundColor = [UIColor greenColor];
    [weather setTitle:@"天气" forState:UIControlStateNormal];
    [weather setImage:[UIImage imageNamed:@"tianqi"] forState:UIControlStateNormal];
    
    UIButton *mine = [[UIButton alloc] init];
    mine.backgroundColor = [UIColor blueColor];
    [mine setTitle:@"我" forState:UIControlStateNormal];
    [mine setImage:[UIImage imageNamed:@"wo"] forState:UIControlStateNormal];
    
    NSArray *array = @[imageRollView, activity, organization, spotlight, weather, mine];
    for (UIButton *button in array) {
        [self makeView:button toRoundCorner:8 withWidth:0 color:nil];
    }
    
    [scrollView addSubview:imageRollView];
    [scrollView addSubview:activity];
    [scrollView addSubview:organization];
    [scrollView addSubview:spotlight];
    [scrollView addSubview:weather];
    [scrollView addSubview:mine];

    activity.tag = 1;
    organization.tag = 2;
    spotlight.tag = 3;
    mine.tag = 4;
    
    [activity addTarget:self action:@selector(pushToViewController:) forControlEvents:UIControlEventTouchUpInside];
    [organization addTarget:self action:@selector(pushToViewController:) forControlEvents:UIControlEventTouchUpInside];
    [spotlight addTarget:self action:@selector(pushToViewController:) forControlEvents:UIControlEventTouchUpInside];
    [mine addTarget:self action:@selector(pushToViewController:) forControlEvents:UIControlEventTouchUpInside];

    
    //layout
    NSInteger gap = 10;
    
    [imageRollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(gap);
        make.left.equalTo(gap);
        make.right.equalTo(-gap);
        make.height.equalTo(activity.width);
    }];

    [activity makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(gap);
        make.right.equalTo(self.view.centerX).offset(-gap/2);
        make.top.equalTo(imageRollView.bottom).offset(gap);
        make.height.equalTo(activity.width).offset(-40);
    }];
    
    [organization makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.centerX).offset(gap/2);
        make.right.equalTo(-gap);
        make.top.width.height.equalTo(activity);
    }];
    
    [spotlight makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(activity.bottom).offset(gap);
        make.left.equalTo(gap);
        make.width.equalTo(5*ScreenWidth/9);
        make.height.equalTo(activity);
    }];
    
    [weather makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(spotlight);
        make.left.equalTo(spotlight.right).offset(gap);
        make.right.equalTo(-gap);
        make.height.equalTo(activity);
    }];
    
    [mine makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(spotlight.bottom).offset(gap);
        make.left.equalTo(gap);
        make.right.equalTo(-gap);
        make.height.equalTo(activity);
    }];
    
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(mine.bottom).offset(gap).priorityLow();
        make.bottom.greaterThanOrEqualTo(self.view);
    }];
    
    UIImage *image1 = [UIImage imageNamed:@"xinwen111.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"xinwen222.jpg"];
    UIImage *image3 = [UIImage imageNamed:@"xinwen333.jpg"];
    NSArray *images = @[image1, image2, image3];
    NSArray *texts = @[@"我说今晚月亮好美", @"你说是的", @"写台词送给男生签名照"];
    
    [imageRollView loadImages:images withRollTime:3 optionalText:texts andContentMode:nil];
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
