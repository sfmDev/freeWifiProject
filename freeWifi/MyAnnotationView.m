//
//  MyAnnotationView.m
//  freeWifi
//
//  Created by 石峰铭 on 15/9/6.
//  Copyright (c) 2015年 shifengming. All rights reserved.
//

#import "MyAnnotationView.h"
#import "MyAnnotation.h"
@implementation MyAnnotationView

+(instancetype)myAnnoViewWithMapView:(MKMapView *)mapview
{
    static NSString *ID = @"myAnnoView";
    MyAnnotationView *myAnnoView = (MyAnnotationView *)[mapview dequeueReusableAnnotationViewWithIdentifier:ID];
    
    if (myAnnoView == nil) {
        myAnnoView = [[MyAnnotationView alloc]initWithAnnotation:nil reuseIdentifier:ID];
        
        myAnnoView.canShowCallout = YES;
        
//        myAnnoView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    return myAnnoView;
}


-(void)setAnnotation:(MyAnnotation *)annotation
{
    self.image = [UIImage imageNamed:annotation.icon];
    [super setAnnotation:annotation];
}
@end
