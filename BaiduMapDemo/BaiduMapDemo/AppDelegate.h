//
//  AppDelegate.h
//  BaiduMapDemo
//
//  Created by Runa on 2017/8/15.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navigationController;
    BMKMapManager* _mapManager;
}
@property (strong, nonatomic) UIWindow *window;


@end

