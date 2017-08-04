
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



- (IBAction)editAria2GUISH:(id __unused)sender
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"aria2" ofType:@"conf"];
    if ([fileManager fileExistsAtPath:path])
    {
        NSLog(@"文件存在，修改配置文件");
        [[NSWorkspace sharedWorkspace] openFile:path withApplication:@"TextEdit"];
        
    }
    
    else
    {
        NSLog(@"文件不存在");
    }


}

@end
