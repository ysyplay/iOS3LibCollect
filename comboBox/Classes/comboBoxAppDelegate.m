//
//  comboBoxAppDelegate.m
//  comboBox
//
//  Created by duansong on 10-7-28.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "comboBoxAppDelegate.h"
#import "comboBoxViewController.h"

@implementation comboBoxAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
