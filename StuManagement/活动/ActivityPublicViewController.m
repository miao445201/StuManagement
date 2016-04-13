//
//  ActivityPublicViewController.m
//  StuManagement
//
//  Created by MiY on 16/4/11.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "ActivityPublicViewController.h"

@interface ActivityPublicViewController () <UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextView *describeTextView;
@property (nonatomic, strong) UITextField *placeTextField;
@property (nonatomic, strong) UILabel *startTimeLabel;
@property (nonatomic, strong) UILabel *endTimeLabel;
@property (nonatomic, strong) UITextField *costTextField;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic) CGFloat keyboardHeight;
@property (nonatomic) CGFloat lastOffsetY;

@property (nonatomic, strong) UIView *popView;
@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) UIDatePicker *datePicker;
@end

@implementation ActivityPublicViewController

- (UIDatePicker *)datePicker
{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 300)];
        _datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
        NSLocale *chineseLocale = [NSLocale localeWithLocaleIdentifier:@"zh_cn"];   //创建一个中文的地区对象
        [_datePicker setLocale:chineseLocale];  //将这个地区对象给UIDatePicker设置上
        [_datePicker addTarget:self action:@selector(changeTime:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBackground)];
        gesture.numberOfTapsRequired = 1;
        [_backgroundView addGestureRecognizer:gesture];
    }
    return _backgroundView;
}

- (UIView *)popView
{
    if (!_popView) {
        _popView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 160)];
        _popView.backgroundColor = [UIColor whiteColor];
        _popView.clipsToBounds = YES;
    }
    return _popView;
}

- (void)initPopViewWithType:(NSInteger)type
{
    [self.view addSubview:self.popView];
    NSArray *array = type == 1 ? @[@"院级", @"校级", @"取消"] : @[@"拍照", @"相册选取", @"取消"];
    CGFloat gap = 6;
    UIButton *button1 = [[UIButton alloc] init];
    button1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [button1 setTitle:array[0] forState:UIControlStateNormal];
    [button1 setTitleColor:kMainBlackColor forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.popView addSubview:button1];
    [button1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(gap);
        make.right.equalTo(-gap);
    }];
    button1.tag = 1;
    [button1 addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [[UIButton alloc] init];
    button2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [button2 setTitle:array[1] forState:UIControlStateNormal];
    [button2 setTitleColor:kMainBlackColor forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.popView addSubview:button2];
    [button2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(gap);
        make.right.equalTo(-gap);

    }];
    button2.tag = 2;
    [button2 addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button3 = [[UIButton alloc] init];
    button3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [button3 setTitle:array[2] forState:UIControlStateNormal];
    [button3 setTitleColor:kMainBlackColor forState:UIControlStateNormal];
    button3.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.popView addSubview:button3];
    [button3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(gap);
        make.right.equalTo(-gap);
        make.bottom.equalTo(-gap);
    }];
    button3.tag = 3;
    [button3 addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [button1 makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(button2.top).offset(-gap);
    }];
    
    [button2 makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(button1);
        make.top.equalTo(button1.bottom).offset(gap);
        make.bottom.equalTo(button3.top).offset(-gap);
    }];
    
    [button3 makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(button1);
        make.top.equalTo(button2.bottom).offset(gap);
    }];
}

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
    [self addTapGestureToRemoveKeyboard];
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)loadSubViews
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.equalTo(self.view);
    }];
    scrollView.userInteractionEnabled = YES;
    
    self.image = [[UIImageView alloc] init];
    self.image.tag = 0;
    [self.image setImage:[UIImage imageNamed:@"tianjiahuodong"]];
//    [self.image loadImageWithUrl:@"http://i03.pic.sogou.com/cbfb092dd104d538"];
    [scrollView addSubview:self.image];
    [self.image makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.width.equalTo(ScreenWidth);
        make.height.equalTo(self.image.width).multipliedBy(0.7);
    }];
    self.image.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popSelectView:)];
    tapGesture.numberOfTapsRequired = 1;
    [self.image addGestureRecognizer:tapGesture];
    
    
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
    [scrollView addSubview:self.nameTextField];
    [self.nameTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(firstView);
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
    [scrollView addSubview:self.describeTextView];
    [self.describeTextView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameTextField.bottom).offset(1);
        make.left.right.bottom.equalTo(firstView);
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
    secondView.tag = 1;
    UITapGestureRecognizer *dateGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popDatePicker:)];
    dateGesture.numberOfTapsRequired = 1;
    [secondView addGestureRecognizer:dateGesture];
    
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
    secondView2.tag = 2;
    UITapGestureRecognizer *dateGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popDatePicker:)];
    dateGesture2.numberOfTapsRequired = 1;
    [secondView2 addGestureRecognizer:dateGesture2];

    UIImageView *image333 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shijianjieshu"]];
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
    [scrollView addSubview:self.placeTextField];
    [self.placeTextField makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(startTimeLabel);
        make.centerY.equalTo(thirdView);
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
    [scrollView addSubview:self.costTextField];
    [self.costTextField makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(startTimeLabel);
        make.centerY.equalTo(fourthView);
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
    fiveView.tag = 1;
    fiveView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:fiveView];
    [fiveView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(fourthView.bottom).offset(12);
        make.height.equalTo(50);
    }];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popSelectView:)];
    gesture.numberOfTapsRequired = 1;
    [fiveView addGestureRecognizer:gesture];
    
    UIImageView *image666 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yuanjiyuanxiao"]];
    [fiveView addSubview:image666];
    [image666 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image111);
        make.width.height.equalTo(image111);
        make.centerY.equalTo(0);
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
    UIImageView *jiantou5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantouxia"]];
    [fiveView addSubview:jiantou5];
    [jiantou5 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.right.equalTo(jiantou1);
        make.width.height.equalTo(jiantou1);
    }];
    [self.view layoutIfNeeded];
    
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(fiveView).offset(100);
    }];
    
}

- (void)publicActivity
{
    
}

- (void)clickBackground
{
    CGRect rect = self.popView.frame;
    CGRect rect1 = self.datePicker.frame;
    [UIView animateWithDuration:0.3 animations:^{
        [self.popView setFrame:CGRectMake(0, ScreenHeight, rect.size.width, rect.size.height)];
        [self.datePicker setFrame:CGRectMake(0, ScreenHeight, rect1.size.width, rect1.size.height)];
        self.backgroundView.alpha = 0;
    } completion:^(BOOL isfinished) {
        if (isfinished) {
            [self.popView removeFromSuperview];
            [self.datePicker removeFromSuperview];
            [self.backgroundView removeFromSuperview];
        }
    }];

}

- (void)popSelectView:(UITapGestureRecognizer *)gesture
{
    self.backgroundView.alpha = 0;
    [self.view addSubview:self.backgroundView];
    [self initPopViewWithType:gesture.view.tag];
    CGRect rect = self.popView.frame;
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundView.alpha = 1;
        [self.popView setFrame:CGRectMake(0, ScreenHeight - rect.size.height - 64, rect.size.width, rect.size.height)];
    }];
}

- (void)popDatePicker:(UITapGestureRecognizer *)gesture
{
    self.backgroundView.alpha = 0;
    self.datePicker.tag = gesture.view.tag;
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.datePicker];
    CGRect rect = self.datePicker.frame;
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundView.alpha = 1;
        [self.datePicker setFrame:CGRectMake(0, ScreenHeight - rect.size.height - 64, rect.size.width, rect.size.height)];
    }];
}

- (void)clickButton:(UIButton *)sender
{
    [self clickBackground];
    switch (sender.tag) {
        case 1:
            if ([sender.titleLabel.text isEqualToString:@"拍照"]) {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                }
                imagePicker.delegate = self;
                [self presentViewController:imagePicker animated:YES completion:nil];
            } else {        //院级
                self.typeLabel.text = @"院级";
            }
            break;
        case 2:
            if ([sender.titleLabel.text isEqualToString:@"相册选取"]) {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                imagePicker.delegate = self;
                [self presentViewController:imagePicker animated:YES completion:nil];
            } else {        //校级
                self.typeLabel.text = @"校级";
            }
            break;
        case 3:
            
            break;
            
        default:
            break;
    }
}

- (void)changeTime:(UIDatePicker *)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *nowDate = [sender date];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *nowString = [dateFormatter stringFromDate:nowDate];

    if (sender.tag == 1) {
        self.startTimeLabel.text = nowString;
    } else {
        self.endTimeLabel.text = nowString;
    }
}

//添加收回键盘的手势
- (void)addTapGestureToRemoveKeyboard
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchScrollView)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:recognizer];
    
}

//收回键盘手势的target
- (void)touchScrollView
{
    [self.nameTextField resignFirstResponder];
    [self.describeTextView resignFirstResponder];
    [self.placeTextField resignFirstResponder];
    [self.costTextField resignFirstResponder];
}


//根据键盘高度重置把view往上移
- (void)setViewMovedUp:(BOOL)movedUp
{
    UIView *view = nil;
    if ([self.nameTextField isFirstResponder]) {
        view = self.nameTextField;
    } else if ([self.describeTextView isFirstResponder]) {
        view = self.describeTextView;
    } else if ([self.placeTextField isFirstResponder]) {
        view = self.placeTextField;
    } else if ([self.costTextField isFirstResponder]) {
        view = self.costTextField;
    }
    
    CGFloat upHeight = 0;
    if (ScreenHeight - self.keyboardHeight > view.frame.origin.y + view.frame.size.height + 120) {
        upHeight = 0;
    } else {
        upHeight = view.frame.origin.y + view.frame.size.height - (ScreenHeight - self.keyboardHeight) + 120;
    }
    
    if (movedUp) {
        self.lastOffsetY = self.scrollView.contentOffset.y;
        [self.scrollView setContentOffset:CGPointMake(0, upHeight) animated:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(0, self.lastOffsetY) animated:YES];
    }
    
    
}


//=========================获取键盘高度=======================
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}
//键盘弹出同事改变offset
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.keyboardHeight = keyboardRect.size.height;
    [self setViewMovedUp:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [self setViewMovedUp:NO];
}
//==========================================================

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

#pragma mark - UIImagePicker
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.image.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
