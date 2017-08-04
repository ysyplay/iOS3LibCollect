
#import "GeneralPreferencesViewController.h"

@implementation GeneralPreferencesViewController

- (id)init
{
    return [super initWithNibName:@"GeneralPreferencesView" bundle:nil];
}

#pragma mark -
#pragma mark MASPreferencesViewController

- (NSString *)identifier
{
    return @"GeneralPreferences";
}

- (NSImage *)toolbarItemImage
{
    return [NSImage imageNamed:NSImageNamePreferencesGeneral];
}

- (NSString *)toolbarItemLabel
{
    return NSLocalizedString(@"General", @"Toolbar item name for the General preference pane");
}

- (IBAction)deleteAria2GUISH:(id __unused)sender
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *supportPath=[NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"%@/%@/sh/",supportPath,[[NSBundle mainBundle] bundleIdentifier]];
    NSString *startAriaPath = [path stringByAppendingPathComponent:@"Aria2GUI.sh"];
    if ([fileManager fileExistsAtPath:startAriaPath])
    {
        NSLog(@"文件存在，删除配置文件");
        [fileManager removeItemAtPath:startAriaPath error:NULL];

    }
    
    else
    {
        NSLog(@"文件不存在");
    }
    
}

- (IBAction)editAria2GUISH:(id __unused)sender
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *supportPath=[NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"%@/%@/sh/",supportPath,[[NSBundle mainBundle] bundleIdentifier]];
    NSString *startAriaPath = [path stringByAppendingPathComponent:@"Aria2GUI.sh"];
    if ([fileManager fileExistsAtPath:startAriaPath])
    {
        NSLog(@"文件存在，修改配置文件");
        [[NSWorkspace sharedWorkspace] openFile:startAriaPath withApplication:@"TextEdit"];
    }
    
    else
    {
        NSLog(@"文件不存在");
    }


}

@end
