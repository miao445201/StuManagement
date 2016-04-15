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
@property (nonatomic, strong) NSMutableArray *fixedData;

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *menuContainView;

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

    self.cellArray = [@[@{ @"image":image1, @"name":@"闲云剧社", @"yuanjixiaoji":@"院级", @"time":@"2016-3-12", @"detail":@"描述：\n闲云剧社是隶属于苏州大学计算机科学与技术学院的一个四星级学生社团。成立于2006年，已经举办了各种话剧表演和比赛，既丰富了同学们的校园文化生活，又让同学们得到了很好的锻炼。欢迎各位话剧表演爱好者加入我们哦！做天地间一片悠然的咸鱼，让我们的梦想漫步云端。", @"notice":@"公告：\n注意啦注意啦，下次排练时间改为4月20日晚上7点，情人坡。请互相转告" },
                        @{ @"image":image2, @"name":@"计算机科学与技术学院团校", @"yuanjixiaoji":@"院级", @"time":@"2016-4-12", @"detail":@"描述：\n培养具有坚定的共产主义信仰，务实创新，勤于思考，勇于实践的社会主义事业的建设者和接班人。", @"notice":@"公告：\n本学期的党校培训班正在报名中，请各团支部将推荐名单直接报送给各年级辅导员老师且公平公正公开，在班级公示。" },
                        @{ @"image":image3, @"name":@"大学新闻", @"yuanjixiaoji":@"校级", @"time":@"2016-2-2", @"detail":@"描述：\n大学新闻诞生于1998年，以“为学生立言”为办报理念，着眼于校园内外各种现场，努力打造大学生主流媒体。目前是苏州大学发行量最高、传阅率最高的实力媒体。", @"notice":@"公告：\n大学新闻将于下周对熊校长进行专访，发送你的问题到大学新闻微信平台，你的提问可能被选中，听到熊校长的解答。" }] mutableCopy];
    self.fixedData = [self.cellArray mutableCopy];
}

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _backgroundView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBackground)];
        gesture.numberOfTapsRequired = 1;
        [_backgroundView addGestureRecognizer:gesture];
    }
    return _backgroundView;
}

- (UIView *)menuContainView
{
    if (!_menuContainView) {
        _menuContainView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth-100-30, 0, 100, 80)];
        _menuContainView.backgroundColor = [UIColor lightGrayColor];
        _menuContainView.clipsToBounds = YES;
        
        UIButton *yuanji = [[UIButton alloc] init];
        yuanji.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        yuanji.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [yuanji setTitle:@"院级" forState:UIControlStateNormal];
        [_menuContainView addSubview:yuanji];
        [yuanji makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(0);
            make.height.equalTo(_menuContainView).multipliedBy(0.5);
        }];
        yuanji.tag = 1;
        [yuanji addTarget:self action:@selector(selectYuanxiao:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *xiaoji = [[UIButton alloc] init];
        xiaoji.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        xiaoji.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [xiaoji setTitle:@"校级" forState:UIControlStateNormal];
        [_menuContainView addSubview:xiaoji];
        [xiaoji makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(yuanji.bottom).offset(1);
            make.left.right.bottom.equalTo(0);
        }];
        xiaoji.tag = 2;
        [xiaoji addTarget:self action:@selector(selectYuanxiao:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _menuContainView;
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
    
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStylePlain target:self action:@selector(clickMenu)];
    //    [menuItem setImageInsets:UIEdgeInsetsMake(17, 30, 15, 0)];
    [menuItem setImageInsets:UIEdgeInsetsMake(7, 5, 5, 0)];
    
    menuItem.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createOrganization)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItems = @[ rightItem, menuItem ];
    
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
    
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.right.bottom.equalTo(0);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)selectYuanxiao:(UIButton *)sender
{
    self.cellArray = [self.fixedData mutableCopy];
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:3];
    if (sender.tag == 1) {  //院级
        for (NSDictionary *dict in self.cellArray) {
            if ([dict[@"yuanjixiaoji"] isEqualToString:@"校级"]) {
                [array addObject:dict];
            }
        }
    } else {        //校级
        for (NSDictionary *dict in self.cellArray) {
            if ([dict[@"yuanjixiaoji"] isEqualToString:@"院级"]) {
                [array addObject:dict];
            }
        }
    }
    [self.cellArray removeObjectsInArray:array];
    [self.tableView reloadData];
    [self clickBackground];
}

- (void)clickBackground
{
    [self.menuContainView removeFromSuperview];
    [self.backgroundView removeFromSuperview];
}

- (void)clickMenu
{
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.menuContainView];
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
    return 90.0;
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
    controller.data = [self.cellArray[indexPath.row] copy];
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
