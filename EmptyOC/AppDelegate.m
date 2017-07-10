//
//  AppDelegate.m
//  EmptyOC
//
//  Created by wenyou on 2017/7/10.
//  Copyright © 2017年 wenyou. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"


@implementation AppDelegate {
    NSWindow *_window;
    NSViewController *viewController;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    _window = [[NSWindow alloc] initWithContentRect: CGRectZero
                                          styleMask: NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskTitled | NSWindowStyleMaskResizable
                                            backing: NSBackingStoreBuffered
                                              defer: NO];
    _window.minSize = CGSizeMake(600, 480);
    viewController = [[ViewController alloc] init];
    _window.contentViewController = viewController;
    [_window center];
    [_window makeKeyAndOrderFront:self];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
}
@end
