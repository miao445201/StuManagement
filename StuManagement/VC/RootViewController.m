//
//  RootViewController.m
//  StuManagement
//
//  Created by fitfun on 16/3/19.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "RootViewController.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)initSubViews
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.scrollView];
    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.equalTo(ScreenWidth);
        make.height.equalTo(ScreenHeight);
    }];

    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.scrollView addSubview:container];
    [container makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(ScreenWidth);
    }];
    
    UIView *newActivity = [[UIView alloc] init];
    [container addSubview:newActivity];
    container.backgroundColor = [UIColor redColor];
    [newActivity makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.left.equalTo(10);
        make.size.equalTo(CGSizeMake(100, 100));
    }];
    [container makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(newActivity);
    }];

}



@end
