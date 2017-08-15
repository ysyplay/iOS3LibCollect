//
//  ViewController.m
//  BaiduMapDemo
//
//  Created by Runa on 2017/8/15.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import "ViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController () <BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKMapView* mapView;
    BMKLocationService* locService;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化BMKLocationService
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8) {
//        //由于IOS8中定位的授权机制改变 需要进行手动授权
//        CLLocationManager  *locationManager = [[CLLocationManager alloc] init];
//        //获取授权认证
//        [locationManager requestAlwaysAuthorization];
//        [locationManager requestWhenInUseAuthorization];
//    }
    locService = [[BMKLocationService alloc]init];//这里必须定义全局变量,否则定位对象被释放
    locService.distanceFilter = 10;
    locService.headingFilter = 3;
    locService.delegate = self;
    [locService setDesiredAccuracy:kCLLocationAccuracyBest];//设置定位精度
    //启动LocationService
    [locService startUserLocationService];
    
    mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.view = mapView;
    mapView.showsUserLocation = NO;
    mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态,
    mapView.showsUserLocation = YES;//显示定位图层
    mapView.delegate = self;
    [mapView setZoomLevel:16];
    
    // 添加一个PointAnnotation
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    annotation.coordinate = coor;
    annotation.title = @"故宫博物院";
    [mapView addAnnotation:annotation];

}
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}
//处理位置坐标更新
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    mapView.showsUserLocation = YES;//显示定位图层
    [mapView updateLocationData:userLocation];
    NSLog(@"方向");
}
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //普通态
    //以下_mapView为BMKMapView对象
    mapView.showsUserLocation = YES;//显示定位图层
    [mapView updateLocationData:userLocation];
    NSLog(@"定位");

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
