//
//  HomeViewController.h
//  Splash
//
//  Created by Mac on 16/4/1.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncSocket.h"
@interface HomeViewController : UIViewController
{
    AsyncSocket *socket;
}
@end
