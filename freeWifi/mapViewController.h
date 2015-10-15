//
//  mapViewController.h
//  freeWifi
//
//  Created by 石峰铭 on 15/9/4.
//  Copyright (c) 2015年 shifengming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface mapViewController : UIViewController

@property (nonatomic, copy) NSString *reason;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *baidu_lat;

@property (nonatomic, copy) NSString *baidu_lon;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, copy) NSString *distance;

@property (nonatomic, assign) NSMutableArray *arr;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
