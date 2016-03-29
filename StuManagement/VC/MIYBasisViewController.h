//
//  MIYBasisViewController.h
//  StuManagement
//
//  Created by MiY on 16/3/25.
//  Copyright © 2016年 miao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIYBasisViewController : UIViewController

- (void)leftItemTapped;
- (void)rightItemTapped;

- (void)setLeftNaviItemWithTitle:(NSString *)title OrImageName:(NSString *)imageName;
- (void)setRightNaviItemWithTitle:(NSString *)title OrImageName:(NSString *)imageName;
- (UIView *)addLineToSuperView:(UIView *)superView underView:(UIView *)view withGap:(CGFloat)gap;
- (void)makeView:(UIView *)view toRoundCorner:(CGFloat)radius withWidth:(CGFloat)width color:(UIColor *)color;

@end
