//
//  detailCell.m
//  freeWifi
//
//  Created by 石峰铭 on 15/9/6.
//  Copyright (c) 2015年 shifengming. All rights reserved.
//

#import "detailCell.h"

@implementation detailCell
{
    UIView *_view;
    UILabel *_introLbl;
}
- (void)awakeFromNib {
    
}

-(void)setModel:(AppModel *)model
{
    _model = model;
    _name.text = model.name;
    _name.numberOfLines = 0;
    _adress.text = model.address;
    _adress.numberOfLines = 0;
    _distance.text = [NSString stringWithFormat:@"%@米",(NSString *)model.distance];
    
//    
//    CGSize size = [self sizeWithText:model.intro font:[UIFont systemFontOfSize:17.0f] size:CGSizeMake(270, MAXFLOAT)];
//    _view.frame = CGRectMake(0, 0, size.width, size.height);
//    _introLbl.frame = _view.bounds;
    _intro.text = model.intro;
    _intro.font = [UIFont systemFontOfSize:15.0f];
//    _introLbl.text = model.intro;
   _intro.numberOfLines = 0;
//    _introLbl.font = [UIFont systemFontOfSize:17.0f];
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font size:(CGSize)size
{
    /** 1,CGSize 宽是固定的，高度不固定
     2,Options 记住用枚举值的第二个和第三个
     3,attributes :文本的一系列属性,我们只需要设置字体
     4,context
     */
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : font} context:nil];
    return rect.size;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end
