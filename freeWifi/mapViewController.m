//
//  mapViewController.m
//  freeWifi
//
//  Created by 石峰铭 on 15/9/4.
//  Copyright (c) 2015年 shifengming. All rights reserved.
//

#define kLatitudeDelta 0.02703
#define kLongitudeDelta 0.01717

#define width self.view.frame.size.width
#define height self.view.frame.size.height

#import "mapViewController.h"
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
#import "MyAnnotationView.h"
#import "detailViewController.h"
#import "AppModel.h"

#import "MBProgressHUD.h"

@interface mapViewController ()<MKMapViewDelegate>
{
    MKMapView *_mapView;
    UIView *_navigationBar;
    NSMutableArray *_anoArr;
}
@end

@implementation mapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor lightGrayColor];
//    NSLog(@"%@,%@",self.baidu_lon,self.baidu_lat);
    //返回 btn
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 38, 38);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(tapBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    //    [self.navigationItem.leftBarButtonItem setCustomView:backBtn];
    self.navigationItem.leftBarButtonItems = @[item];
    
    _anoArr = [[NSMutableArray alloc]init];
    _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    
    _mapView.delegate = self;
    
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    _mapView.mapType = 0;
    
    MKCoordinateSpan span11 = MKCoordinateSpanMake(kLatitudeDelta, kLongitudeDelta);
    MKCoordinateRegion region11 = MKCoordinateRegionMake(self.coordinate, span11);

    [_mapView setRegion:region11];
    
    _mapView.showsUserLocation = YES;
    
     [self.view addSubview:_mapView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(screenTapped)];
    [self.view addGestureRecognizer:tap];
    
//    CGFloat height = self.view.frame.size.height;
    UIButton *backToUserLocation = [[UIButton alloc]initWithFrame:CGRectMake(20, height-70, 59, 59)];
    [backToUserLocation setImage:[UIImage imageNamed:@"map_locate@2x"] forState:UIControlStateNormal];
    [backToUserLocation setImage:[UIImage imageNamed:@"map_locate_hl@2x"] forState:UIControlStateHighlighted];
    [backToUserLocation addTarget:self action:@selector(backToUser) forControlEvents:UIControlEventTouchUpInside];
    [_mapView addSubview:backToUserLocation];
    
    for (int i = 0; i< self.arr.count; i++) {
        MyAnnotation *annoi = [[MyAnnotation alloc]init];
        AppModel *model = [[AppModel alloc]init];
        model = [self.arr objectAtIndex:i];
        annoi.title = model.name;
        annoi.subtitle = model.address;
        annoi.icon = @"category_3";
        annoi.coordinate = CLLocationCoordinate2DMake([model.baidu_lat floatValue], [model.baidu_lon floatValue]);
        annoi.tag = 100+i;
        [_mapView addAnnotation:annoi];
        [_anoArr addObject:annoi];
        //大头针创建是无序的 不会按照数组的顺序来
    }
}


-(void)tapBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)screenTapped
{
    if (_navigationBar.hidden == NO) {
        [UIView animateWithDuration:0.24 animations:^{
            _navigationBar.alpha = 0.0;
        } completion:^(BOOL finished) {
            _navigationBar.hidden = YES;
            [NSObject cancelPreviousPerformRequestsWithTarget:self];
        }];
    }
    else
    {
        _navigationBar.hidden = NO;
        [UIView animateWithDuration:0.24 animations:^{
            _navigationBar.alpha = 1.0;
        } completion:^(BOOL finished) {
            [self performSelector:@selector(screenTapped) withObject:nil afterDelay:3.0f];
        }];
    }
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    MyAnnotationView *myAnnoView = [MyAnnotationView myAnnoViewWithMapView:mapView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    btn.tag = 100+_
    for (int i= 0; i< _anoArr.count; i++) {
        if (_anoArr[i] == annotation) {
            btn.tag = 100+i;
        }
    }
    
    myAnnoView.rightCalloutAccessoryView = btn;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(beTapped:)];
    [myAnnoView.rightCalloutAccessoryView addGestureRecognizer:tap];
    return myAnnoView;
}

-(void)beTapped:(UITapGestureRecognizer *)tap
{
    detailViewController *detailVC = [[detailViewController alloc]init];
    
//    MyAnnotationView *tapView = (MyAnnotationView *)tap.view.superview;
////    tapView.sub
//    NSLog(@"%@",tap.view.tag);self.arr.count
    NSInteger index = tap.view.tag;
//    for (int i = 0; i<index; i++) {
        AppModel *model = [[AppModel alloc]init];
        model = [self.arr objectAtIndex:index-100];
        detailVC.model = model;
//        detailVC.name = self.name;
//        detailVC.address = self.address;
//        detailVC.distance = self.distance;
//        detailVC.intro = self.intro;
//    }
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)backToUser
{
    MKCoordinateSpan span = MKCoordinateSpanMake(kLatitudeDelta, kLongitudeDelta);
    MKCoordinateRegion region = MKCoordinateRegionMake(_mapView.userLocation.location.coordinate, span);
    [_mapView setRegion:region animated:YES];
    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D coordinate = userLocation.location.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(kLatitudeDelta, kLongitudeDelta);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [_mapView setRegion:region animated:YES];

    
    
    //画圈
//    CLLocationCoordinate2D coordinater = CLLocationCoordinate2DMake(self.baidu_lat, self.baidu_lon);
    MKCircle *circleTargePlace=[MKCircle circleWithCenterCoordinate:coordinate radius:2000];
    [_mapView addOverlay:circleTargePlace];

    MKCoordinateRegion MKCoordinateRegionForMapRect(MKMapRect rect);
}

- (void)dealloc {
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode  = MKUserTrackingModeNone;
    [_mapView.layer removeAllAnimations];
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView removeOverlays:_mapView.overlays];
    [_mapView removeFromSuperview];
    _mapView.delegate = nil;
    _mapView = nil;
}

//-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
//{
//    [_mapView removeFromSuperview];
//    [self.view addSubview:_mapView];
//}

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
//    MKOverlayView *view=nil;
    if ([overlay isKindOfClass:[MKCircle class]]) {
        MKCircleView *cirView =[[MKCircleView alloc] initWithCircle:overlay];
//        NSLog(@"~~~2222~~");
        cirView.fillColor=[UIColor redColor];
        cirView.strokeColor=[UIColor redColor];
        cirView.alpha=1;
        cirView.lineWidth=4.0;
//        view=[cirView autorelease];
        
    }
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
