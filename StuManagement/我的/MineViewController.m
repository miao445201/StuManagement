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
    UIImage *image444 = [UIImage imageNamed:@"xinwen444.jpg"];
    [data addObject:[@[
                       @{ @"image":image111, @"name":@"熊思东校长到纳米科学技术学院调研指导工作", @"time":@"2016-3-12", @"content":@"\t3月29日下午，熊思东校长来到纳米科学技术学院调研并指导工作。校长办公室主任曹健陪同调研。纳米科学技术学院领导班子成员、全体教授参加了座谈会。\n\n\t座谈会上，李述汤院士详细汇报了纳米科学技术学院和功能纳米与软物质研究院的整体概况。 作为国家首批17所“试点学院”之一，纳米科学技术学院围绕师资队伍建设、人才培养模式、学生招录方式、内部治理结构开展了一系列改革工作，在学科建设、 人才培养、科学研究、社会服务等方面取得了丰硕成果。针对学院在“十三五”期间进一步凝聚力量，突出优势，迈向国际一流的战略目标，李院士分析了存在问 题，提出了具体措施和建议。\n\n\t熊思东对纳米科学技术学院各方面的工作给予了高度评价，并表示将继续大力支持学院特色发展。他指出，纳米科学技术学院有坚实的基础，“十三五”期间要站在提高国内、国际影响力的角度上，不拘泥于称号和排名，进一步提升整体水平。\n\n\t熊思东表示，希望纳米科学技术学院在全球范围内吸引高端人才，充分发挥高水平团队的学术 优势，形成1+1>2的倍增效应；在推进纳米新兴学科建设的过程中，进一步开拓思路，做出具有开创性意义的工作；人才培养方面要积极探索自主招生的 科学方法，以国际化视野选拔和培养人才，全面开展高水平的国际合作与交流；同时面向国家和区域重大需求，通过协同创新中心的建设，大力推动科技成果的转 化，增强服务地方经济的能力。" },
                       @{ @"image":image222, @"name":@"教务部：微课程（群）项目让大学课堂“活”起来", @"time":@"2016-4-12", @"content":@"\t为了更扎实推进“苏大课程-3I工程”项目的建设，日前，教务部与教师教学发展中心共同 开展了“基于翻转课堂的微课程（群）项目”教师研修坊活动，邀请南京师范大学张一春教授来校作专题讲座“基于翻转课堂的微课设计”，同时邀请技术团队面对 面指导立项教师自主开展微课视频的制作。\n\n\t研修坊活动中，老师们就“微课程的设计、微视频的制作以及翻转课堂的有效组织”等问题进行了深入研讨，第一批微课程（群）项目试点的几位教师代表还分享了他们的经验，让大家感受到了大学课堂应有的“活力”。\n\n\t教育学院的李利老师利用学校网络教学平台课程中心的“进阶式学习”功能布置课前学习任 务，包括学习视频和小测验。李老师精心设计小测验中的问题，一方面可以引起学生对于视频学习内容的思考，另一方面也作为课堂上开展深入讨论的引子，将课前 自主学习与课堂讨论紧密联系起来。医学部的张增利老师则采用课前将学习视频上传至班级QQ群的方式来布置学习任务，同时每个视频都配有《课前学习任务书》 来指导学生的自主学习，课堂上先通过“提问”或“课前测验”的方式来检验课前学习效果，再进一步通过分组讨论和汇报、自由发言等形式来引导学生围绕知识点 展开讨论、深入思考。\n\n\t医学部的陆叶老师在课堂上采用的是“教师引导、小组交流、相互提问、个别交流”的方式。 陆老师在微课视频中预设了一些问题，并引导学生如何去查找相关资料、关注学科前沿。课堂上小组交流时既可以讨论预设问题，也可以自己提出问题；小组之间互 相提问，还可以现场提问老师；对于不爱开口的学生，老师进行个别交流。材料与化学化工学部的赵蓓老师是把翻转课堂的教学活动分为了两种形式，一种是“下任 务、答题目、知识点的应用、理重点、释难点、师生和生生互动”，另一种是“课前分组学习、人人写小论文、合力做PPT，课上小组汇报，小组间提问和讨 论”，根据每次翻转的教学内容的特点灵活选用。\n\n\t医学部的王大慧老师试点的课程是实验类课程，“一视、二看、三仿、四做”是王老师设计的基于微课的实验课程教学模式，通过将实验演示的过程录制成微课视频让学生在课前预习，课前安排实验仿作环节，课上每个小组派出一名代表进行组间PK，极大地激发了学生的学习热情。\n\n\t作为开展课程改革的重要举措，“苏大课程-3I工程”自2014年启动，通过对新生研讨课、通识选修课、网络进阶式课程、微课程（群）项目、全英文教学示范课等几类课程项目的建设，将课程改革的新思想、新理念应用于实践，落实在课堂。到目前为止，已立项65个微课程（群）项目并全面开展课堂教学模式的改革试点。\n\n\t翻转课堂是信息技术融入教学改革的又一体现，它改变了传统的大学课堂形式，赋予学生更多的自由——把知识传授的过程放在课外，让学生选择最适合自己的方式接受新知识，而把知识内化的过程放在课内，以便同学之间、学生和教师之间有更多的沟通和交流。\n\n\t翻转课堂无固定模式，不同学科采取的教学方式不同，但它也具备一些典型的特点。例如在翻 转课堂中，教师不再单单是课程内容的传授者，更多地变为学习过程的指导者与促进者;学生从被动的内容接受者变为学习活动的主体;教学组织形式从“课堂授课 听讲+课后完成作业”转变为“课前自主学习+课堂协作探究”;课堂内容变为辅导答疑、讨论交流、小组协作等;技术起到的作用是为自主学习和协作探究提供方 便的学习资源和互动工具;评价方式呈现多层次、多维度等。\n\n\t交流活动中，老师们纷纷表示，翻转课堂这种教学模式适合大学生的学习，值得推广。教师可 以通过技术手段对学生的学习数据进行分析，了解到每一位学生的学习状况，随时调整教学策略，有针对性地开展课堂教学活动，从而提高教学效果。同时也能改变 了学生的学习习惯，培养其自主学习和合作学习的能力。\n\n\t新颖的课堂教学形式也得到了很多学生的认可。例如，有同学在课程意见反馈中这样写道： “翻转课堂这种教学模式，让我们不再只是一味地被动接受，课堂上老师有更多地时间与我们交流、解答疑问，大大提高了学习效果。微课视频短小精悍、设计精 良，学习起来目标明确，无论是课前的自主学习，还是课后查缺补漏，效果都不错。这是一项很有意义的改革，希望可以继续进行下去。”" },
                       @{ @"image":image333, @"name":@"FUNSOM研究院李述汤院士、廖良生教授应邀为Nature Reviews Materials撰写评论文章", @"time":@"2016-2-2", @"content":@"\t近日，我校FUNSOM研究院李述汤院士、廖良生教授应邀为《Nature Reviews Materials》撰写的评论文章“Materials science in China”（Nat. Rev. Mater., 2016, 1, 16025.）正式在线发表。这是我校的科研人员首次在“Nature Reviews”系列期刊上发表评论文章（第一单位，第一作者）。\n\n\t《Nature Reviews Materials》是Nature出版集团继《Nature Reviews Cancer》（IF=37.4）、《Nature Reviews Drug Discovery》（IF=41.908）、《Nature Reviews Molecular Cell Biology》（IF=37.806）等系列综述期刊后，于今年创刊的材料科学领域首个综述性期刊。该期刊专门发表材料科学与技术领域的综述、展望与评 论文章。据悉，该期刊中的评论文章旨在针对材料科学领域的热点问题和发展趋势提出权威性见解。\n\n\t进入本世纪以来，中国经济不断强大，使得世人对中国材料科学与技术的发展给予了越来越多 的关注。此次李述汤院士和廖良生教授应邀针对我国材料科学15年来的发展状况，从优势、挑战和展望三方面进行了精辟论述，认为我国高瞻远瞩的科研政策、不 断完善的研究平台、高层次的人才计划以及庞大的国内市场是中国材料科学与技术近年来飞速发展的推动力；并且相信我国材料科技人员终将站在世界科技前沿，为我国乃至世界的经济发展做出重要贡献。通过《Nature Reviews Materials》这一重要窗口在科学界向世人介绍中国材料科学与技术的发展，具有重要意义。" },
                       @{ @"image":image444, @"name":@"苏州大学—加拿大滑铁卢大学第三届学术论坛顺利举行", @"time":@"2016-1-2", @"content":@"\t日前，苏州大学—加拿大滑铁卢大学第三届学术论坛在独墅湖校区举行。我校副校长蒋星红、 加拿大滑铁卢大学校长Feridun Hamdullahpur出席论坛开幕式。滑铁卢大学以及我校药学、材料学、化学、物理学等领域近40名教师和学生代表出席论坛。开幕式由我校药学院院长 镇学初主持。\n\n\t蒋星红代表学校向滑铁卢大学代表团来访表示热烈欢迎，简要介绍了苏州大学在学科建设中取 得的成绩，回顾了苏州大学与滑铁卢大学的合作历程。她指出，两校有着优良的合作传统，合作领域从最初纳米学科推展到物理、材料学、化学、药学等多个学科， 未来希望双方能精诚合作取得更好的合作成果，并预祝论坛取得圆满成功。\n\n\t滑铁卢大学校长Feridun Hamdullahpur教授和理学院院长Robert Lemieux教授先后发言。他们对此次论坛的举办表示祝贺，并希望通过此次论坛能使两校间的联系更加紧密，未来能有更多广泛和深入的合作。\n\n\t会上，滑铁卢大学和苏州大学的教师为本次论坛精心准备了17场精彩的学术报告。两校学者还就新型太阳能电池研发、功能材料的合成、基因治疗安全性研究、抗癌药物研发、新型纳米载体药物研究、神经退行性疾病治疗新靶点的发现等各领域前沿学术问题进行了积极的探讨。" }] mutableCopy]];

    if (tag < 2) {
        return data[tag];
    } else {
        return data;
    }

}




@end
