//
//  OrganizationViewController.m
//  StuManagement
//
//  Created by MiY on 16/3/25.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "OrganizationViewController.h"
#import "OrganizationTableViewCell.h"
#import "CreateOrgViewController.h"
#import "OrganizationDetailViewController.h"
#import "MIYTableView.h"

@interface OrganizationViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *cellArray;

@end

@implementation OrganizationViewController

//- (NSMutableArray *)cellArray
//{
//    if (!_cellArray) {
//        _cellArray = [[NSMutableArray alloc] initWithCapacity:5];
//    }
//    return _cellArray;
//}

- (void)loadData
{
    UIImage *image1 = [UIImage imageNamed:@"shetuan111.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"shetuan222.jpg"];
    UIImage *image3 = [UIImage imageNamed:@"shetuan333.jpg"];

    self.cellArray = [@[@{ @"image":image1, @"name":@"闲云剧社", @"organization":@"计算机学院1", @"numberOfPeople":@"11" },
                        @{ @"image":image2, @"name":@"计算机科学与技术学院2", @"organization":@"计算机学院2", @"numberOfPeople":@"12" },
                        @{ @"image":image3, @"name":@"计算机科学与技术学院3", @"organization":@"计算机学院3", @"numberOfPeople":@"13" }] mutableCopy];
}

- (instancetype)init
{
    if (self = [super init]) {
        self.navigationItem.title = @"社团";
        [self loadData];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createOrganization)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self loadSubViews];
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
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UIButton *classifyButton = [[UIButton alloc] init];
    classifyButton.backgroundColor = [UIColor whiteColor];
    [classifyButton setTitle:@"分类" forState:UIControlStateNormal];
    [classifyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    classifyButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [headerView addSubview:classifyButton];
    
    UIButton *collegeButton = [[UIButton alloc] init];
    collegeButton.backgroundColor = [UIColor whiteColor];
    [collegeButton setTitle:@"学院" forState:UIControlStateNormal];
    [collegeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    collegeButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [headerView addSubview:collegeButton];
    
    UIView *verticalLine = [[UIView alloc] init];
    verticalLine.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:verticalLine];
    
    UIView *horizontaLine = [[UIView alloc] init];
    horizontaLine.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:horizontaLine];
    
    
    [headerView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.height.equalTo(40);
    }];
    
    [classifyButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(0);
        make.right.equalTo(headerView.centerX);
    }];
    
    [collegeButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(0);
        make.left.equalTo(headerView.centerX);
    }];
    
    [verticalLine makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(6);
        make.bottom.equalTo(-6);
        make.centerX.equalTo(0);
        make.width.equalTo(1);
    }];
    
    [horizontaLine makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(0);
        make.height.equalTo(0.5);
    }];

    
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.bottom);
        make.left.right.bottom.equalTo(0);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)createOrganization
{
    CreateOrgViewController *controller = [[CreateOrgViewController alloc] init];
    controller.title = @"新建社团";
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    OrganizationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[OrganizationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell loadData:self.cellArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrganizationDetailViewController *controller = [[OrganizationDetailViewController alloc] init];
    controller.title = self.cellArray[indexPath.row][@"name"];
    [self.navigationController pushViewController:controller animated:YES];
}

/*
  Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

@end
