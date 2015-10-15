//
//  navigateViewController.m
//  freeWifi
//
//  Created by 石峰铭 on 15/9/7.
//  Copyright (c) 2015年 shifengming. All rights reserved.
//

#import "navigateViewController.h"
#import <MapKit/MapKit.h>
@interface navigateViewController ()

@end

@implementation navigateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSString *destination = self.address;
//    NSLog(@"%@",destination);
//    
//    if (destination.length == 0) {
//        return;
//    }
    
//    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
//    
//    [geocoder geocodeAddressString:destination completionHandler:^(NSArray *placemarks, NSError *error) {
//        CLPlacemark *clpm = [placemarks firstObject];
//        NSLog(@"%@",clpm);
//        MKPlacemark *mkpm = [[MKPlacemark alloc]initWithPlacemark:clpm];
//        
//        MKMapItem *destinationItem = [[MKMapItem alloc]initWithPlacemark:mkpm];
//        
//        MKMapItem *sourceItem = [MKMapItem mapItemForCurrentLocation];
//        
//        [self startNavigateWithSourceItem:sourceItem destinationItem:destinationItem];
//        [MKMapItem openMapsWithItems:@[sourceItem, destinationItem]
//                       launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
//
//        
//    }];
    
    CLLocationCoordinate2D endCoor = CLLocationCoordinate2DMake([self.baidu_lat floatValue], [self.baidu_lon floatValue]);
    
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *destinationItem = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil]];
    destinationItem.name = self.address;
    
    [MKMapItem openMapsWithItems:@[currentLocation, destinationItem]
                   launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
}

- (void)startNavigateWithSourceItem:(MKMapItem *)sourceItem destinationItem:(MKMapItem *)destinationItem
{
    // 1.将起点和终点item放入数组中
    NSArray *items = @[sourceItem, destinationItem];
    
    // 2.设置Options参数(字典)
    NSDictionary *options = @{
                              MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
                              MKLaunchOptionsMapTypeKey : @(MKMapTypeHybrid),
                              MKLaunchOptionsShowsTrafficKey : @YES
                              };
    
    // 3.开始导航
    [MKMapItem openMapsWithItems:items launchOptions:options];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
