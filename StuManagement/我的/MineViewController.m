//
//  MineViewController.m
//  StuManagement
//
//  Created by MiY on 16/3/25.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "MineViewController.h"
#import "MineSubViewController.h"

@interface MineViewController ()

@property (nonatomic, strong) UIImageView *backgroundImage;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation MineViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.navigationItem.title = @"我";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kLightWhiteColor;
    [self  loadSubViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)loadSubViews
{
    self.backgroundImage = [[UIImageView alloc] init];
    [self.backgroundImage loadImageWithUrl:@"http://img01.sogoucdn.com/app/a/100520093/3c28af542f2d49f7-da1566425074a021-9c373de8439e52c5d885c8459d285946.jpg"];
    [self.view addSubview:self.backgroundImage];
    [self.backgroundImage makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.height.equalTo(150);
    }];
    
    self.headImage = [[UIImageView alloc] init];
    [self.headImage loadImageWithUrl:@"http://img02.sogoucdn.com/app/a/100520093/33707f33b97c03ef-e989d519207501fc-417f0b65c0bd38f89fa860dc6e331204.jpg"];
    [self.view addSubview:self.headImage];
    [self.headImage makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundImage);
        make.centerY.equalTo(self.backgroundImage).offset(-10);
        make.size.equalTo(CGSizeMake(80, 80));
    }];
    [self makeView:self.headImage toRoundCorner:40 withWidth:0 color:0];
    
    //给头像添加单击手势
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeadImage)];
    gesture.numberOfTapsRequired = 1;
    [self.headImage addGestureRecognizer:gesture];
    
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = @"孙嘉晖";     //♀♂
    self.nameLabel.font = [UIFont systemFontOfSize:15.0];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.nameLabel];
    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImage.bottom).offset(7);
        make.centerX.equalTo(self.headImage);
    }];
    
    UIButton *activityButton = [[UIButton alloc] init];
    activityButton.backgroundColor = [UIColor whiteColor];
    activityButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [activityButton setTitle:@"我的活动" forState:UIControlStateNormal];
    [activityButton setTitleColor:kMainBlackColor forState:UIControlStateNormal];
    [self.view addSubview:activityButton];
    [activityButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(self.backgroundImage.bottom).offset(30);
        make.height.equalTo(50);
    }];
    
    UIButton *clanButton = [[UIButton alloc] init];
    clanButton.backgroundColor = [UIColor whiteColor];
    [clanButton setTitle:@"我的社团" forState:UIControlStateNormal];
    clanButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [clanButton setTitleColor:kMainBlackColor forState:UIControlStateNormal];
    [self.view addSubview:clanButton];
    [clanButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(activityButton.bottom).offset(1);
        make.height.equalTo(50);
    }];

    UIButton *collectionButton = [[UIButton alloc] init];
    collectionButton.backgroundColor = [UIColor whiteColor];
    [collectionButton setTitle:@"我的收藏" forState:UIControlStateNormal];
    collectionButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [collectionButton setTitleColor:kMainBlackColor forState:UIControlStateNormal];
    [self.view addSubview:collectionButton];
    [collectionButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(clanButton.bottom).offset(1);
        make.height.equalTo(50);
    }];

    UIButton *settingsButton = [[UIButton alloc] init];
    settingsButton.backgroundColor = [UIColor whiteColor];
    [settingsButton setTitle:@"设置" forState:UIControlStateNormal];
    settingsButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [settingsButton setTitleColor:kMainBlackColor forState:UIControlStateNormal];
    [self.view addSubview:settingsButton];
    [settingsButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(collectionButton.bottom).offset(15);
        make.height.equalTo(50);
    }];
    
    //设置按钮点击事件
    activityButton.tag = 0; clanButton.tag = 1; collectionButton.tag = 2; settingsButton.tag = 3;
    [activityButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [clanButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [collectionButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [settingsButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //以下设置文字和图片
    [self.view layoutIfNeeded];
    CGFloat gap = 60;
    [activityButton setTitleEdgeInsets:UIEdgeInsetsMake(0, gap, 0, ScreenWidth - gap - activityButton.titleLabel.frame.size.width)];
    [clanButton setTitleEdgeInsets:UIEdgeInsetsMake(0, gap, 0, ScreenWidth - gap - clanButton.titleLabel.frame.size.width)];
    [collectionButton setTitleEdgeInsets:UIEdgeInsetsMake(0, gap, 0, ScreenWidth - gap - collectionButton.titleLabel.frame.size.width)];
    [settingsButton setTitleEdgeInsets:UIEdgeInsetsMake(0, gap, 0, ScreenWidth - gap - settingsButton.titleLabel.frame.size.width)];
    
    UIImageView *image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wodehuodong"]];
    UIImageView *image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wodeshetuan"]];
    UIImageView *image3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wodeshoucang"]];
    UIImageView *image4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shezhi"]];
    [self.view addSubview:image1];
    [self.view addSubview:image2];
    [self.view addSubview:image3];
    [self.view addSubview:image4];
    [image1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(activityButton);
        make.size.equalTo(CGSizeMake(25, 25));
    }];
    [image2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image1);
        make.centerY.equalTo(clanButton);
        make.size.equalTo(image1);
    }];
    [image3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image1);
        make.centerY.equalTo(collectionButton);
        make.size.equalTo(image1);
    }];
    [image4 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image1);
        make.centerY.equalTo(settingsButton);
        make.size.equalTo(image1);
    }];
    
    UIImageView *image5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou"]];
    UIImageView *image6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou"]];
    UIImageView *image7 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou"]];
    UIImageView *image8 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou"]];
    [self.view addSubview:image5];
    [self.view addSubview:image6];
    [self.view addSubview:image7];
    [self.view addSubview:image8];
    [image5 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-10);
        make.centerY.equalTo(activityButton);
        make.width.height.equalTo(20);
    }];
    [image6 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(image5);
        make.centerY.equalTo(clanButton);
        make.width.height.equalTo(image5);
    }];
    [image7 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(image5);
        make.centerY.equalTo(collectionButton);
        make.width.height.equalTo(image5);
    }];
    [image8 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(image5);
        make.centerY.equalTo(settingsButton);
        make.width.height.equalTo(image5);
    }];
}


- (void)clickHeadImage
{
    
}

- (void)clickButton:(UIButton *)sender
{
    //=====
    if (sender.tag == 3) {
        return;
    }
    //=====
    MineSubViewController *controller = [[MineSubViewController alloc] init];
    switch (sender.tag) {
        case 0:
            controller.title = @"我的活动";
            controller.data = [self loadDataWithTag:sender.tag];
            break;
        case 1:
            controller.title = @"我的社团";
            controller.data = [self loadDataWithTag:sender.tag];
            break;
        case 2:
            controller.title = @"我的收藏";
            controller.allData = [self loadDataWithTag:sender.tag];
            break;
        case 3:
            controller.title = @"设置";
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:controller animated:YES];
}

- (NSMutableArray *)loadDataWithTag:(NSInteger)tag
{
    //活动
    UIImage *image1 = [UIImage imageNamed:@"huodong111.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"huodong222.jpg"];
    UIImage *image3 = [UIImage imageNamed:@"huodong333.jpg"];
    UIImage *image4 = [UIImage imageNamed:@"huodong444.jpg"];
    NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:3];
    [data addObject:[@[@{ @"image":image1, @"name":@"旁友，不一起去踏青吗？", @"time":@"3月30日0:00-13:00", @"yuanjixiaoji":@"院级", @"place":@"上方山森林公园", @"cost":@"免费", @"detail":@"最近天气好的很哪，我们踏青去。上方山百花节好！走出宿舍赏花去！上方山山上的露天“金光大佛”非常醒目，但原先到金光大佛的索道现已停运，游客可沿步道拾级而上，上方山海拔仅92米，徒步登山就当锻炼身体啦。宋代的楞枷塔则是上方山的地标和最高点，还有治平 寺、石湖草堂、乾隆御道等古迹。此外，这里也有孔雀园、各类植物园，并设有专门的拓展及烧烤场地。导览：从位于吴越路的北段的公园主入口进园，右前方是古 迹治平寺和石湖草堂，如果往右直走可到石佛寺、范成大祠以及北入口。从主入口往左走可依次到金光大佛、孔雀园、拓展基地，沿途还会经过几个大草坪和植物园，继续再往前走便可登上上方山参观楞枷塔。" },
                        @{ @"image":image2, @"name":@"零基础吉他教学体验", @"time":@"5月18日14:00-17:00", @"yuanjixiaoji":@"校级", @"place":@"校本部体操房", @"cost":@"150元", @"detail":@"——想一想，在一个晚会或年会上抱着吉他弹唱着拿手的歌，吸引无数羡慕的眼光不是很酷么。吉他是用来耍帅，泡妹子的一把好手，多少善男信女会为了你的认真送来瞻仰的目光。\n——再者作为一个零乐理入门级选手，作为玩票心态开始接触的选手表示，当你真正手指磨出茧弹出一段旋律时，你会觉得自己就是king of the world.然后就根本停不下来。\n\n活动安排：\n1、活动开始前老师会给大家介绍吉他的基本相关知识，以及吉他的基础和弦和指法。\n2、老师会不时给大家复习和弦的指法来测试学生的记忆和反应。\n3、老师给大家演绎弹唱，学生也可以跟着弹。活动体验结束有问题或者对吉他相关感兴趣的可以无限跟老师交流。\n\n提示：无须自备乐器，现场提供吉他。费用包括乐器使用费和教学费。" },
                        @{ @"image":image3, @"name":@"走，春游去！沉浸在草莓的乐园", @"time":@"4月20日13:00-17:00", @"yuanjixiaoji":@"院级", @"place":@"吴中区环湖路8号", @"cost":@"15元", @"detail":@"如今市面上的草莓大多是经由草莓贩子流通到市场，大棚直接零售的草莓越来越少，也更难见到新鲜采摘的草莓。而在农林大世界草莓园这里，你将沉浸在草莓的香甜世界——计算机学院生活部将组织同学们一起参观了解草莓种植，品尝新鲜草莓并亲手采摘带回家。个大味甜惹人爱，你会惊叹，原来草莓这样好吃！\n\n活动安排：\n13:00 本部北门集合，一同大巴前往目的地\n14:00 到达草莓园\n14:10 参观了解草莓种植\n14:30 采摘\n15:30 品尝草莓，休息\n16:00 回程，预计17:00回学校\n\n说明：本活动有巴士统一接送\n现场采摘每人可带走两斤草莓共30元，损耗费每位10元，多采摘可另付费（15元/斤）\n集合地点：学校本部北门" },
                        @{ @"image":image4, @"name":@"推挤碰撞！释放压力吧！泡泡足球！", @"time":@"4月16日14:00-16:00", @"yuanjixiaoji":@"校级", @"place":@"独墅湖体育馆草地", @"cost":@"80元", @"detail":@"风靡欧洲的泡泡足球来独墅湖啦！\n一种极具恶搞与娱乐精神的趣味游戏Bubble Soccer泡泡足球空降上海，参与者需上半身包裹在太空球里，只露出腿来进行奔跑踢球，可以尽情推挤碰撞释放压力，这里只有娱乐，不拼技术，翻滚碰撞就是规则，嗨翻自己就是冠军！\n\n泡泡足球起源于欧洲，是一种将球员包裹在透明塑料太空球里的足球比赛。因为玩泡泡足球不仅仅是进球，更是要撞翻你，萌翻你。球场上每个人都会被撞得东倒西歪，这绝对是一场没有“假摔”的比赛！\n\n双方队员进入充好气的太空球中进行足球拼抢，黄牌无效，碰撞有理，进球不是目的，撞翻对手才有意义。\n\n——你启动速度快？我摔跤姿势萌！\n——你脚下技术好？我摔跤姿势萌！\n——你门前感觉好？我摔跤姿势萌！\n——我……你赢了。\n\n快来参加萌翻全场的泡泡足球吧！没有红黄牌，没有犯规，进球是浮云，碰撞才是王道。开怀大笑，趣味横生。校学生会组织的活动，希望同学们尽情释放压力，结交新朋友！\n\n说明：\n活动时间：4月16日14:00-16:00和4月17日14:00-16:00\n请提前15分钟到场，活动准时开始\n地点：独墅湖体育馆草地\n费用：80元每人，现场收取。\n\n注意：请穿着运动装和运动鞋；请勿携带金属类的物品参与活动，如眼镜，耳环，戒指，项链等。" }] mutableCopy]];
    
    //社团
    UIImage *image11 = [UIImage imageNamed:@"shetuan111.jpg"];
    UIImage *image22 = [UIImage imageNamed:@"shetuan222.jpg"];
    UIImage *image33 = [UIImage imageNamed:@"shetuan333.jpg"];
    [data addObject:[@[@{ @"image":image11, @"name":@"闲云剧社", @"yuanjixiaoji":@"院级", @"time":@"2016-3-12", @"detail":@"描述：\n闲云剧社是隶属于苏州大学计算机科学与技术学院的一个四星级学生社团。成立于2006年，已经举办了各种话剧表演和比赛，既丰富了同学们的校园文化生活，又让同学们得到了很好的锻炼。欢迎各位话剧表演爱好者加入我们哦！做天地间一片悠然的咸鱼，让我们的梦想漫步云端。", @"notice":@"公告：\n注意啦注意啦，下次排练时间改为4月20日晚上7点，情人坡。请互相转告" },
                        @{ @"image":image22, @"name":@"计算机科学与技术学院团校", @"yuanjixiaoji":@"院级", @"time":@"2016-4-12", @"detail":@"描述：\n培养具有坚定的共产主义信仰，务实创新，勤于思考，勇于实践的社会主义事业的建设者和接班人。", @"notice":@"公告：\n本学期的党校培训班正在报名中，请各团支部将推荐名单直接报送给各年级辅导员老师且公平公正公开，在班级公示。" },
                        @{ @"image":image33, @"name":@"大学新闻", @"yuanjixiaoji":@"校级", @"time":@"2016-2-2", @"detail":@"描述：\n大学新闻诞生于1998年，以“为学生立言”为办报理念，着眼于校园内外各种现场，努力打造大学生主流媒体。目前是苏州大学发行量最高、传阅率最高的实力媒体。", @"notice":@"公告：\n大学新闻将于下周对熊校长进行专访，发送你的问题到大学新闻微信平台，你的提问可能被选中，听到熊校长的解答。" }] mutableCopy]];
    
    //新闻
    UIImage *image111 = [UIImage imageNamed:@"xinwen111.jpg"];
    UIImage *image222 = [UIImage imageNamed:@"xinwen222.jpg"];
    UIImage *image333 = [UIImage imageNamed:@"xinwen333.jpg"];

    [data addObject:[@[@{ @"image":image111, @"name":@"熊思东校长到纳米科学技术学院调研指导工作", @"yuanjixiaoji":@"院级", @"time":@"2016-3-12", @"detail":@"描述：\n闲云剧社是隶属于苏州大学计算机科学与技术学院的一个四星级学生社团。成立于2006年，已经举办了各种话剧表演和比赛，既丰富了同学们的校园文化生活，又让同学们得到了很好的锻炼。欢迎各位话剧表演爱好者加入我们哦！做天地间一片悠然的咸鱼，让我们的梦想漫步云端。", @"notice":@"公告：\n注意啦注意啦，下次排练时间改为4月20日晚上7点，情人坡。请互相转告" },
                       @{ @"image":image222, @"name":@"教务部：微课程（群）项目让大学课堂“活”起来", @"yuanjixiaoji":@"院级", @"time":@"2016-4-12", @"detail":@"描述：\n培养具有坚定的共产主义信仰，务实创新，勤于思考，勇于实践的社会主义事业的建设者和接班人。", @"notice":@"公告：\n本学期的党校培训班正在报名中，请各团支部将推荐名单直接报送给各年级辅导员老师且公平公正公开，在班级公示。" },
                       @{ @"image":image333, @"name":@"苏州大学—加拿大滑铁卢大学第三届学术论坛顺利举行", @"yuanjixiaoji":@"校级", @"time":@"2016-2-2", @"detail":@"描述：\n大学新闻诞生于1998年，以“为学生立言”为办报理念，着眼于校园内外各种现场，努力打造大学生主流媒体。目前是苏州大学发行量最高、传阅率最高的实力媒体。", @"notice":@"公告：\n大学新闻将于下周对熊校长进行专访，发送你的问题到大学新闻微信平台，你的提问可能被选中，听到熊校长的解答。" }] mutableCopy]];

    if (tag < 2) {
        return data[tag];
    } else {
        return data;
    }

}




@end
