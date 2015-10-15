//
//  AppModel.h
//  freeWifi
//
//  Created by 石峰铭 on 15/9/3.
//  Copyright (c) 2015年 shifengming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppModel : NSObject

@property (nonatomic, copy) NSString *reason;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *baidu_lat;

@property (nonatomic, copy) NSString *baidu_lon;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, copy) NSString *distance;

-(NSComparisonResult)compareByDistance:(AppModel *)amodel;

@end
