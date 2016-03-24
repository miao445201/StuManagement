//
//  ImageRollScrollView.m
//  StuManagement
//
//  Created by MiY on 16/3/24.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "ImageRollScrollView.h"

@interface ImageRollScrollView ()

@property (nonatomic, strong) NSTimer *scrollTimer;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic) NSTimeInterval intervalTime;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *texts;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic) NSInteger currentPage;

@end

@implementation ImageRollScrollView

- (instancetype)init
{
    if (self = [super init]) {

    }
    return self;
}

- (void)loadImages:(NSArray *)images withRollTime:(NSTimeInterval)time optionalText:(NSArray *)texts
{
    [self initSubViewsWithText:(texts != nil)];
    
    self.images = images;
    self.intervalTime = time;
    self.texts = texts;
    
    self.pageControl.numberOfPages = images.count;
    self.pageControl.currentPage = 0;
    self.currentPage = 0;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.pagingEnabled = YES;
    
    self.pageControl.hidesForSinglePage = YES;
    
    if (images.count == 0 || images == nil) {
        self.scrollView.scrollEnabled = NO;
    } else if (images.count == 1) {
        self.scrollView.scrollEnabled = NO;
    } else {
        [self initTimer];
    }
    
    NSMutableArray *realImages = [[NSMutableArray alloc] initWithCapacity:10];
    [realImages addObject:[images lastObject]];
    [realImages addObjectsFromArray:images];
    [realImages addObject:[images firstObject]];
    
    UIImageView *leftView = nil;
    for (int i = 0; i < realImages.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:realImages[i]];
        [self.scrollView addSubview:imageView];

        [imageView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView);
            if (leftView) {
                make.left.equalTo(leftView.right);
            } else {
                make.left.equalTo(self.scrollView);
            }
            make.height.equalTo(self);
            make.bottom.equalTo(self.scrollView);
            make.width.equalTo(self);
        }];
        
        leftView = imageView;
    }
    
    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(leftView);
    }];
    
    [self layoutIfNeeded];
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
}

- (void)onTimer
{
    CGFloat pageWidth = self.frame.size.width;

    self.currentPage = self.pageControl.currentPage;
    CGPoint point = self.scrollView.contentOffset;
    
    if (self.pageControl.currentPage == 0) {
        [self.scrollView setContentOffset:CGPointMake(pageWidth, point.y)];
        
    } else if (self.pageControl.currentPage == self.pageControl.numberOfPages - 1) {
        [self.scrollView setContentOffset:CGPointMake(pageWidth * self.pageControl.numberOfPages, point.y)];
        
    }
    point = self.scrollView.contentOffset;
    [self.scrollView setContentOffset:CGPointMake(point.x + pageWidth, point.y) animated:YES];

    
    if (self.pageControl.currentPage == self.pageControl.numberOfPages - 1) {
        self.pageControl.currentPage = 0;
    } else {
        self.pageControl.currentPage++;
    }
    self.currentPage = self.pageControl.currentPage;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.scrollTimer invalidate];
    self.scrollTimer = nil;
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGFloat pageWidth = self.frame.size.width;

    CGPoint point = *targetContentOffset;
    NSInteger page = ((NSInteger)(point.x / pageWidth) + 2) % self.images.count;
    self.pageControl.currentPage = page;
    self.currentPage = page;
    
    CGPoint currentPoint = scrollView.contentOffset;
    
    if (point.x == pageWidth * (self.images.count + 1)) {
        [self.scrollView setContentOffset:CGPointMake(currentPoint.x - pageWidth * self.images.count, 0)];
    }
    
    if (point.x == 0) {
        [self.scrollView setContentOffset:CGPointMake(currentPoint.x + pageWidth * self.images.count, 0)];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self initTimer];
}

- (void)awakeFromNib
{
}

- (void)initSubViewsWithText:(BOOL)isContainTexts
{
    self.scrollView = [[UIScrollView alloc] init];
    self.pageControl = [[UIPageControl alloc] init];
    self.label = [[UILabel alloc] init];
    UIView *blackBar = [[UIView alloc] init];
    
    [self addSubview:self.scrollView];
    [self addSubview:blackBar];
    [self addSubview:self.pageControl];
    [self addSubview:self.label];
    
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    [self.pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    
    self.label.font = [UIFont systemFontOfSize:13.0];
    self.label.textColor = [UIColor whiteColor];

    blackBar.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.equalTo(self);
    }];
    
    [self.pageControl makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(blackBar);
        make.height.equalTo(blackBar);
    }];
    
    [self.label makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(blackBar);
    }];
    
    [blackBar makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.equalTo(35);
    }];
    
    if (!isContainTexts) {
        blackBar.hidden = YES;
    }
}

- (void)initTimer
{
    if (self.intervalTime > 0.1) {
        self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.intervalTime target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    }
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    if (self.texts) {
        self.label.text = self.texts[currentPage];
    }
}

- (void)pageChange:(UIPageControl *)pageControl
{
    [self.scrollTimer invalidate];
    self.scrollTimer = nil;

    NSInteger page = pageControl.currentPage;
    self.currentPage = page;

    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width * (page + 1), 0) animated:YES];
    [self initTimer];
}

@end
