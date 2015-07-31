//
//  STSystemClockView.h
//  STClockDemo
//
//  Created by zhenlintie on 15/7/28.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STClockView.h"

@interface STSystemClockView : STClockView <STTimeObserver>

@property (assign, nonatomic) BOOL updateHandBySecond;

@property (strong, nonatomic) UILabel *titleLabel;

@end
