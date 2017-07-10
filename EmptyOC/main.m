//
//  main.m
//  EmptyOC
//
//  Created by wenyou on 2017/7/10.
//  Copyright © 2017年 wenyou. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "AppDelegate.h"


int main(int argc, const char * argv[]) {
    AppDelegate *appDelegate = [[AppDelegate alloc] init];
    [NSApplication sharedApplication].delegate = appDelegate;

    return NSApplicationMain(argc, argv);
}
