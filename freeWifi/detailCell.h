//
//  detailCell.h
//  freeWifi
//
//  Created by 石峰铭 on 15/9/6.
//  Copyright (c) 2015年 shifengming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppModel.h"
@interface detailCell : UITableViewCell

@property (nonatomic, strong) AppModel *model;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *adress;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *intro;

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font size:(CGSize)size;
@end
