//
//  ActivityDetailViewController.m
//  StuManagement
//
//  Created by MiY on 16/4/8.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "ActivityDetailViewController.h"

@interface ActivityDetailViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *yuanjiaxiaojiLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *placeLabel;
@property (nonatomic, strong) UILabel *costLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIView *firstView;
@property (nonatomic, strong) UIView *secondView;
@property (nonatomic, strong) UIView *underLine;
@end

@implementation ActivityDetailViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.title = @"活动详情";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadSubViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:[kMainProjColor colorWithAlphaComponent:0]] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:kMainProjColor] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)loadSubViews
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(-64, 0, 0, 0));
        make.width.equalTo(self.view);
    }];
    
    self.image = [[UIImageView alloc] init];
    self.image.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.image loadImageWithUrl:@"http://s1.sinaimg.cn/middle/3fc0c02bnbc96fab109c0&690"];
    
    [scrollView addSubview:self.image];
    [self.image makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.width.equalTo(ScreenWidth);
        make.height.equalTo(273);
    }];
    
    UIView *firstBackView = [[UIView alloc] init];
    self.firstView = firstBackView;
    firstBackView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:firstBackView];
    [firstBackView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.image.bottom);
        make.left.right.equalTo(0);
        make.height.equalTo(177).priorityLow();
    }];

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"不一起去踏青吗？";
    self.titleLabel.font = [UIFont systemFontOfSize:18.0];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [firstBackView addSubview:self.titleLabel];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(15);
        make.left.equalTo(14);
        make.right.equalTo(-14);
        make.height.equalTo(23);
    }];
    
    UIImageView *yuanjiyuanxiao = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yuanjiyuanxiao"]];
    [firstBackView addSubview:yuanjiyuanxiao];
    [yuanjiyuanxiao makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.bottom).offset(13);
        make.left.equalTo(self.titleLabel);
        make.width.height.equalTo(14);
    }];
    self.yuanjiaxiaojiLabel = [[UILabel alloc] init];
    self.yuanjiaxiaojiLabel.text = @"院级";
    self.yuanjiaxiaojiLabel.font = [UIFont systemFontOfSize:13.0];
    self.yuanjiaxiaojiLabel.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1];
    [firstBackView addSubview:self.yuanjiaxiaojiLabel];
    [self.yuanjiaxiaojiLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yuanjiyuanxiao.right).offset(10);
        make.centerY.height.equalTo(yuanjiyuanxiao);
    }];
    
    UIImageView *time = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shijian"]];
    [firstBackView addSubview:time];
    [time makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yuanjiyuanxiao.bottom).offset(7);
        make.left.equalTo(yuanjiyuanxiao);
        make.width.height.equalTo(yuanjiyuanxiao);
    }];
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.text = @"3月30日周三10:00 -- 3月30日周三13:00";
    self.timeLabel.font = [UIFont systemFontOfSize:13.0];
    self.timeLabel.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1];
    [firstBackView addSubview:self.timeLabel];
    [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(time.right).offset(10);
        make.centerY.height.equalTo(time);
    }];

    UIImageView *place = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"didian"]];
    [firstBackView addSubview:place];
    [place makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(time.bottom).offset(7);
        make.left.equalTo(yuanjiyuanxiao);
        make.width.height.equalTo(yuanjiyuanxiao);
    }];
    self.placeLabel = [[UILabel alloc] init];
    self.placeLabel.text = @"上方山森林公园";
    self.placeLabel.font = [UIFont systemFontOfSize:13.0];
    self.placeLabel.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1];
    [firstBackView addSubview:self.placeLabel];
    [self.placeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(place.right).offset(10);
        make.centerY.height.equalTo(place);
    }];

    UIImageView *cost = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shoufei"]];
    [firstBackView addSubview:cost];
    [cost makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(place.bottom).offset(7);
        make.left.equalTo(yuanjiyuanxiao);
        make.width.height.equalTo(yuanjiyuanxiao);
    }];
    self.costLabel = [[UILabel alloc] init];
    self.costLabel.text = @"免费";
    self.costLabel.font = [UIFont systemFontOfSize:13.0];
    self.costLabel.textColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1];
    [firstBackView addSubview:self.costLabel];
    [self.costLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cost.right).offset(10);
        make.centerY.height.equalTo(cost);
    }];
    [firstBackView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.costLabel.bottom).offset(17);
    }];
    
    UIView *secondBackView = [[UIView alloc] init];
    self.secondView = secondBackView;
    secondBackView.backgroundColor = [UIColor whiteColor];
    secondBackView.clipsToBounds = YES;
    [scrollView addSubview:secondBackView];
    [secondBackView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstBackView.bottom).offset(17);
        make.left.right.equalTo(0);
    }];
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.text = @"最近天气好的很哪，我们踏青去。上方山百花节好！走出宿舍赏花去！上方山山上的露天“金光大佛”非常醒目，但 原先到金光大佛的索道现已停运，游客可沿步道拾级而上，上方山海拔仅92米，徒步登山就当锻炼身体啦。宋代的楞枷塔则是上方山的地标和最高点，还有治平 寺、石湖草堂、乾隆御道等古迹。此外，这里也有孔雀园、各类植物园，并设有专门的拓展及烧烤场地。导览：从位于吴越路的北段的公园主入口进园，右前方是古 迹治平寺和石湖草堂，如果往右直走可到石佛寺、范成大祠以及北入口。从主入口往左走可依次到金光大佛、孔雀园、拓展基地，沿途还会经过几个大草坪和植物园，继续再往前走便可登上上方山参观楞枷塔。";
    self.detailLabel.font = [UIFont systemFontOfSize:15.0];
    self.detailLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [secondBackView addSubview:self.detailLabel];
    [self.detailLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.top.equalTo(20);
        if (self.detailLabel.text.length >= 150) {
            make.bottom.equalTo(-30);
        }
    }];
    if (self.detailLabel.text.length >= 150) {
        [secondBackView makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(190);
        }];
        UIButton *zhankai = [[UIButton alloc] init];
        [zhankai setTitle:@"展开" forState:UIControlStateNormal];
        [zhankai setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        zhankai.titleLabel.font = [UIFont systemFontOfSize:12.0];
        zhankai.backgroundColor = [UIColor lightGrayColor];
        [zhankai addTarget:self action:@selector(clickZhanKai:) forControlEvents:UIControlEventTouchUpInside];
        [secondBackView addSubview:zhankai];
        [zhankai makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-15);
            make.bottom.equalTo(-8);
            make.size.equalTo(CGSizeMake(45, 20));
        }];
        [self makeView:zhankai toRoundCorner:10 withWidth:0 color:nil];

    } else {
        [secondBackView makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.detailLabel).offset(20);
        }];
    }
    [self.view layoutIfNeeded];
    
    CGFloat y = secondBackView.frame.origin.y + secondBackView.frame.size.height;
    
    UIView *view = [[UIView alloc] init];
    self.underLine = view;
    view.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:view];
    [view makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView).offset(y);
        make.left.right.equalTo(0);
        make.height.equalTo(1);
        make.width.equalTo(ScreenWidth);
    }];
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view).offset(70);
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
//    [commentButton setBackgroundImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
    commentButton.contentMode = UIViewContentModeScaleAspectFill;
    [fixedView addSubview:commentButton];
    [commentButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(0);
        make.width.equalTo(fixedView.width).multipliedBy(0.333);
    }];
    
    UIButton *likeButton = [[UIButton alloc] init];
    [likeButton setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    [fixedView addSubview:likeButton];
    [likeButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(0);
        make.left.equalTo(commentButton.right);
        make.width.equalTo(fixedView).multipliedBy(0.34);
    }];
    
    UIButton *joinButton = [[UIButton alloc] init];
    [joinButton setTitle:@"立即参加" forState:UIControlStateNormal];
    [joinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [joinButton setBackgroundColor:kMainProjColor];
    [fixedView addSubview:joinButton];
    [joinButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(0);
        make.left.equalTo(likeButton.right);
    }];
    
}


- (void)clickZhanKai:(UIButton *)sender
{
    sender.hidden = YES;
    [self.detailLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.top.equalTo(20);
    }];
    
    [self.secondView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstView.bottom).offset(17);
        make.left.right.equalTo(0);
        make.bottom.equalTo(self.detailLabel).offset(15);
    }];
    
    [self.view layoutIfNeeded];
    CGFloat y = self.secondView.frame.origin.y + self.secondView.frame.size.height;
    
    [self.underLine updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).offset(y);
    }];
}

#pragma mark - scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:[kMainProjColor colorWithAlphaComponent:(scrollView.contentOffset.y - 0) / 100]] forBarMetrics:UIBarMetricsDefault];
    if (scrollView.contentOffset.y <= 0) {
        
        CGFloat height = 273 - scrollView.contentOffset.y*0.8;
        CGFloat width = ScreenWidth / 273 * height;
//        CGFloat x = (ScreenWidth-width)/2;
        
        [self.image remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(height);
            make.width.equalTo(width);
            make.top.equalTo(self.view).offset(-64);
            make.centerX.equalTo(self.view);
//            make.left.equalTo(x);
//            make.right.equalTo(-x);
        }];
        
    } else {
        [self.image remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(0);
            make.width.equalTo(ScreenWidth);
            make.height.equalTo(273);
        }];
    }
}

@end
