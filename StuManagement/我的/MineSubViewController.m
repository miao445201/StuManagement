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
#import "ActivityDetailViewController.h"
#import "OrganizationDetailViewController.h"
#import "SpotlightViewController.h"

@interface MineSubViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic) NSInteger type;

@end

@implementation MineSubViewController

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kLightWhiteColor;
    [self loadSubViews];
    
    self.tableView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        // 进入刷新状态后会自动调用这个block
//        // [self.tableView.mj_header beginRefreshing]
//        // [self.tableView.mj_header endRefreshing];
//        NSRange range = NSMakeRange(3, self.data.count-3);
//        [self.data removeObjectsInRange:range];
//        [self.tableView reloadData];
        [self.tableView.mj_footer resetNoMoreData];
        [self.tableView.mj_header endRefreshing];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        // 进入刷新状态后会自动调用这个block
//        // [self.tableView.mj_footer resetNoMoreData];
//        // [self.tableView.mj_footer endRefreshingWithNoMoreData];
//        if (self.data.count > 10) {
//            [self.tableView.mj_footer endRefreshingWithNoMoreData];
//            return;
//        }
//        [self.data addObjectsFromArray:self.data];
//        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
    }];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
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
        self.data = self.allData[0];
        headerView = [[UIView alloc] init];
        headerView.backgroundColor = kLightWhiteColor;
        [self.view addSubview:headerView];
        [headerView makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(0);
            make.height.equalTo(40);
        }];
        
        UIButton *activityButton = [[UIButton alloc] init];
        [activityButton setTitle:@"活动" forState:UIControlStateNormal];
        [activityButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        activityButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [activityButton setTitleColor:kMainProjColor forState:UIControlStateNormal];
        [headerView addSubview:activityButton];
        [activityButton makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(0);
            make.width.equalTo(headerView).multipliedBy(0.33);
        }];

        UIButton *shetuanButton = [[UIButton alloc] init];
        [shetuanButton setTitle:@"社团" forState:UIControlStateNormal];
        [shetuanButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        shetuanButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [headerView addSubview:shetuanButton];
        [shetuanButton makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(0);
            make.left.equalTo(activityButton.right);
            make.width.equalTo(headerView).multipliedBy(0.34);
        }];

        UIButton *newsButton = [[UIButton alloc] init];
        [newsButton setTitle:@"新闻" forState:UIControlStateNormal];
        newsButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [newsButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [headerView addSubview:newsButton];
        [newsButton makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(0);
            make.left.equalTo(shetuanButton.right);
        }];

        self.type = 0;
        activityButton.tag = 0;
        shetuanButton.tag = 1;
        newsButton.tag = 2;

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
    self.data = self.allData[sender.tag];
    self.type = sender.tag;
    [self.tableView reloadData];
    
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
    return self.data.count;
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
    
    [cell loadData:self.data[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.title isEqualToString:@"我的活动"]) {
        ActivityDetailViewController *controller = [[ActivityDetailViewController alloc] init];
        controller.data = self.data[indexPath.row];
        controller.isFromMine = YES;
        [self.navigationController pushViewController:controller animated:YES];


    }  else if ([self.title isEqualToString:@"我的社团"]) {
        OrganizationDetailViewController *controller = [[OrganizationDetailViewController alloc] init];
        controller.data = self.data[indexPath.row];
        [self.navigationController pushViewController:controller animated:YES];

    } else {
        if (self.type == 0) {
            ActivityDetailViewController *controller = [[ActivityDetailViewController alloc] init];
            controller.data = self.data[indexPath.row];
            [self.navigationController pushViewController:controller animated:YES];

        } else if (self.type == 1) {
            OrganizationDetailViewController *controller = [[OrganizationDetailViewController alloc] init];
            controller.data = self.data[indexPath.row];
            [self.navigationController pushViewController:controller animated:YES];

        } else {
            SpotlightDetailController *controller = [[SpotlightDetailController alloc] init];
            controller.data = self.data[indexPath.row];
            [self.navigationController pushViewController:controller animated:YES];
        }

        
    }
    
}

@end
