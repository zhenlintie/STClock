//
//  STNaviButtonItem.m
//  STClockDemo
//
//  Created by zhenlintie on 15/7/28.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "UIButton+STClock.h"

@implementation UIButton (STClock)

+ (instancetype)buttonWithBackgroundImage:(NSString *)bgImage pressedBackgroundImage:(NSString *)pressedBgImage disabledImage:(NSString *)disabledImage title:(NSString *)title image:(NSString *)image{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 61, 44)];
    [button setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:pressedBgImage] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:STRGB(242, 242, 242) forState:UIControlStateNormal];
    button.exclusiveTouch = YES;
    button.adjustsImageWhenDisabled = NO;
    button.adjustsImageWhenHighlighted = NO;
    return button;
}

+ (instancetype)blackButtonWithTitle:(NSString *)title{
    return [self buttonWithBackgroundImage:@"topbar_button_black_normal"
                    pressedBackgroundImage:@"topbar_button_black_pressed"
                             disabledImage:nil
                                     title:title
                                     image:nil];
}

+ (instancetype)redButtonWithTitle:(NSString *)title{
    return [self buttonWithBackgroundImage:@"topbar_button_red_normal"
                    pressedBackgroundImage:@"topbar_button_red_pressed"
                             disabledImage:@"topbar_button_red_disabled"
                                     title:title
                                     image:nil];
}

+ (instancetype)blueButtonWithTitle:(NSString *)title{
    return [self buttonWithBackgroundImage:@"topbar_button_blue_normal"
                    pressedBackgroundImage:@"topbar_button_blue_pressed"
                             disabledImage:nil
                                     title:title
                                     image:nil];
}

+ (instancetype)infoTypeButton{
    return [self buttonWithBackgroundImage:@"topbar_button_black_normal"
                    pressedBackgroundImage:@"topbar_button_black_pressed"
                             disabledImage:nil
                                     title:nil
                                     image:@"topbar_button_info"];
}

+ (instancetype)addTypeButton{
    return [self buttonWithBackgroundImage:@"topbar_button_black_normal"
                    pressedBackgroundImage:@"topbar_button_black_pressed"
                             disabledImage:nil
                                     title:nil
                                     image:@"topbar_button_add"];
}

@end
