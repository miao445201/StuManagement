//
//  MineSubTableViewCell.m
//  StuManagement
//
//  Created by MiY on 16/4/10.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "MineSubTableViewCell.h"

@interface MineSubTableViewCell ()

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation MineSubTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
    }
    return self;
}

- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)initSubViews
{
    self.image = [[UIImageView alloc] init];
    [self.contentView addSubview:self.image];
    [self.image makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(10);
        make.bottom.equalTo(-10);
        make.width.equalTo(self.image.height);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = kMainBlackColor;
    self.nameLabel.font = [UIFont systemFontOfSize:17.0];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.image.right).offset(10);
        make.bottom.equalTo(self.image.centerY).offset(-10);
    }];
    
    UIImageView *timeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shijian"]];
    [self.contentView addSubview:timeImage];
    [timeImage makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.image.centerY).offset(13);
        make.left.equalTo(self.nameLabel);
        make.width.height.equalTo(15);
    }];

    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textColor = kMainBlackColor;
    self.timeLabel.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(timeImage).offset(-1);
        make.left.equalTo(timeImage.right).offset(5);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(0);
        make.height.equalTo(0.5);
    }];
}


- (void)loadData:(NSDictionary *)data
{
    [self.image setImage:data[@"image"]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@", data[@"name"]];
    self.timeLabel.text = [NSString stringWithFormat:@"%@", data[@"time"]];

}
@end
