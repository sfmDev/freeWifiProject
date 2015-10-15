//
//  AppCell.h
//  freeWifi
//
//  Created by 石峰铭 on 15/9/3.
//  Copyright (c) 2015年 shifengming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppModel.h"
@interface AppCell : UITableViewCell

@property (nonatomic, strong) AppModel *model;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@end
