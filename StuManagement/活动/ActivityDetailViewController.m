//
//  ActivityDetailViewController.m
//  StuManagement
//
//  Created by MiY on 16/4/8.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "ActivityDetailViewController.h"

const NSInteger maxNumberOfWords = 150;

@interface ActivityDetailViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *comments;

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

@property (nonatomic) BOOL isReadyToMagnify;
@end

@implementation ActivityDetailViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.title = @"活动详情";
        self.comments = [@[ @{ @"userName":@"Lucifer", @"content":@"学校就好，花花草草还有中央公园", @"time":@"2016-03-22 20:46"},
                            @{ @"userName":@"李青", @"content":@"凑个热闹", @"time":@"2016-03-22 19:36" },
                            @{ @"userName":@"张丹", @"content":@"春光灿烂", @"time":@"2016-03-22 18:42" } ] mutableCopy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.isFromMine) {
        UIButton *qiandao = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
        qiandao.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [qiandao setTitle:@"签" forState:UIControlStateNormal];
        [qiandao setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [qiandao addTarget:self action:@selector(clickQiandao:) forControlEvents:UIControlEventTouchUpInside];
        [self makeView:qiandao toRoundCorner:qiandao.frame.size.width/2 withWidth:1 color:[UIColor whiteColor]];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:qiandao];
        self.navigationItem.rightBarButtonItem = rightItem;
    }

    [self loadSubViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.scrollView.contentOffset.y >= 100) {
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:kMainProjColor] forBarMetrics:UIBarMetricsDefault];
    } else {
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:[kMainProjColor colorWithAlphaComponent:0]] forBarMetrics:UIBarMetricsDefault];
    }
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
    
    self.image = [[UIImageView alloc] initWithImage:self.data[@"image"]];
    
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
    self.titleLabel.text = self.data[@"name"];
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
    self.yuanjiaxiaojiLabel.text = self.data[@"yuanjixiaoji"];
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
    self.timeLabel.text = self.data[@"time"];
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
    self.placeLabel.text = self.data[@"place"];
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
    self.costLabel.text = self.data[@"cost"];
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
    
    
    
    //2222222222
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
    self.detailLabel.text = self.data[@"detail"];
    self.detailLabel.font = [UIFont systemFontOfSize:15.0];
    self.detailLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [secondBackView addSubview:self.detailLabel];
    [self.detailLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.top.equalTo(20);
        if (self.detailLabel.text.length >= maxNumberOfWords) {
            make.bottom.equalTo(-30);
        }
    }];
//    if (self.detailLabel.text.length >= maxNumberOfWords) {
//        [secondBackView makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(190);
//        }];
//        UIButton *zhankai = [[UIButton alloc] init];
//        [zhankai setTitle:@"展开" forState:UIControlStateNormal];
//        [zhankai setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        zhankai.titleLabel.font = [UIFont systemFontOfSize:12.0];
//        zhankai.backgroundColor = [UIColor lightGrayColor];
//        [zhankai addTarget:self action:@selector(clickZhanKai:) forControlEvents:UIControlEventTouchUpInside];
//        [secondBackView addSubview:zhankai];
//        [zhankai makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(-15);
//            make.bottom.equalTo(-8);
//            make.size.equalTo(CGSizeMake(45, 20));
//        }];
//        [self makeView:zhankai toRoundCorner:10 withWidth:0 color:nil];
//
//    } else {
//        [secondBackView makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.detailLabel).offset(20);
//        }];
//    }
    
    
    //3333333333
    UIView *thirdView = [[UIView alloc] init];
    thirdView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:thirdView];
    [thirdView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondBackView.bottom).offset(17);
        make.left.right.equalTo(0);
        make.height.equalTo(50);
    }];
    UILabel *label111 = [[UILabel alloc] init];
    label111.text = @"最新评论";
    label111.backgroundColor = [UIColor whiteColor];
    label111.font = [UIFont systemFontOfSize:16.0];
    [thirdView addSubview:label111];
    [label111 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.left.equalTo(self.titleLabel);
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
            [newView makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(thirdView.bottom).offset(1);
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
    
    [self.view layoutIfNeeded];
    
    CGFloat y = moreComment.frame.origin.y + moreComment.frame.size.height;
    
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
    [commentButton addTarget:self action:@selector(clickComment) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *likeButton = [[UIButton alloc] init];
    likeButton.selected = NO;
    [likeButton setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    [fixedView addSubview:likeButton];
    [likeButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(0);
        make.left.equalTo(commentButton.right);
        make.width.equalTo(fixedView).multipliedBy(0.34);
    }];
    [likeButton addTarget:self action:@selector(clickLike:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *joinButton = [[UIButton alloc] init];
    joinButton.selected = NO;
    [joinButton setTitle:@"立即参加" forState:UIControlStateNormal];
    [joinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [joinButton setBackgroundColor:kMainProjColor];
    [fixedView addSubview:joinButton];
    [joinButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(0);
        make.left.equalTo(likeButton.right);
    }];
    [joinButton addTarget:self action:@selector(clickJoin:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)clickMoreComment
{
    ActivityMoreCommentController *controller = [[ActivityMoreCommentController alloc] init];
    controller.comments = [self.comments mutableCopy];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)clickComment
{
    ActivityCommentController *controller = [[ActivityCommentController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)clickLike:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"shoucangfilled"] forState:UIControlStateNormal];
        [self showHUDwithMessage:@"收藏成功" imageName:@"success.png"];
    } else {
        [sender setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
        [self showHUDwithMessage:@"取消收藏" imageName:@"error.png"];
    }

}

- (void)clickJoin:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setTitle:@"取消参加" forState:UIControlStateNormal];
        [sender setBackgroundColor:[UIColor orangeColor]];
        [self showHUDwithMessage:@"参加成功" imageName:@"success.png"];

    } else {
        [sender setTitle:@"立即参加" forState:UIControlStateNormal];
        [sender setBackgroundColor:kMainProjColor];
        [self showHUDwithMessage:@"取消参加" imageName:@"error.png"];

    }

}

- (void)clickQiandao:(UIButton *)sender
{
    if (!sender.selected) {
        sender.selected = YES;
        [sender setTitle:@"已签" forState:UIControlStateNormal];
        [self showHUDwithMessage:@"签到成功" imageName:@"success.png"];
    }
}

//- (void)clickZhanKai:(UIButton *)sender
//{
//    sender.hidden = YES;
//    [self.detailLabel remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(15);
//        make.right.equalTo(-15);
//        make.top.equalTo(20);
//    }];
//    
//    [self.secondView remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.firstView.bottom).offset(17);
//        make.left.right.equalTo(0);
//        make.bottom.equalTo(self.detailLabel).offset(15);
//    }];
//    
//    [self.view layoutIfNeeded];
//    CGFloat y = self.secondView.frame.origin.y + self.secondView.frame.size.height;
//    
//    [self.underLine updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.scrollView).offset(y);
//    }];
//}

#pragma mark - scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:[kMainProjColor colorWithAlphaComponent:(scrollView.contentOffset.y - 100) / 10]] forBarMetrics:UIBarMetricsDefault];
    if (scrollView.contentOffset.y <= 0) {
        self.isReadyToMagnify = YES;
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
        if (self.isReadyToMagnify) {
            self.isReadyToMagnify = NO;
            [self.image remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(0);
                make.width.equalTo(ScreenWidth);
                make.height.equalTo(273);
            }];
        }
    }
}

@end





@interface ActivityMoreCommentController ()

@end

@implementation ActivityMoreCommentController

- (instancetype)init
{
    if (self = [super init]) {
        self.title = @"更多评论";
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
    scrollView.backgroundColor = kLightWhiteColor;
    [self.view addSubview:scrollView];
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
    
    UIView *lastView = nil;
    for (int i = 0; i < self.comments.count; i++) {
        UIView *newView = [[UIView alloc] init];
        newView.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:newView];
        [newView makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(80);
            make.left.right.equalTo(0);
            make.width.equalTo(ScreenWidth);
        }];
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor lightGrayColor];
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
            [newView makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(0);
            }];
        } else {
            [newView makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastView.bottom);
            }];
        }
        lastView = newView;
    }
    
    [self.view layoutIfNeeded];
    CGFloat y = lastView.frame.origin.y + lastView.frame.size.height;
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        if (y < ScreenHeight - 50 - 64) {
            make.bottom.equalTo(lastView).offset(ScreenHeight-y-64+1);
        } else {
            make.bottom.equalTo(lastView).offset(50);
        }
    }];
    
}

@end




@interface ActivityCommentController () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;

@end

@implementation ActivityCommentController

- (instancetype)init
{
    if (self = [super init]) {
        self.title = @"评论";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kLightWhiteColor;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(sendComment)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;

    [self loadSubViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)sendComment
{
    //send comment
    [self showHUDwithMessage:@"评论成功" imageName:@"success.png"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadSubViews
{
    self.textView = [[UITextView alloc] init];
    self.textView.font = [UIFont systemFontOfSize:14.0];
    self.textView.text = @"评论内容...";
    self.textView.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.24];
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
    [self.textView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(10);
        make.right.equalTo(-10);
        make.height.equalTo(200);
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - text view delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView       //开始输入前
{
    //    [self resetScrollViewOffsetByKeyboardHeight:self.keyboardHeight];       //点击textview改变offset
    
    if ([textView.text isEqualToString:@"评论内容..."]) {
        textView.text = @"";
        textView.textColor = kMainBlackColor;
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text      //输入中
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];        //当输入回车时，去除第一响应者
        
        return NO;
    }
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView        //结束输入后
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"评论内容...";
        textView.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.24];
    }
}


@end
