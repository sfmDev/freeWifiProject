//
//  MyAnnotationView.h
//  freeWifi
//
//  Created by 石峰铭 on 15/9/6.
//  Copyright (c) 2015年 shifengming. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MyAnnotationView : MKAnnotationView

+(instancetype)myAnnoViewWithMapView:(MKMapView *)mapview;

@end
