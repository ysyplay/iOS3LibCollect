//
//  comboBoxAppDelegate.h
//  comboBox
//
//  Created by duansong on 10-7-28.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class comboBoxViewController;

@interface comboBoxAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    comboBoxViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet comboBoxViewController *viewController;

@end

