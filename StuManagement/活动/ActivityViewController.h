//
//  ActivityViewController.h
//  StuManagement
//
//  Created by MiY on 16/3/25.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "MIYBasisViewController.h"

@interface ActivityViewController : MIYBasisViewController

@end

@interface ActivityTableViewCell : UITableViewCell

- (void)loadData:(NSDictionary *)data;

@end