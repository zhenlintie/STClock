//
//  NSDate+STClock.h
//  STClockDemo
//
//  Created by zhenlintie on 15/7/29.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (STClock)

- (NSInteger)hour;
- (NSInteger)minute;
- (NSInteger)second;
- (NSInteger)nanoSecond;

@end
