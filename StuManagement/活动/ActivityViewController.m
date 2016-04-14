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

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *menuContainView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *cellArray;
@property (nonatomic, strong) NSMutableArray *fixedData;

@end

@implementation ActivityViewController

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
//    [menuItem setImageInsets:UIEdgeInsetsMake(17, 30, 15, 0)];
    [menuItem setImageInsets:UIEdgeInsetsMake(7, 5, 5, 0)];

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
    UIImage *image1 = [UIImage imageNamed:@"huodong111.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"huodong222.jpg"];
    UIImage *image3 = [UIImage imageNamed:@"huodong333.jpg"];
    UIImage *image4 = [UIImage imageNamed:@"huodong444.jpg"];
    
    self.cellArray = [@[@{ @"image":image1, @"title":@"旁友，不一起去踏青吗？", @"time":@"3月30日0:00-13:00", @"yuanjixiaoji":@"院级", @"place":@"上方山森林公园", @"cost":@"免费", @"detail":@"最近天气好的很哪，我们踏青去。上方山百花节好！走出宿舍赏花去！上方山山上的露天“金光大佛”非常醒目，但原先到金光大佛的索道现已停运，游客可沿步道拾级而上，上方山海拔仅92米，徒步登山就当锻炼身体啦。宋代的楞枷塔则是上方山的地标和最高点，还有治平 寺、石湖草堂、乾隆御道等古迹。此外，这里也有孔雀园、各类植物园，并设有专门的拓展及烧烤场地。导览：从位于吴越路的北段的公园主入口进园，右前方是古 迹治平寺和石湖草堂，如果往右直走可到石佛寺、范成大祠以及北入口。从主入口往左走可依次到金光大佛、孔雀园、拓展基地，沿途还会经过几个大草坪和植物园，继续再往前走便可登上上方山参观楞枷塔。" },
                   @{ @"image":image2, @"title":@"零基础吉他教学体验", @"time":@"5月18日14:00-17:00", @"yuanjixiaoji":@"校级", @"place":@"校本部体操房", @"cost":@"150元", @"detail":@"——想一想，在一个晚会或年会上抱着吉他弹唱着拿手的歌，吸引无数羡慕的眼光不是很酷么。吉他是用来耍帅，泡妹子的一把好手，多少善男信女会为了你的认真送来瞻仰的目光。\n——再者作为一个零乐理入门级选手，作为玩票心态开始接触的选手表示，当你真正手指磨出茧弹出一段旋律时，你会觉得自己就是king of the world.然后就根本停不下来。\n\n活动安排：\n1、活动开始前老师会给大家介绍吉他的基本相关知识，以及吉他的基础和弦和指法。\n2、老师会不时给大家复习和弦的指法来测试学生的记忆和反应。\n3、老师给大家演绎弹唱，学生也可以跟着弹。活动体验结束有问题或者对吉他相关感兴趣的可以无限跟老师交流。\n\n提示：无须自备乐器，现场提供吉他。费用包括乐器使用费和教学费。" },
                   @{ @"image":image3, @"title":@"走，春游去！沉浸在草莓的乐园", @"time":@"4月20日13:00-17:00", @"yuanjixiaoji":@"院级", @"place":@"吴中区环湖路8号", @"cost":@"15元", @"detail":@"如今市面上的草莓大多是经由草莓贩子流通到市场，大棚直接零售的草莓越来越少，也更难见到新鲜采摘的草莓。而在农林大世界草莓园这里，你将沉浸在草莓的香甜世界——计算机学院生活部将组织同学们一起参观了解草莓种植，品尝新鲜草莓并亲手采摘带回家。个大味甜惹人爱，你会惊叹，原来草莓这样好吃！\n\n活动安排：\n13:00 本部北门集合，一同大巴前往目的地\n14:00 到达草莓园\n14:10 参观了解草莓种植\n14:30 采摘\n15:30 品尝草莓，休息\n16:00 回程，预计17:00回学校\n\n说明：本活动有巴士统一接送\n现场采摘每人可带走两斤草莓共30元，损耗费每位10元，多采摘可另付费（15元/斤）\n集合地点：学校本部北门" },
                   @{ @"image":image4, @"title":@"推挤碰撞！释放压力吧！泡泡足球！", @"time":@"4月16日14:00-16:00", @"yuanjixiaoji":@"校级", @"place":@"独墅湖体育馆草地", @"cost":@"80元", @"detail":@"风靡欧洲的泡泡足球来独墅湖啦！\n一种极具恶搞与娱乐精神的趣味游戏Bubble Soccer泡泡足球空降上海，参与者需上半身包裹在太空球里，只露出腿来进行奔跑踢球，可以尽情推挤碰撞释放压力，这里只有娱乐，不拼技术，翻滚碰撞就是规则，嗨翻自己就是冠军！\n\n泡泡足球起源于欧洲，是一种将球员包裹在透明塑料太空球里的足球比赛。因为玩泡泡足球不仅仅是进球，更是要撞翻你，萌翻你。球场上每个人都会被撞得东倒西歪，这绝对是一场没有“假摔”的比赛！\n\n双方队员进入充好气的太空球中进行足球拼抢，黄牌无效，碰撞有理，进球不是目的，撞翻对手才有意义。\n\n——你启动速度快？我摔跤姿势萌！\n——你脚下技术好？我摔跤姿势萌！\n——你门前感觉好？我摔跤姿势萌！\n——我……你赢了。\n\n快来参加萌翻全场的泡泡足球吧！没有红黄牌，没有犯规，进球是浮云，碰撞才是王道。开怀大笑，趣味横生。校学生会组织的活动，希望同学们尽情释放压力，结交新朋友！\n\n说明：\n活动时间：4月16日14:00-16:00和4月17日14:00-16:00\n请提前15分钟到场，活动准时开始\n地点：独墅湖体育馆草地\n费用：80元每人，现场收取。\n\n注意：请穿着运动装和运动鞋；请勿携带金属类的物品参与活动，如眼镜，耳环，戒指，项链等。" }] mutableCopy];
    
    self.fixedData = [self.cellArray mutableCopy];
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
    return ScreenWidth/1.5;
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
    controller.data = self.cellArray[indexPath.row];
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
        self.titleLabel.text = data[@"title"];
        self.timeLabel.text = data[@"time"];
    }
}

@end


