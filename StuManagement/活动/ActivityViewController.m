//
//  ActivityViewController.m
//  StuManagement
//
//  Created by MiY on 16/3/25.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityDetailViewController.h"
#import "ActivityPublicViewController.h"

@interface ActivityViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *cellArray;

@end

@implementation ActivityViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.navigationItem.title = @"活动";
        [self loadData];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kLightWhiteColor;
    
//    UIButton *menu = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    [menu setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
//    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithCustomView:menu];
    
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStylePlain target:self action:@selector(clickMenu)];
    [menuItem setImageInsets:UIEdgeInsetsMake(17, 30, 15, 0)];

    menuItem.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createActivity)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = @[ rightItem, menuItem ];
    
    [self loadSubViews];
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
    
    self.cellArray = [@[@{ @"image":image1, @"name":@"计算机科学与技术学院1", @"time":@"1月1日-1月12日" },
                        @{ @"image":image2, @"name":@"计算机科学与技术学院2", @"time":@"2月1日-2月12日" },
                        @{ @"image":image3, @"name":@"计算机科学与技术学院3", @"time":@"3月1日-3月12日" }] mutableCopy];
}

- (void)loadSubViews
{
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = kLightWhiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(5, 0, 0, 0));
    }];


}

- (void)clickMenu
{
    
}

- (void)createActivity
{
    ActivityPublicViewController *controller = [[ActivityPublicViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenWidth/2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[ActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell loadData:self.cellArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ActivityDetailViewController *controller = [[ActivityDetailViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end



#pragma mark - TableViewCell
@interface ActivityTableViewCell ()

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation ActivityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self loadSubViews];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)loadSubViews
{
    self.contentView.backgroundColor = kLightWhiteColor;
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    [view makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(5, 10, 5, 10));
    }];

    
    self.image = [[UIImageView alloc] init];
    [view addSubview:self.image];
    [self.image makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.bottom.equalTo(-25);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:13.0];
    self.titleLabel.textColor = [UIColor grayColor];
    self.titleLabel.text = @"米动四季跑春风赛周末送大奖";
    [view addSubview:self.titleLabel];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.image.bottom).offset(3);
        make.left.equalTo(10);
        make.bottom.equalTo(-2);
    }];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:12.0];
    self.timeLabel.textColor = [UIColor darkGrayColor];
    self.timeLabel.text = @"3月1日-3月12日";
    [view addSubview:self.timeLabel];
    [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-10);
        make.top.equalTo(self.image.bottom).offset(3);
        make.baseline.equalTo(self.titleLabel);
    }];

}

- (void)loadData:(NSDictionary *)data
{
    if (data) {
        [self.image setImage:data[@"image"]];
        self.titleLabel.text = data[@"name"];
        self.timeLabel.text = data[@"time"];
    }
}








@end


