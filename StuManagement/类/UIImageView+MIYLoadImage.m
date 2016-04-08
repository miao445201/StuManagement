//
//  UIImageView+MIYLoadImage.m
//  StuManagement
//
//  Created by MiY on 16/4/8.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "UIImageView+MIYLoadImage.h"

@implementation UIImageView (MIYLoadImage)

- (void)loadImageWithUrl:(NSString *)url
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        dispatch_async(dispatch_get_main_queue(), ^() {
            [activity setFrame:CGRectMake(0, 0, 30, 30)];
            [activity setCenter:self.center];
            [activity startAnimating];
            [self addSubview:activity];
        });
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        dispatch_async(dispatch_get_main_queue(), ^() {
            [activity stopAnimating];
            [self setImage:[UIImage imageWithData:data]];
        });
    });
    
}

@end
