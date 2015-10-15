//
//  ViewController.m
//  freeWifi
//
//  Created by 石峰铭 on 15/9/3.
//  Copyright (c) 2015年 shifengming. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "aroundWifiViewController.h"

#import "btRippleButtton.h"
#import "Masonry.h"
@interface ViewController ()<CLLocationManagerDelegate>
{
    CLLocationCoordinate2D coordinate;
}
@property (nonatomic, strong) CLLocationManager *mgr;

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor lightGrayColor];
    
//    CGFloat x = self.view.frame.size.width/4;
//    CGFloat y = self.view.frame.size.height/2;
    
    UIImageView *background = [[UIImageView alloc]initWithFrame:self.view.bounds];
    UIImage *image = [UIImage imageNamed:@"homeBackground.jpg"];
    background.contentMode = UIViewContentModeScaleAspectFill;
    background.image = image;
    [self.view addSubview:background];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    effectView.frame = background.bounds;
    [background addSubview:effectView];
    
    effectView.alpha = 0.7f;
    //x, 150, 200, 100)
    CGPoint center = self.view.center;
    center.y = self.view.center.y / 2;
    UILabel *startLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];
    startLbl.text = @"寻找身边的Free-Wifi";
    startLbl.center = center;
    [startLbl setFont:[UIFont fontWithName:@"Zapfino" size:17.0]];
    [self.view addSubview:startLbl];
    
    BTRippleButtton *rippleBtn = [[BTRippleButtton alloc]initWithImage:[UIImage imageNamed:@"map_locate"] andFrame:CGRectMake(center.x-49/2, self.view.center.y, 49, 49) andTarget:@selector(startTapped) andID:self];
    [rippleBtn setRippeEffectEnabled:YES];
    [rippleBtn setRippleEffectWithColor:[UIColor colorWithRed:240/255.f green:159/255.f blue:10/255.f alpha:1]];
    [self.view addSubview:rippleBtn];


    //定位
    if ([self.mgr respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.mgr requestAlwaysAuthorization];
    }
    [self.mgr startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    coordinate = location.coordinate;
//     NSLog(@"%f,%f",coordinate.latitude,coordinate.longitude);
    [manager stopUpdatingLocation];
}

-(CLLocationManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [[CLLocationManager alloc]init];
        
        _mgr.distanceFilter = 50;
        
        _mgr.desiredAccuracy = kCLLocationAccuracyBest;
        
        _mgr.delegate = self;
    }
    return _mgr;
}

-(void)startTapped
{
    aroundWifiViewController *aroundVC = [[aroundWifiViewController alloc]init];
    aroundVC.coordinate = coordinate;
    [self.navigationController pushViewController:aroundVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
