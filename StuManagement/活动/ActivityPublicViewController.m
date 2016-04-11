//
//  ActivityPublicViewController.m
//  StuManagement
//
//  Created by MiY on 16/4/11.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "ActivityPublicViewController.h"

@interface ActivityPublicViewController () <UITextViewDelegate>

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextView *describeTextView;
@property (nonatomic, strong) UITextField *placeTextField;
@property (nonatomic, strong) UILabel *startTimeLabel;
@property (nonatomic, strong) UILabel *endTimeLabel;
@property (nonatomic, strong) UITextField *costTextField;
@property (nonatomic, strong) UILabel *typeLabel;

@end

@implementation ActivityPublicViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.navigationItem.title = @"发布活动";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kLightWhiteColor;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(publicActivity)];
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
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
    
    self.image = [[UIImageView alloc] init];
    [self.image loadImageWithUrl:@"http://i03.pic.sogou.com/cbfb092dd104d538"];
    [scrollView addSubview:self.image];
    [self.image makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.width.equalTo(ScreenWidth);
        make.height.equalTo(self.image.width).multipliedBy(0.7);
    }];
    
    UIView *firstView = [[UIView alloc] init];
    firstView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:firstView];
    [firstView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.image.bottom);
        make.left.right.equalTo(0);
        make.height.equalTo(200);
    }];
    
    UIImageView *image111 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"huodongmingcheng"]];
    [firstView addSubview:image111];
    [image111 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(12);
        make.width.height.equalTo(20);
        make.centerY.equalTo(firstView.top).offset(25);
    }];
    
    self.nameTextField = [[UITextField alloc] init];
    self.nameTextField.placeholder = @"输入活动名称";
    self.nameTextField.borderStyle = UITextBorderStyleNone;
    self.nameTextField.font = [UIFont systemFontOfSize:15.0];
    [firstView addSubview:self.nameTextField];
    [self.nameTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(0);
        make.left.equalTo(image111.right).offset(10);
        make.height.equalTo(55);
    }];
    
    [self addLineToSuperView:firstView underView:self.nameTextField withGap:0];
    
    self.describeTextView = [[UITextView alloc] init];
    self.describeTextView.delegate = self;
    self.describeTextView.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.24];
    self.describeTextView.text = @"填写活动描述,让更多的人参与活动...";
    self.describeTextView.font = [UIFont systemFontOfSize:15.0];
    [self.describeTextView setTextContainerInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    [firstView addSubview:self.describeTextView];
    [self.describeTextView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameTextField.bottom).offset(1);
        make.left.right.bottom.equalTo(0);
    }];
    
    //22222222
    UIView *secondView = [[UIView alloc] init];
    secondView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:secondView];
    [secondView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(firstView.bottom).offset(15);
        make.height.equalTo(50);
    }];
    UIImageView *image222 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shijian"]];
    [secondView addSubview:image222];
    [image222 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image111);
        make.width.height.equalTo(image111);
        make.centerY.equalTo(0);
    }];
    UILabel *startTime = [[UILabel alloc] init];
    startTime.text = @"开始时间";
    startTime.font = [UIFont systemFontOfSize:15.0];
    [secondView addSubview:startTime];
    [startTime makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image222.right).offset(10);
        make.centerY.equalTo(image222);
    }];
    UILabel *startTimeLabel = [[UILabel alloc] init];
    self.startTimeLabel = startTimeLabel;
    startTimeLabel.text = @"2016-04-11 10:33";
    startTimeLabel.font = [UIFont systemFontOfSize:14.0];
    startTimeLabel.textAlignment = NSTextAlignmentCenter;
    [secondView addSubview:startTimeLabel];
    [startTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-28);
        make.centerY.equalTo(0);
    }];
    UIImageView *jiantou1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou"]];
    [secondView addSubview:jiantou1];
    [jiantou1 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.right.equalTo(-8);
        make.width.height.equalTo(15);
    }];
    
    
    
    
    
    //222222111111
    UIView *secondView2 = [[UIView alloc] init];
    secondView2.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:secondView2];
    [secondView2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(secondView.bottom).offset(1);
        make.height.equalTo(50);
    }];

    UIImageView *image333 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shijian"]];
    [secondView2 addSubview:image333];
    [image333 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image111);
        make.width.height.equalTo(image111);
        make.centerY.equalTo(0);
    }];
    UILabel *endTime = [[UILabel alloc] init];
    endTime.text = @"结束时间";
    endTime.font = [UIFont systemFontOfSize:15.0];
    [secondView2 addSubview:endTime];
    [endTime makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image333.right).offset(10);
        make.centerY.equalTo(image333);
    }];
    UILabel *endTimeLabel = [[UILabel alloc] init];
    self.endTimeLabel = endTimeLabel;
    endTimeLabel.text = @"2016-04-11 10:33";
    endTimeLabel.font = [UIFont systemFontOfSize:14.0];
    endTimeLabel.textAlignment = NSTextAlignmentCenter;
    [secondView2 addSubview:endTimeLabel];
    [endTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(startTimeLabel);
        make.centerY.equalTo(0);
    }];
    UIImageView *jiantou2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou"]];
    [secondView2 addSubview:jiantou2];
    [jiantou2 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.right.equalTo(jiantou1);
        make.width.height.equalTo(jiantou1);
    }];

    
    
    
    //3333333
    UIView *thirdView = [[UIView alloc] init];
    thirdView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:thirdView];
    [thirdView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(secondView2.bottom).offset(12);
        make.height.equalTo(50);
    }];
    UIImageView *image444 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"didian"]];
    [thirdView addSubview:image444];
    [image444 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image111);
        make.width.height.equalTo(image111);
        make.centerY.equalTo(0);
    }];
    UILabel *place = [[UILabel alloc] init];
    place.text = @"活动地点";
    place.font = [UIFont systemFontOfSize:15.0];
    [thirdView addSubview:place];
    [place makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image444.right).offset(10);
        make.centerY.equalTo(image444);
    }];
    self.placeTextField = [[UITextField alloc] init];
    self.placeTextField.font = [UIFont systemFontOfSize:14.0];
    self.placeTextField.placeholder = @"输入活动地址";
    self.placeTextField.textAlignment = NSTextAlignmentRight;
    [thirdView addSubview:self.placeTextField];
    [self.placeTextField makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(startTimeLabel);
        make.centerY.equalTo(0);
    }];
    UIImageView *jiantou3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou"]];
    [thirdView addSubview:jiantou3];
    [jiantou3 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.right.equalTo(jiantou1);
        make.width.height.equalTo(jiantou1);
    }];

    
    
    
    //4444444
    UIView *fourthView = [[UIView alloc] init];
    fourthView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:fourthView];
    [fourthView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(thirdView.bottom).offset(12);
        make.height.equalTo(50);
    }];
    UIImageView *image555 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shoufei"]];
    [fourthView addSubview:image555];
    [image555 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image111);
        make.width.height.equalTo(image111);
        make.centerY.equalTo(0);
    }];
    UILabel *type = [[UILabel alloc] init];
    type.text = @"活动费用";
    type.font = [UIFont systemFontOfSize:15.0];
    [fourthView addSubview:type];
    [type makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image555.right).offset(10);
        make.centerY.equalTo(image555);
    }];
    self.costTextField = [[UITextField alloc] init];
    self.costTextField.font = [UIFont systemFontOfSize:14.0];
    self.costTextField.placeholder = @"输入活动费用";
    self.costTextField.textAlignment = NSTextAlignmentRight;
    [fourthView addSubview:self.costTextField];
    [self.costTextField makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(startTimeLabel);
        make.centerY.equalTo(0);
    }];
    UIImageView *jiantou4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou"]];
    [fourthView addSubview:jiantou4];
    [jiantou4 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.right.equalTo(jiantou1);
        make.width.height.equalTo(jiantou1);
    }];

    //5555555
    UIView *fiveView = [[UIView alloc] init];
    fiveView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:fiveView];
    [fiveView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(fourthView.bottom).offset(12);
        make.height.equalTo(50);
    }];
    UILabel *cost = [[UILabel alloc] init];
    cost.text = @"活动类别";
    cost.font = [UIFont systemFontOfSize:15.0];
    [fiveView addSubview:cost];
    [cost makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(startTime);
        make.centerY.equalTo(0);
    }];
    self.typeLabel = [[UILabel alloc] init];
    self.typeLabel.font = [UIFont systemFontOfSize:14.0];
    self.typeLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.24];
    self.typeLabel.text = @"院级";
    [fiveView addSubview:self.typeLabel];
    [self.typeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(startTimeLabel);
        make.centerY.equalTo(0);
    }];
    
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(fiveView).offset(50);
    }];
    
}

- (void)publicActivity
{
    
}

#pragma mark - UITextView Delegate Methods
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView       //开始输入前
{
//    [self resetScrollViewOffsetByKeyboardHeight:self.keyboardHeight];       //点击textview改变offset
    
    if ([textView.text isEqualToString:@"填写活动描述,让更多的人参与活动..."]) {
        textView.text = @"";
        textView.textColor = kMainBlackColor;
    }
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text      //输入中
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
        textView.text = @"填写活动描述,让更多的人参与活动...";
        textView.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.24];
    }
}



@end
