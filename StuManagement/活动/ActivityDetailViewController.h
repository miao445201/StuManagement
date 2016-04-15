//
//  ActivityDetailViewController.h
//  StuManagement
//
//  Created by MiY on 16/4/8.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "MIYBasisViewController.h"

@interface ActivityDetailViewController : MIYBasisViewController

@property (nonatomic) BOOL isFromMine;
@property (nonatomic, strong) NSDictionary *data;

@end

@interface ActivityMoreCommentController : MIYBasisViewController

@property (nonatomic, strong) NSMutableArray *comments;

@end

@interface ActivityCommentController : MIYBasisViewController

@end
