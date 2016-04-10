//
//  MineSubViewController.m
//  StuManagement
//
//  Created by MiY on 16/4/10.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "MineSubViewController.h"
#import "MineSubTableViewCell.h"
#import "MJRefresh.h"

@interface MineSubViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *cellArray;
@property (nonatomic, strong) NSArray *buttons;

@end

@implementation MineSubViewController

- (instancetype)init
{
    if (self = [super init]) {
        [self loadData];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kLightWhiteColor;
    [self loadSubViews];
    
    self.tableView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        // [self.tableView.mj_header beginRefreshing]
        // [self.tableView.mj_header endRefreshing];
        NSRange range = NSMakeRange(3, self.cellArray.count-3);
        [self.cellArray removeObjectsInRange:range];
        [self.tableView reloadData];
        [self.tableView.mj_footer resetNoMoreData];
        [self.tableView.mj_header endRefreshing];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        // [self.tableView.mj_footer resetNoMoreData];
        // [self.tableView.mj_footer endRefreshingWithNoMoreData]
        if (self.cellArray.count > 10) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        [self.cellArray addObjectsFromArray:self.cellArray];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
    }];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)loadData
{
    UIImage *image1 = [UIImage imageNamed:@"1.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"2.jpg"];
    UIImage *image3 = [UIImage imageNamed:@"3.jpg"];
    
    self.cellArray = [@[@{ @"image":image1, @"name":@"计算机科学与技术学院1", @"time":@"计算机学院1", @"numberOfPeople":@"11" },
                        @{ @"image":image2, @"name":@"计算机科学与技术学院2", @"time":@"计算机学院2", @"numberOfPeople":@"12" },
                        @{ @"image":image3, @"name":@"计算机科学与技术学院3", @"time":@"计算机学院3", @"numberOfPeople":@"13" }] mutableCopy];
}


- (void)loadSubViews
{
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIView *headerView = nil;
    if ([self.title isEqualToString:@"我的收藏"]) {
        headerView = [[UIView alloc] init];
        headerView.backgroundColor = kLightWhiteColor;
        [self.view addSubview:headerView];
        [headerView makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(0);
            make.height.equalTo(40);
        }];
        
        UIButton *newsButton = [[UIButton alloc] init];
        [newsButton setTitle:@"新闻" forState:UIControlStateNormal];
        newsButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [newsButton setTitleColor:kMainProjColor forState:UIControlStateNormal];
        [headerView addSubview:newsButton];
        [newsButton makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(0);
            make.width.equalTo(headerView).multipliedBy(0.33);
        }];
        
        UIButton *activityButton = [[UIButton alloc] init];
        [activityButton setTitle:@"活动" forState:UIControlStateNormal];
        [activityButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        activityButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [headerView addSubview:activityButton];
        [activityButton makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(0);
            make.left.equalTo(newsButton.right);
            make.width.equalTo(headerView).multipliedBy(0.34);
        }];
        
        UIButton *shetuanButton = [[UIButton alloc] init];
        [shetuanButton setTitle:@"社团" forState:UIControlStateNormal];
        [shetuanButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        shetuanButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [headerView addSubview:shetuanButton];
        [shetuanButton makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(0);
            make.left.equalTo(activityButton.right);
        }];
        newsButton.tag = 0;
        activityButton.tag = 1;
        shetuanButton.tag = 2;
        [newsButton addTarget:self action:@selector(clickButtons:) forControlEvents:UIControlEventTouchUpInside];
        [activityButton addTarget:self action:@selector(clickButtons:) forControlEvents:UIControlEventTouchUpInside];
        [shetuanButton addTarget:self action:@selector(clickButtons:) forControlEvents:UIControlEventTouchUpInside];
        
        self.buttons = @[newsButton, activityButton, shetuanButton];
    }
    
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        if (headerView) {
            make.top.equalTo(headerView.bottom);
        } else {
            make.top.equalTo(0);
        }
        make.left.right.bottom.equalTo(0);
    }];

}

- (void)clickButtons:(UIButton *)sender
{
    for (UIButton *button in self.buttons) {
        if ([button isEqual:sender]) {
            [sender setTitleColor:kMainProjColor forState:UIControlStateNormal];
        } else {
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    MineSubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[MineSubTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell loadData:self.cellArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
