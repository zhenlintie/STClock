//
//  STClockView.h
//  STClockDemo
//
//  Created by zhenlintie on 15/7/28.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+STAnimation.h"

@interface STClockView : UIView

- (void)loadUI;
- (CGFloat)angleOfView:(UIView *)view;

@property (strong, nonatomic) UIImageView *clockPannel;

//@property (assign, nonatomic) BOOL isNight; // 是否是夜晚

@property (assign, nonatomic) BOOL onTransitionToHide;
@property (assign, nonatomic) BOOL onTransitionToShow;
@property (assign, nonatomic) BOOL onWillShow;
- (void)willShow;
- (void)transitionToHide:(void(^)())completion;
- (void)transitionToShow:(void(^)())completion;

@end
