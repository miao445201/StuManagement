//
//  RootViewController.m
//  StuManagement
//
//  Created by fitfun on 16/3/19.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "RootViewController.h"
#import "ImageRollScrollView.h"

@interface RootViewController () <UIScrollViewDelegate> {
    UIScrollView *customScrollView;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation RootViewController

- (instancetype)init
{
    if (self = [super init]) {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *now = [NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
        NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        comps = [calendar components:unitFlags fromDate:now];
        NSDictionary *weekDict = @{ @1:@"星期天", @2:@"星期一", @3:@"星期二", @4:@"星期三", @5:@"星期四", @6:@"星期五", @7:@"星期六" };
        
        self.navigationItem.title = [NSString stringWithFormat:@"%ld月%ld日 %@", (long)[comps month], (long)[comps day], weekDict[[NSNumber numberWithInteger:[comps weekday]]]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    
    [self initSubViews];
//    [self testScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)testScrollView
{

}

- (void)initSubViews
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor clearColor];
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
 
    ImageRollScrollView *imageRollView = [[ImageRollScrollView alloc] init];
    [scrollView addSubview:imageRollView];
    
    UIButton *activity = [[UIButton alloc] init];
    [scrollView addSubview:activity];
    activity.backgroundColor = [UIColor redColor];
    
    UIButton *organization = [[UIButton alloc] init];
    [scrollView addSubview:organization];
    organization.backgroundColor = [UIColor orangeColor];

    UIButton *spotlight = [[UIButton alloc] init];
    [scrollView addSubview:spotlight];
    spotlight.backgroundColor = [UIColor yellowColor];

    UIButton *weather = [[UIButton alloc] init];
    [scrollView addSubview:weather];
    weather.backgroundColor = [UIColor greenColor];

    UIButton *user = [[UIButton alloc] init];
    [scrollView addSubview:user];
    user.backgroundColor = [UIColor blueColor];
    
    NSArray *array = @[imageRollView, activity, organization, spotlight, weather, user];
    for (UIButton *button in array) {
        [self makeView:button toRoundCorner:8];
    }
    
    
    //layout
    NSInteger gap = 10;
    
    [imageRollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(gap);
        make.left.equalTo(gap);
        make.right.equalTo(-gap);
        make.height.equalTo(activity);
    }];

    [activity makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(gap);
        make.right.equalTo(self.view.centerX).offset(-gap/2);
        make.top.equalTo(imageRollView.bottom).offset(gap);
        make.height.equalTo(activity.width);
    }];
    
    [organization makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.centerX).offset(gap/2);
        make.right.equalTo(-gap);
        make.top.equalTo(activity);
        make.width.equalTo(activity);
        make.height.equalTo(organization.width);
    }];
    
    [spotlight makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(activity.bottom).offset(gap);
        make.left.equalTo(gap);
        make.width.equalTo(5*ScreenWidth/9);
        make.height.equalTo(weather);
    }];
    
    [weather makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(spotlight);
        make.left.equalTo(spotlight.right).offset(gap);
        make.right.equalTo(-gap);
        make.height.equalTo(weather.width);
    }];
    
    [user makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(spotlight.bottom).offset(gap);
        make.left.equalTo(gap);
        make.right.equalTo(-gap);
        make.height.equalTo(weather);
    }];
    
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(user.bottom).offset(gap).priorityLow();
        make.bottom.greaterThanOrEqualTo(self.view);
    }];
    
    UIImage *image1 = [UIImage imageNamed:@"1.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"2.jpg"];
    UIImage *image3 = [UIImage imageNamed:@"3.jpg"];
    NSArray *images = @[image1, image2, image3];
    NSArray *texts = @[@"我说今晚月亮好美", @"你说是的", @"写台词送给男生签名照"];
    
    [imageRollView loadImages:images withRollTime:3 optionalText:texts];
}

- (void)makeView:(UIView *)view toRoundCorner:(CGFloat)radius
{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = radius;
}

/*
 http://g.hiphotos.baidu.com/image/h%3D200/sign=5f57c95eda54564efa65e33983de9cde/38dbb6fd5266d0161f276b65902bd40735fa3544.jpg
 http://img2.imgtn.bdimg.com/it/u=836165302,2546919370&fm=21&gp=0.jpg
 http://img3.imgtn.bdimg.com/it/u=197157313,1549247420&fm=21&gp=0.jpg
 */
- (UIImage *)imageFromURLString:(NSString *)urlstring
{
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlstring]]];
}  

@end
