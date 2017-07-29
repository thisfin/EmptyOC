//
//  SettingWindow.h
//  EmptyOC
//
//  Created by wenyou on 2017/7/10.
//  Copyright © 2017年 wenyou. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ViewController;

@interface SettingWindow : NSWindow
@property (nonatomic, weak) ViewController *parentController;
@end
