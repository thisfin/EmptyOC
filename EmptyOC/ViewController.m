//
//  ViewController.m
//  EmptyOC
//
//  Created by wenyou on 2017/7/10.
//  Copyright © 2017年 wenyou. All rights reserved.
//

#import "ViewController.h"

#import "Font.h"
#import <Masonry/Masonry.h>

@implementation ViewController

- (void)loadView {
    self.view = [[NSView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = NSColor.blackColor.CGColor;
    self.view.autoresizingMask = NSViewHeightSizable | NSViewWidthSizable;

    self.view.frame = [[NSScreen mainScreen] visibleFrame];
    NSLog(@"%f %f", [[NSScreen mainScreen] visibleFrame].size.width, [[NSScreen mainScreen] visibleFrame].size.height);

    CGFloat height = [[NSScreen mainScreen] visibleFrame].size.height / 2;
    if ([[NSScreen mainScreen] visibleFrame].size.width < [[NSScreen mainScreen] visibleFrame].size.height) {
        height = [[NSScreen mainScreen] visibleFrame].size.width / 3.5;
    }


    NSTextField *hourTextField = [NSTextField labelWithString:@""];
    hourTextField.backgroundColor = NSColor.clearColor;
    hourTextField.textColor = NSColor.blueColor;
    hourTextField.alignment = NSTextAlignmentCenter;
//    hourTextField.stringValue = @"24:88";

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"24:88 88"];
    [attributedString addAttribute:NSFontAttributeName value:[[Font shareInstance] fontOfSize:height name:@"DigitalDismay"] range:NSMakeRange(0, 5)];
    [attributedString addAttribute:NSFontAttributeName value:[[Font shareInstance] fontOfSize:height / 2 name:@"DigitalDismay"] range:NSMakeRange(5, 3)];
    hourTextField.attributedStringValue = attributedString;

    [self.view addSubview:hourTextField];
    [hourTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.centerX.equalTo(self.view);
//        make.left.equalTo(self.view).offset(200);
    }];

    NSTextField *dayTextField = [NSTextField labelWithString:@""];
    dayTextField.font = [[Font shareInstance] fontOfSize:height / 3 name:@"DigitalDismay"];
    dayTextField.backgroundColor = NSColor.clearColor;
    dayTextField.textColor = NSColor.blueColor;
    dayTextField.alignment = NSTextAlignmentCenter;
    dayTextField.stringValue = @"2017 12 12";
    [self.view addSubview:dayTextField];
    [dayTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(hourTextField.mas_top).offset(50);
        make.left.equalTo(hourTextField);
    }];

    NSTextField *upTextField = [NSTextField labelWithString:@" AM PM"];
    upTextField.font = [[Font shareInstance] fontOfSize:height / 6 name:@"DS-Digital"];
    upTextField.backgroundColor = NSColor.clearColor;
    upTextField.textColor = NSColor.blueColor;
    upTextField.alignment = NSTextAlignmentCenter;
    [self.view addSubview:upTextField];
    [upTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(hourTextField.mas_top).offset(50);
        make.right.equalTo(hourTextField);
        make.baseline.equalTo(dayTextField);
    }];

    NSView *weekView = [[NSView alloc] init];
    [self.view addSubview:weekView];
    [weekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hourTextField);
        make.right.equalTo(hourTextField);
        make.top.equalTo(hourTextField.mas_bottom).offset(0 - 50);
    }];

    NSArray<NSString *> *array = @[@"MON", @"TUE", @"WED", @"THU", @"FRI", @"SAT", @"SUN"];
    //enumerateObjectsUsingBlock
    NSMutableArray<NSTextField *> *weekTextFields = [[NSMutableArray alloc] init];
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSTextField *textField = [self getWeek];
        textField.stringValue = obj;
        [weekView addSubview:textField];
        [weekTextFields addObject:textField];
    }];
    [weekTextFields mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weekView);
    }];
//    [weekTextFields mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:120 leadSpacing:0 tailSpacing:0];
    [weekTextFields mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:50 leadSpacing:0 tailSpacing:0];
    [weekView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(weekTextFields[0]);
    }];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)viewWillAppear {
    [super viewWillAppear];

//    NSView *v = [[NSView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:v];
//    v.wantsLayer = YES;
//    v.layer.backgroundColor = NSColor.grayColor.CGColor;


//    Font *font = [Font shareInstance];
//
//    NSTextField *backTextField = [NSTextField labelWithString:@"88:88888888"];
//    [self.view addSubview:backTextField];
//    backTextField.font = [font fontOfSize:500 name:@"DigitalDismay"];
////    backTextField.font = [NSFont systemFontOfSize:20];
//    backTextField.backgroundColor = NSColor.clearColor;
//    backTextField.textColor = NSColor.grayColor;
//    backTextField.alignment = NSTextAlignmentCenter;
////    backTextField.stringValue = @"8888888888";
//    [backTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
////    backTextField.frame = self.view.frame;
////    backTextField.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
////    backTextField.cell = [[WYVerticalCenterTextFieldCell alloc] init];
//
//
//    NSTextField *_textField = [NSTextField labelWithString:@"12:34567890"];
//    [self.view addSubview:_textField];
////    _textField.stringValue = @"1234567890";
//    _textField.font = [font fontOfSize:500 name:@"DigitalDismay"];
//    _textField.backgroundColor = NSColor.clearColor;
//    _textField.textColor = NSColor.blueColor;
//    _textField.alignment = NSTextAlignmentCenter;
//    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(backTextField);
//    }];
}


- (void)viewDidAppear {
    [super viewDidAppear];

    NSLog(@"viewDidAppear");
}

- (void)viewDidDisappear {
    [super viewDidDisappear];

    NSLog(@"viewDidDisappear");
}

- (NSTextField *)getWeek {
    CGFloat height = [[NSScreen mainScreen] visibleFrame].size.height / 2;
    if ([[NSScreen mainScreen] visibleFrame].size.width < [[NSScreen mainScreen] visibleFrame].size.height) {
        height = [[NSScreen mainScreen] visibleFrame].size.width /3.5;
    }
    NSTextField *textField = [NSTextField labelWithString:@""];
    textField.font = [[Font shareInstance] fontOfSize:height / 6 name:@"DS-Digital"];
    textField.backgroundColor = NSColor.clearColor;
    textField.textColor = NSColor.blueColor;
    textField.alignment = NSTextAlignmentCenter;
    return textField;
}

@end
