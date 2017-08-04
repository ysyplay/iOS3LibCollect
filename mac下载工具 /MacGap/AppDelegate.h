//
//  AppDelegate.h
//  MG
//
//  Created by Tim Debo on 5/19/14.
//
//

#import <Cocoa/Cocoa.h>

@class WindowController;

@interface AppDelegate : NSObject <NSApplicationDelegate,NSUserNotificationCenterDelegate>{
    NSWindowController *_preferencesWindowController;
    
}


@property (retain, nonatomic) WindowController *windowController;
@property (nonatomic, readonly) NSWindowController *preferencesWindowController;
@property (nonatomic) NSInteger focusedAdvancedControlIndex;

- (IBAction)openPreferences:(id)sender;



@end
