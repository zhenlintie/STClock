//
//  STTimerRulerView.h
//  STClockDemo
//
//  Created by zhenlintie on 15/7/29.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STTimerRulerViewDelegate <NSObject>

// 最大3600
- (void)slideToSecond:(NSInteger)second;

- (void)didBeginAtMinute:(NSInteger)minute;

@end

@interface STTimerRulerView : UIView

@property (weak, nonatomic) id <STTimerRulerViewDelegate> delegate;

@property (assign, nonatomic) NSInteger second;

- (void)animateToShow;
- (void)animateToHide;

- (void)resetRuler;

@end
