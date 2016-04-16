//
//  SpotlightViewController.h
//  StuManagement
//
//  Created by MiY on 16/3/25.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "MIYBasisViewController.h"

@interface SpotlightViewController : MIYBasisViewController

@end

@interface SpotlightTableCell : UITableViewCell

- (void)loadData:(NSDictionary *)data;

@end

@interface  SpotlightDetailController: MIYBasisViewController

@property (nonatomic, strong) NSDictionary *data;

@end