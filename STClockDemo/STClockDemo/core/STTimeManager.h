//
//  STTimeManager.h
//  STClockDemo
//
//  Created by zhenlintie on 15/7/29.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol STTimeObserver;

@interface STTimeManager : NSObject

+ (NSArray *)timeObservers;
+ (void)addTimeObserver:(id<STTimeObserver>)observer;
+ (void)removeTimeObserver:(id<STTimeObserver>)observer;

+ (void)fire;

@end

@protocol STTimeObserver <NSObject>

- (void)update;

@end
