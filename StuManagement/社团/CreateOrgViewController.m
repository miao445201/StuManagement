//
//  CreateOrgViewController.m
//  StuManagement
//
//  Created by MiY on 16/3/26.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "CreateOrgViewController.h"

@interface CreateOrgViewController () <UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UITextView *introductionTextView;
@property (nonatomic, strong) UITextView *noticeTextView;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic) CGFloat keyboardHeight;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *popView;
@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation CreateOrgViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kLightWhiteColor;
    [self setRightNaviItemWithTitle:@"提交申请" OrImageName:nil];
    [self loadSubViews];
    [self addTapGestureToRemoveKeyboard];
    [self registerForKeyboardNotifications];

}

- (void)rightItemTapped
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:@"确认提交创建申请?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消"
                                              style:UIAlertActionStyleDefault
                                            handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action) {
                                                [self showHUDwithMessage:@"已提交申请" imageName:@"success.png"];
                                                [self.navigationController popViewControllerAnimated:YES];
                                            }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)loadSubViews
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    [self.view addSubview:self.scrollView];
    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.equalTo(self.view);
    }];

    self.image = [[UIImageView alloc] init];
    self.image.tag = 0;
    [self.image setImage:[UIImage imageNamed:@"tianjiashetuan"]];
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
    self.nameTextField.placeholder = @"输入社团名称";
    self.nameTextField.borderStyle = UITextBorderStyleNone;
    self.nameTextField.font = [UIFont systemFontOfSize:15.0];
    [scrollView addSubview:self.nameTextField];
    [self.nameTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(firstView);
        make.left.equalTo(image111.right).offset(10);
        make.height.equalTo(55);
    }];

    [self addLineToSuperView:firstView underView:self.nameTextField withGap:0];

    self.introductionTextView = [[UITextView alloc] init];
    self.introductionTextView.delegate = self;
    self.introductionTextView.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.24];
    self.introductionTextView.text = @"填写社团描述,让更多的人参加社团...";
    self.introductionTextView.tag = 1;
    self.introductionTextView.font = [UIFont systemFontOfSize:15.0];
    [self.introductionTextView setTextContainerInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    [scrollView addSubview:self.introductionTextView];
    [self.introductionTextView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameTextField.bottom).offset(1);
        make.left.right.bottom.equalTo(firstView);
    }];

    self.noticeTextView = [[UITextView alloc] init];
    self.noticeTextView.backgroundColor = [UIColor whiteColor];
    self.noticeTextView.delegate = self;
    self.noticeTextView.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.24];
    self.noticeTextView.text = @"填写社团公告...";
    self.noticeTextView.tag = 2;
    self.noticeTextView.font = [UIFont systemFontOfSize:15.0];
    [self.noticeTextView setTextContainerInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    [scrollView addSubview:self.noticeTextView];
    [self.noticeTextView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(firstView.bottom).offset(15);
        make.height.equalTo(120);
    }];
    
    //5555555
    UIView *fiveView = [[UIView alloc] init];
    fiveView.tag = 1;
    fiveView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:fiveView];
    [fiveView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(self.noticeTextView.bottom).offset(12);
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
    cost.text = @"社团类别";
    cost.font = [UIFont systemFontOfSize:15.0];
    [fiveView addSubview:cost];
    [cost makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image666.right).offset(10);
        make.centerY.equalTo(0);
    }];
    self.typeLabel = [[UILabel alloc] init];
    self.typeLabel.font = [UIFont systemFontOfSize:14.0];
    self.typeLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.24];
    self.typeLabel.text = @"院级";
    [fiveView addSubview:self.typeLabel];
    [self.typeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-28);
        make.centerY.equalTo(0);
    }];
    UIImageView *jiantou5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantouxia"]];
    [fiveView addSubview:jiantou5];
    [jiantou5 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.right.equalTo(-8);
        make.width.height.equalTo(15);
    }];
    [self.view layoutIfNeeded];
    
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(fiveView).offset(100);
    }];

    /*
    
    UILabel *noticeLabel = [[UILabel alloc] init];
    noticeLabel.text = @"公告:";
    noticeLabel.textColor = [UIColor lightGrayColor];
    noticeLabel.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:noticeLabel];
    
    self.noticeTextView = [[UITextView alloc] init];
    self.noticeTextView.backgroundColor = [UIColor whiteColor];
    self.noticeTextView.delegate = self;
    [self.scrollView addSubview:self.noticeTextView];

    
    [self.nameTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.height.equalTo(43);
        make.width.equalTo(self.view.width);
    }];
   
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:line1];
    [line1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(self.nameTextField.bottom).offset(5);
        make.height.equalTo(0.5);
    }];
    
    [logoLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(self.scrollView.left).offset(80);
        make.top.equalTo(self.nameTextField.bottom).offset(5);
        make.height.equalTo(30);
    }];
    
    [self.logoImageButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoLabel.bottom).offset(5);
        make.centerX.equalTo(self.view);
        make.size.equalTo(CGSizeMake(100, 100));
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:line2];
    [line2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(self.logoImageButton.bottom).offset(30);
        make.height.equalTo(0.5);
    }];
    
    
    
    [introductionLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageButton.bottom).offset(35);
        make.left.right.height.equalTo(logoLabel);
    }];
    
    [self.introductionTextView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(introductionLabel.bottom).offset(5);
        make.right.equalTo(-15);
        make.height.equalTo(150);
    }];
    
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:line3];
    [line3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(self.introductionTextView.bottom).offset(10);
        make.height.equalTo(0.5);
    }];
    
    [noticeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(logoLabel);
        make.top.equalTo(self.introductionTextView.bottom).offset(15);
    }];
    
    [self.noticeTextView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.introductionTextView);
        make.top.equalTo(noticeLabel.bottom).offset(5);
        make.height.equalTo(80);
    }];
    
    
    UIView *line4 = [[UIView alloc] init];
    line4.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:line4];
    [line4 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(self.noticeTextView.bottom).offset(10);
        make.height.equalTo(0.5);
    }];
    
    UIButton *whetherPremium = [[UIButton alloc] init];
    [whetherPremium setTitle:@"是否收费" forState:UIControlStateNormal];
    [whetherPremium setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [whetherPremium setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 250)];
    whetherPremium.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.scrollView addSubview:whetherPremium];
    [whetherPremium makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.right.equalTo(0);
        make.top.equalTo(self.noticeTextView.bottom).offset(10);
        make.height.equalTo(self.nameTextField);
    }];

    UIView *line5 = [[UIView alloc] init];
    line5.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:line5];
    [line5 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(whetherPremium.bottom);
        make.height.equalTo(0.5);
    }];

    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(whetherPremium).offset(80);
    }];
     */
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

- (void)clickBackground
{
    CGRect rect = self.popView.frame;
    [UIView animateWithDuration:0.3 animations:^{
        [self.popView setFrame:CGRectMake(0, ScreenHeight, rect.size.width, rect.size.height)];
        self.backgroundView.alpha = 0;
    } completion:^(BOOL isfinished) {
        if (isfinished) {
            [self.popView removeFromSuperview];
            [self.backgroundView removeFromSuperview];
        }
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


//根据键盘高度重置把view往上移
- (void)setViewMovedUp:(BOOL)movedUp
{
    UITextView *textView = nil;
    if ([self.introductionTextView isFirstResponder]) {
        textView = self.introductionTextView;
    } else if ([self.noticeTextView isFirstResponder]) {
        textView = self.noticeTextView;
    }
    
    CGFloat upHeight = 0;
    if (ScreenHeight - self.keyboardHeight > textView.frame.origin.y + textView.frame.size.height + 120) {
        upHeight = 0;
    } else {
        upHeight = textView.frame.origin.y + textView.frame.size.height - (ScreenHeight - self.keyboardHeight) + 120;
    }
    
    if (movedUp) {
        [self.scrollView setContentOffset:CGPointMake(0, upHeight) animated:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
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
    [self.introductionTextView resignFirstResponder];
    [self.noticeTextView resignFirstResponder];
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
    if (textView.tag == 1) {
        if ([textView.text isEqualToString:@"填写社团描述,让更多的人参加社团..."]) {
            textView.text = @"";
            textView.textColor = kMainBlackColor;
        }
    } else {
        if ([textView.text isEqualToString:@"填写社团公告..."]) {
            textView.text = @"";
            textView.textColor = kMainBlackColor;
        }

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
        if (textView.tag == 1) {
            textView.text = @"填写社团描述,让更多的人参加社团...";
        } else {
            textView.text = @"填写社团公告...";
        }
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
