//
//  SpotlightViewController.m
//  StuManagement
//
//  Created by MiY on 16/3/25.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "SpotlightViewController.h"
#import "ActivityDetailViewController.h"

@interface SpotlightViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *cellArray;

@end

@implementation SpotlightViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.navigationItem.title = @"新闻";
        [self loadData];
    }
    return self;
}

- (void)loadData
{

    UIImage *image1 = [UIImage imageNamed:@"xinwen111.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"xinwen222.jpg"];
    UIImage *image3 = [UIImage imageNamed:@"xinwen333.jpg"];
    UIImage *image4 = [UIImage imageNamed:@"xinwen444.jpg"];
    
    self.cellArray = [@[
                        @{ @"image":image1, @"name":@"熊思东校长到纳米科学技术学院调研指导工作", @"time":@"2016-3-12", @"content":@"\t3月29日下午，熊思东校长来到纳米科学技术学院调研并指导工作。校长办公室主任曹健陪同调研。纳米科学技术学院领导班子成员、全体教授参加了座谈会。\n\n\t座谈会上，李述汤院士详细汇报了纳米科学技术学院和功能纳米与软物质研究院的整体概况。 作为国家首批17所“试点学院”之一，纳米科学技术学院围绕师资队伍建设、人才培养模式、学生招录方式、内部治理结构开展了一系列改革工作，在学科建设、 人才培养、科学研究、社会服务等方面取得了丰硕成果。针对学院在“十三五”期间进一步凝聚力量，突出优势，迈向国际一流的战略目标，李院士分析了存在问 题，提出了具体措施和建议。\n\n\t熊思东对纳米科学技术学院各方面的工作给予了高度评价，并表示将继续大力支持学院特色发展。他指出，纳米科学技术学院有坚实的基础，“十三五”期间要站在提高国内、国际影响力的角度上，不拘泥于称号和排名，进一步提升整体水平。\n\n\t熊思东表示，希望纳米科学技术学院在全球范围内吸引高端人才，充分发挥高水平团队的学术 优势，形成1+1>2的倍增效应；在推进纳米新兴学科建设的过程中，进一步开拓思路，做出具有开创性意义的工作；人才培养方面要积极探索自主招生的 科学方法，以国际化视野选拔和培养人才，全面开展高水平的国际合作与交流；同时面向国家和区域重大需求，通过协同创新中心的建设，大力推动科技成果的转 化，增强服务地方经济的能力。" },
                        @{ @"image":image2, @"name":@"教务部：微课程（群）项目让大学课堂“活”起来", @"time":@"2016-4-12", @"content":@"\t为了更扎实推进“苏大课程-3I工程”项目的建设，日前，教务部与教师教学发展中心共同 开展了“基于翻转课堂的微课程（群）项目”教师研修坊活动，邀请南京师范大学张一春教授来校作专题讲座“基于翻转课堂的微课设计”，同时邀请技术团队面对 面指导立项教师自主开展微课视频的制作。\n\n\t研修坊活动中，老师们就“微课程的设计、微视频的制作以及翻转课堂的有效组织”等问题进行了深入研讨，第一批微课程（群）项目试点的几位教师代表还分享了他们的经验，让大家感受到了大学课堂应有的“活力”。\n\n\t教育学院的李利老师利用学校网络教学平台课程中心的“进阶式学习”功能布置课前学习任 务，包括学习视频和小测验。李老师精心设计小测验中的问题，一方面可以引起学生对于视频学习内容的思考，另一方面也作为课堂上开展深入讨论的引子，将课前 自主学习与课堂讨论紧密联系起来。医学部的张增利老师则采用课前将学习视频上传至班级QQ群的方式来布置学习任务，同时每个视频都配有《课前学习任务书》 来指导学生的自主学习，课堂上先通过“提问”或“课前测验”的方式来检验课前学习效果，再进一步通过分组讨论和汇报、自由发言等形式来引导学生围绕知识点 展开讨论、深入思考。\n\n\t医学部的陆叶老师在课堂上采用的是“教师引导、小组交流、相互提问、个别交流”的方式。 陆老师在微课视频中预设了一些问题，并引导学生如何去查找相关资料、关注学科前沿。课堂上小组交流时既可以讨论预设问题，也可以自己提出问题；小组之间互 相提问，还可以现场提问老师；对于不爱开口的学生，老师进行个别交流。材料与化学化工学部的赵蓓老师是把翻转课堂的教学活动分为了两种形式，一种是“下任 务、答题目、知识点的应用、理重点、释难点、师生和生生互动”，另一种是“课前分组学习、人人写小论文、合力做PPT，课上小组汇报，小组间提问和讨 论”，根据每次翻转的教学内容的特点灵活选用。\n\n\t医学部的王大慧老师试点的课程是实验类课程，“一视、二看、三仿、四做”是王老师设计的基于微课的实验课程教学模式，通过将实验演示的过程录制成微课视频让学生在课前预习，课前安排实验仿作环节，课上每个小组派出一名代表进行组间PK，极大地激发了学生的学习热情。\n\n\t作为开展课程改革的重要举措，“苏大课程-3I工程”自2014年启动，通过对新生研讨课、通识选修课、网络进阶式课程、微课程（群）项目、全英文教学示范课等几类课程项目的建设，将课程改革的新思想、新理念应用于实践，落实在课堂。到目前为止，已立项65个微课程（群）项目并全面开展课堂教学模式的改革试点。\n\n\t翻转课堂是信息技术融入教学改革的又一体现，它改变了传统的大学课堂形式，赋予学生更多的自由——把知识传授的过程放在课外，让学生选择最适合自己的方式接受新知识，而把知识内化的过程放在课内，以便同学之间、学生和教师之间有更多的沟通和交流。\n\n\t翻转课堂无固定模式，不同学科采取的教学方式不同，但它也具备一些典型的特点。例如在翻 转课堂中，教师不再单单是课程内容的传授者，更多地变为学习过程的指导者与促进者;学生从被动的内容接受者变为学习活动的主体;教学组织形式从“课堂授课 听讲+课后完成作业”转变为“课前自主学习+课堂协作探究”;课堂内容变为辅导答疑、讨论交流、小组协作等;技术起到的作用是为自主学习和协作探究提供方 便的学习资源和互动工具;评价方式呈现多层次、多维度等。\n\n\t交流活动中，老师们纷纷表示，翻转课堂这种教学模式适合大学生的学习，值得推广。教师可 以通过技术手段对学生的学习数据进行分析，了解到每一位学生的学习状况，随时调整教学策略，有针对性地开展课堂教学活动，从而提高教学效果。同时也能改变 了学生的学习习惯，培养其自主学习和合作学习的能力。\n\n\t新颖的课堂教学形式也得到了很多学生的认可。例如，有同学在课程意见反馈中这样写道： “翻转课堂这种教学模式，让我们不再只是一味地被动接受，课堂上老师有更多地时间与我们交流、解答疑问，大大提高了学习效果。微课视频短小精悍、设计精 良，学习起来目标明确，无论是课前的自主学习，还是课后查缺补漏，效果都不错。这是一项很有意义的改革，希望可以继续进行下去。”" },
                        @{ @"image":image3, @"name":@"FUNSOM研究院李述汤院士、廖良生教授应邀为Nature Reviews Materials撰写评论文章", @"time":@"2016-2-2", @"content":@"\t近日，我校FUNSOM研究院李述汤院士、廖良生教授应邀为《Nature Reviews Materials》撰写的评论文章“Materials science in China”（Nat. Rev. Mater., 2016, 1, 16025.）正式在线发表。这是我校的科研人员首次在“Nature Reviews”系列期刊上发表评论文章（第一单位，第一作者）。\n\n\t《Nature Reviews Materials》是Nature出版集团继《Nature Reviews Cancer》（IF=37.4）、《Nature Reviews Drug Discovery》（IF=41.908）、《Nature Reviews Molecular Cell Biology》（IF=37.806）等系列综述期刊后，于今年创刊的材料科学领域首个综述性期刊。该期刊专门发表材料科学与技术领域的综述、展望与评 论文章。据悉，该期刊中的评论文章旨在针对材料科学领域的热点问题和发展趋势提出权威性见解。\n\n\t进入本世纪以来，中国经济不断强大，使得世人对中国材料科学与技术的发展给予了越来越多 的关注。此次李述汤院士和廖良生教授应邀针对我国材料科学15年来的发展状况，从优势、挑战和展望三方面进行了精辟论述，认为我国高瞻远瞩的科研政策、不 断完善的研究平台、高层次的人才计划以及庞大的国内市场是中国材料科学与技术近年来飞速发展的推动力；并且相信我国材料科技人员终将站在世界科技前沿，为我国乃至世界的经济发展做出重要贡献。通过《Nature Reviews Materials》这一重要窗口在科学界向世人介绍中国材料科学与技术的发展，具有重要意义。" },
                        @{ @"image":image4, @"name":@"苏州大学—加拿大滑铁卢大学第三届学术论坛顺利举行", @"time":@"2016-1-2", @"content":@"\t日前，苏州大学—加拿大滑铁卢大学第三届学术论坛在独墅湖校区举行。我校副校长蒋星红、 加拿大滑铁卢大学校长Feridun Hamdullahpur出席论坛开幕式。滑铁卢大学以及我校药学、材料学、化学、物理学等领域近40名教师和学生代表出席论坛。开幕式由我校药学院院长 镇学初主持。\n\n\t蒋星红代表学校向滑铁卢大学代表团来访表示热烈欢迎，简要介绍了苏州大学在学科建设中取 得的成绩，回顾了苏州大学与滑铁卢大学的合作历程。她指出，两校有着优良的合作传统，合作领域从最初纳米学科推展到物理、材料学、化学、药学等多个学科， 未来希望双方能精诚合作取得更好的合作成果，并预祝论坛取得圆满成功。\n\n\t滑铁卢大学校长Feridun Hamdullahpur教授和理学院院长Robert Lemieux教授先后发言。他们对此次论坛的举办表示祝贺，并希望通过此次论坛能使两校间的联系更加紧密，未来能有更多广泛和深入的合作。\n\n\t会上，滑铁卢大学和苏州大学的教师为本次论坛精心准备了17场精彩的学术报告。两校学者还就新型太阳能电池研发、功能材料的合成、基因治疗安全性研究、抗癌药物研发、新型纳米载体药物研究、神经退行性疾病治疗新靶点的发现等各领域前沿学术问题进行了积极的探讨。" }] mutableCopy];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"newsCell";
    SpotlightTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[SpotlightTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell loadData:self.cellArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SpotlightDetailController *controller = [[SpotlightDetailController alloc] init];
    controller.data = self.cellArray[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];

}

@end




@interface SpotlightTableCell ()

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *time;

@end

@implementation SpotlightTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadSubViews];
    }
    return self;
}

- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)loadSubViews
{
    self.image = [[UIImageView alloc] init];
    [self.contentView addSubview:self.image];
    [self.image makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(15);
        make.right.bottom.equalTo(-15);
        make.width.equalTo(self.image.height).multipliedBy(1.3);
    }];
    
    self.name = [[UILabel alloc] init];
    self.name.font = [UIFont systemFontOfSize:16.0 weight:0.4];
    self.name.textColor = kMainBlackColor;
    self.name.numberOfLines = 0;
    self.name.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:self.name];
    [self.name makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(15);
        make.right.equalTo(self.image.left).offset(-10);
    }];
    
    UIImageView *image1 = [[UIImageView alloc] init];
    image1.image = [UIImage imageNamed:@"shijian"];
    [self.contentView addSubview:image1];
    [image1 makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-15);
        make.left.equalTo(15);
        make.height.width.equalTo(15);
    }];
    
    self.time = [[UILabel alloc] init];
    self.time.font = [UIFont systemFontOfSize:14.0];
    self.time.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.time];
    [self.time makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(image1);
        make.left.equalTo(image1.right).offset(10);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(0.5);
    }];
    
}

- (void)loadData:(NSDictionary *)data
{
    self.image.image = data[@"image"];
    self.name.text = data[@"name"];
    self.time.text = data[@"time"];
}

@end




@interface  SpotlightDetailController ()

@property (nonatomic, strong) NSMutableArray *comments;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *content;

@end

@implementation SpotlightDetailController

- (instancetype)init
{
    if (self = [super init]) {
        self.title = @"新闻正文";
        self.comments = [@[ @{ @"userName":@"Lucifer", @"content":@"学校就好，花花草草还有中央公园", @"time":@"2016-03-22 20:46"},
                            @{ @"userName":@"李青", @"content":@"凑个热闹", @"time":@"2016-03-22 19:36" },
                            @{ @"userName":@"张丹", @"content":@"春光灿烂", @"time":@"2016-03-22 18:42" } ] mutableCopy];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadSubViews];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)loadSubViews
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
    
    CGFloat gap = 20;
    self.name = [[UILabel alloc] init];
    self.name.numberOfLines = 0;
    self.name.lineBreakMode = NSLineBreakByCharWrapping;
    self.name.font = [UIFont systemFontOfSize:20.0 weight:0.5];
    self.name.textColor = kMainBlackColor;
    [scrollView addSubview:self.name];
    [self.name makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(gap);
        make.right.equalTo(-gap);
        make.width.equalTo(ScreenWidth-gap*2);
    }];
    
    self.time = [[UILabel alloc] init];
    self.time.font = [UIFont systemFontOfSize:14.0];
    self.time.textColor = kLightTextColor;
    [scrollView addSubview:self.time];
    [self.time makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.bottom).offset(5);
        make.left.equalTo(self.name);
    }];
    
    self.image = [[UIImageView alloc] init];
    [scrollView addSubview:self.image];
    [self.image makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.name);
        make.top.equalTo(self.time.bottom).offset(10);
        make.height.equalTo(self.image.width).multipliedBy(0.66);
    }];
    
    self.content = [[UILabel alloc] init];
    self.content.font = [UIFont systemFontOfSize:15.0];
    self.content.textColor = kMainBlackColor;
    self.content.numberOfLines = 0;
    self.content.lineBreakMode = NSLineBreakByCharWrapping;
    [scrollView addSubview:self.content];
    [self.content makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.image.bottom).offset(gap);
        make.left.equalTo(gap);
        make.right.equalTo(-gap);
    }];
    
    //4444444444
    UIView *lastView = nil;
    for (int i = 0; i < self.comments.count; i++) {
        UIView *newView = [[UIView alloc] init];
        newView.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:newView];
        [newView makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(80);
            make.left.right.equalTo(0);
        }];
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = kLightWhiteColor;
        [newView addSubview:line];
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.right.bottom.equalTo(0);
            make.height.equalTo(0.5);
        }];
        UILabel *userName = [[UILabel alloc] init];
        userName.text = self.comments[i][@"userName"];
        userName.font = [UIFont systemFontOfSize:16.0];
        [newView addSubview:userName];
        [userName makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(newView.centerY).offset(-8);
            make.left.equalTo(15);
        }];
        UILabel *content = [[UILabel alloc] init];
        content.text = self.comments[i][@"content"];
        content.font = [UIFont systemFontOfSize:15.0];
        [newView addSubview:content];
        [content makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(newView.centerY).offset(8);
            make.left.equalTo(15);
        }];
        UILabel *time = [[UILabel alloc] init];
        time.text = self.comments[i][@"time"];
        time.font = [UIFont systemFontOfSize:13.0];
        time.textColor = [UIColor lightGrayColor];
        time.textAlignment = NSTextAlignmentRight;
        [newView addSubview:time];
        [time makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(userName);
            make.right.equalTo(-15);
        }];
        
        if (!lastView) {
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = kLightWhiteColor;
            [scrollView addSubview:line];
            [line makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(0);
                make.height.equalTo(30);
                make.top.equalTo(self.content.bottom).equalTo(30);
            }];
            
            [newView makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(line.bottom).offset(1);
            }];
        } else {
            [newView makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastView.bottom);
            }];
        }
        lastView = newView;
    }
    UIButton *moreComment = [[UIButton alloc] init];
    moreComment.backgroundColor = [UIColor whiteColor];
    [moreComment setTitle:@"更多评论" forState:UIControlStateNormal];
    [moreComment setTitleColor:kMainBlackColor forState:UIControlStateNormal];
    moreComment.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [scrollView addSubview:moreComment];
    [moreComment makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastView.bottom);
        make.left.right.equalTo(0);
        make.height.equalTo(50);
    }];
    [moreComment addTarget:self action:@selector(clickMoreComment) forControlEvents:UIControlEventTouchUpInside];

    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(moreComment).offset(80);
    }];
    
    //非scrollView部分
    UIView *fixedView = [[UIView alloc] init];
    fixedView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:fixedView];
    [fixedView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(0);
        make.height.equalTo(50);
    }];
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor lightGrayColor];
    [fixedView addSubview:line1];
    [line1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.height.equalTo(0.5);
    }];
    
    UIButton *commentButton = [[UIButton alloc] init];
    [commentButton setImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
    [commentButton setImageEdgeInsets:UIEdgeInsetsMake(13, 35, 13, 70)];
    commentButton.contentMode = UIViewContentModeScaleAspectFill;
    [commentButton setTitle:@"评论" forState:UIControlStateNormal];
    [commentButton setTitleColor:kMainProjColor forState:UIControlStateNormal];
    [fixedView addSubview:commentButton];
    [commentButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(0);
        make.right.equalTo(fixedView.centerX);
    }];
    [commentButton addTarget:self action:@selector(clickComment) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *likeButton = [[UIButton alloc] init];
    [likeButton setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    [likeButton setImageEdgeInsets:UIEdgeInsetsMake(13, 40, 13, 60)];
    [likeButton setTitle:@"我喜欢" forState:UIControlStateNormal];
    [likeButton setTitleColor:kMainProjColor forState:UIControlStateNormal];
    likeButton.selected = NO;
    [fixedView addSubview:likeButton];
    [likeButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(0);
        make.left.equalTo(commentButton.right);
    }];
    [likeButton addTarget:self action:@selector(clickLike:) forControlEvents:UIControlEventTouchUpInside];
    
    [self loadData:self.data];
}

- (void)clickMoreComment
{
    ActivityMoreCommentController *controller = [[ActivityMoreCommentController alloc] init];
    controller.comments = [self.comments mutableCopy];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)clickLike:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setTitle:@"已喜欢" forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"shoucangfilled"] forState:UIControlStateNormal];
        [self showHUDwithMessage:@"已喜欢" imageName:@"success.png"];
    } else {
        [sender setTitle:@"我喜欢" forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
        [self showHUDwithMessage:@"取消喜欢" imageName:@"success.png"];
    }
}

- (void)clickComment
{
    ActivityCommentController *controller = [[ActivityCommentController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)loadData:(NSDictionary *)dict
{
    self.image.image = dict[@"image"];
    self.name.text = dict[@"name"];
    self.time.text = dict[@"time"];
    self.content.text = dict[@"content"];
}

@end

