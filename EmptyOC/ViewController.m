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
#import "SettingWindow.h"

@implementation ViewController {
    NSTextField *_backDateTextField;
    NSTextField *_dateTextField;
    NSTextField *_backTimeTextField;
    NSTextField *_timeTextField;
    NSTextField *_amPmTextField;
    NSMutableArray<NSTextField *> *_weekTextFields;

    CGFloat _height;
    NSColor *_backFontColor;
    NSColor *_fontColor;
    BOOL _isSupport24h;
    SettingWindow *_settingWindow;
}

- (void)loadView {
    self.view = [[NSView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = NSColor.blackColor.CGColor;
    self.view.autoresizingMask = NSViewHeightSizable | NSViewWidthSizable;

//    CGRect frame = [[NSScreen mainScreen] visibleFrame];
    CGRect frame = CGRectMake(0, 0, 296, 184);
    _height = frame.size.height / 2;
    if (frame.size.width < frame.size.height) {
        _height = frame.size.width / 3.5;
    }
    self.view.frame = frame;
    _fontColor = NSColor.greenColor;
    _backFontColor = [_fontColor colorWithAlphaComponent:0.2];

    _isSupport24h = YES;

    NSButton *button = [NSButton buttonWithTitle:@"click" target:self action:@selector(buttonClicked:)];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.bottom.equalTo(self.view).offset(0 - 20);
    }];

    [self initTimeTextField];
    [self initDateTextFiel];
    [self initAmPmTextField];
    [self initWeekTextFields];
    [self setColor];
    [self setDate:[[NSDate alloc] init]];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (void)viewDidAppear {
    [super viewDidAppear];

//    [self buttonClicked:nil];
}

#pragma mark -
- (void)setColor {
    _backTimeTextField.textColor = _backFontColor;
    _backDateTextField.textColor = _backFontColor;

    _timeTextField.textColor = _fontColor;
    _dateTextField.textColor = _fontColor;

    _amPmTextField.textColor = _backFontColor;
}

- (void)setDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy  MM  dd";
    _dateTextField.stringValue = [dateFormatter stringFromDate:date];

    _timeTextField.attributedStringValue = ({
        dateFormatter.dateFormat = _isSupport24h ? @"HH:mm ss" : @"hh:mm ss";
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
//        dateFormatter.locale = _isSupport24h ? [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"] : [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];

                NSLog(@"%@ %@", dateFormatter.dateFormat, [dateFormatter stringFromDate:date]);
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[dateFormatter stringFromDate:date]];
        [attributedString addAttribute:NSFontAttributeName value:[[Font shareInstance] fontOfSize:_height name:@"DigitalDismay"] range:NSMakeRange(0, 5)];
        [attributedString addAttribute:NSFontAttributeName value:[[Font shareInstance] fontOfSize:_height / 2 name:@"DigitalDismay"] range:NSMakeRange(5, 3)];
        attributedString;
    });

    dateFormatter.dateFormat = @"e";
    int week = [dateFormatter stringFromDate:date].intValue;
    [_weekTextFields enumerateObjectsUsingBlock:^(NSTextField * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == week - 1) {
            obj.textColor = _fontColor;
        } else {
            obj.textColor = _backFontColor;
        }
    }];

    if (_isSupport24h) { // 清除
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_amPmTextField.attributedStringValue.string];
        _amPmTextField.attributedStringValue = attributedString;
    } else {
        dateFormatter.dateFormat = @"H";
        BOOL isAm = ([dateFormatter stringFromDate:date].intValue < 12);
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_amPmTextField.attributedStringValue.string];
        [attributedString addAttribute:NSForegroundColorAttributeName value:_fontColor range:NSMakeRange(isAm ? 0 : 3, 2)];
        _amPmTextField.attributedStringValue = attributedString;
    }
}

- (void)initTimeTextField {
    _backTimeTextField = ({
        NSTextField *textField = [NSTextField labelWithString:@""];
        textField.alignment = NSTextAlignmentCenter;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"88:88 88"];
        [attributedString addAttribute:NSFontAttributeName value:[[Font shareInstance] fontOfSize:_height name:@"DigitalDismay"] range:NSMakeRange(0, 5)];
        [attributedString addAttribute:NSFontAttributeName value:[[Font shareInstance] fontOfSize:_height / 2 name:@"DigitalDismay"] range:NSMakeRange(5, 3)];
        textField.attributedStringValue = attributedString;
        textField;
    });
    [self.view addSubview:_backTimeTextField];
    [_backTimeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];

    _timeTextField = [NSTextField labelWithString:@""];
    _timeTextField.alignment = NSTextAlignmentCenter;
    [self.view addSubview:_timeTextField];
    [_timeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

- (void)initDateTextFiel {
    _backDateTextField = ({
        NSTextField *textField = [NSTextField labelWithString:@"8888  88  88"];
        textField.font = [[Font shareInstance] fontOfSize:_height / 3 name:@"DigitalDismay"];
        textField.alignment = NSTextAlignmentCenter;
        textField;
    });
    [self.view addSubview:_backDateTextField];
    [_backDateTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_backTimeTextField.mas_top);
        make.left.equalTo(_backTimeTextField);
    }];

    _dateTextField = ({
        NSTextField *textField = [NSTextField labelWithString:@""];
        textField.font = [[Font shareInstance] fontOfSize:_height / 3 name:@"DigitalDismay"];
        textField.alignment = NSTextAlignmentCenter;
        textField;
    });
    [self.view addSubview:_dateTextField];
    [_dateTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_backDateTextField);
    }];
}

- (void)initAmPmTextField {
    _amPmTextField = ({
        NSTextField *textField = [NSTextField labelWithString:@""];
        textField.font = [[Font shareInstance] fontOfSize:_height / 6 name:@"DS-Digital"];
        textField.alignment = NSTextAlignmentCenter;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"AM PM"];
        textField.attributedStringValue = attributedString;
        textField;
    });
    [self.view addSubview:_amPmTextField];
    [_amPmTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backTimeTextField);
        make.baseline.equalTo(_backDateTextField);
    }];
}

- (void)initWeekTextFields {
    NSView *weekView = [[NSView alloc] init];
    [self.view addSubview:weekView];
    [weekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backTimeTextField);
        make.right.equalTo(_backTimeTextField);
        make.top.equalTo(_backTimeTextField.mas_bottom);
    }];

    NSArray<NSString *> *array = @[@"SUN", @"MON", @"TUE", @"WED", @"THU", @"FRI", @"SAT"];
    _weekTextFields = [[NSMutableArray alloc] init];
    [array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_weekTextFields addObject:({
            NSTextField *textField = [NSTextField labelWithString:obj];
            textField.font = [[Font shareInstance] fontOfSize:_height / 6 name:@"DS-Digital"];
            textField.backgroundColor = NSColor.clearColor;
            textField.textColor = NSColor.blueColor;
            textField.alignment = NSTextAlignmentCenter;
            [weekView addSubview:textField];
            textField;
        })];
    }];
    [_weekTextFields mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weekView);
    }];
    [_weekTextFields mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [weekView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(_weekTextFields[0]);
    }];
}

- (void)buttonClicked:(id)sender {
    if (!_settingWindow) {
        _settingWindow = [[SettingWindow alloc] init];
        _settingWindow.parentController = self;
    }

    [[NSApp mainWindow] beginSheet:_settingWindow completionHandler:^(NSModalResponse returnCode) {
    }];
}

- (void)endSheetClicked:(id)sender {
    [[NSApplication sharedApplication] endSheet:_settingWindow];
}
@end
