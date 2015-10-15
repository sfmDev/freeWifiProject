//
//  AppCell.m
//  freeWifi
//
//  Created by 石峰铭 on 15/9/3.
//  Copyright (c) 2015年 shifengming. All rights reserved.
//

#import "AppCell.h"

@implementation AppCell
{
    UIView *_view;
}
- (void)awakeFromNib {

//    _view = [[UIView alloc]initWithFrame:self.window.frame];
//    [self.window addSubview:_view];
}

-(void)setModel:(AppModel *)model
{
    _model = model;
    _nameLabel.text = model.name;
    _nameLabel.font = [UIFont systemFontOfSize:17];
    _addressLabel.text = model.address;
    _addressLabel.numberOfLines = 0;
    _addressLabel.font = [UIFont systemFontOfSize:17];
//    _addressLabel.font = [UIFont systemFontOfSize:14];
    _addressLabel.adjustsFontSizeToFitWidth= YES;
    _distanceLabel.text = [NSString stringWithFormat:@"距离:%@米",(NSString *)model.distance];
    _distanceLabel.font = [UIFont systemFontOfSize:13];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
