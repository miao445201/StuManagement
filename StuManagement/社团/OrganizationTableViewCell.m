//
//  OrganizationTableViewCell.m
//  StuManagement
//
//  Created by MiY on 16/3/25.
//  Copyright © 2016年 miao. All rights reserved.
//

#import "OrganizationTableViewCell.h"

@interface OrganizationTableViewCell ()

@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *organization;
@property (nonatomic, strong) UILabel *numberOfPeople;

@end

@implementation OrganizationTableViewCell

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

    if (selected) {
        NSLog(@"selected");
    } else {
        NSLog(@"not selected");
    }
}


- (void)initSubViews
{
    self.image = [[UIImageView alloc] init];
    self.name = [[UILabel alloc] init];
    self.organization = [[UILabel alloc] init];
    self.numberOfPeople = [[UILabel alloc] init];
    
    self.image.contentMode = UIViewContentModeScaleToFill;
    
    self.name.font = [UIFont systemFontOfSize:14.0];
    self.organization.font = [UIFont systemFontOfSize:13.0];
    self.numberOfPeople.font = [UIFont systemFontOfSize:11.0];
    
    self.organization.textColor = [UIColor grayColor];
    self.numberOfPeople.textColor = [UIColor lightGrayColor];
    
    self.numberOfPeople.textAlignment = NSTextAlignmentRight;
    
    [self.contentView addSubview:self.image];
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.organization];
    [self.contentView addSubview:self.numberOfPeople];
    
    [self.image makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(12);
        make.bottom.equalTo(-12);
        make.width.equalTo(self.image.height);
    }];
    
    [self.name makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.image.right).offset(10);
        make.bottom.equalTo(self.contentView.centerY).offset(-8);
    }];
    
    [self.organization makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name);
        make.top.equalTo(self.contentView.centerY).offset(8);
    }];

    [self.numberOfPeople makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.organization.right).offset(10);
        make.right.equalTo(-15);
        make.bottom.equalTo(self.organization);
    }];
    
}

- (void)loadData:(NSDictionary *)data
{
    [self.image setImage:data[@"image"]];
    self.name.text = [NSString stringWithFormat:@"%@", data[@"name"]];
    self.organization.text = [NSString stringWithFormat:@"所属学院:%@", data[@"organization"]];
    self.numberOfPeople.text = [NSString stringWithFormat:@"成员%@人", data[@"numberOfPeople"]];
}


@end
