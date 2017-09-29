//
//  AppDelegate.m
//  JsonForModel
//
//  Created by jk on 2016/12/29.
//  Copyright © 2016年 jk. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property(nonatomic,strong)NSWindow* mainWindow;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.mainWindow=[NSApplication sharedApplication].windows[0];
    // Insert code here to initialize your application
}
-(BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag{
    if (!flag) {
//        NSStoryboard* storyboard=[NSStoryboard storyboardWithName:@"Main" bundle:nil];
//        NSWindowController* window=[storyboard instantiateInitialController];
        [self.mainWindow makeKeyAndOrderFront:nil];
    }
    return YES;
}



- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
