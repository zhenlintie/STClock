//
//  STTimeManager.m
//  STClockDemo
//
//  Created by zhenlintie on 15/7/29.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STTimeManager.h"

@interface STTimeManager ()

@property (strong, nonatomic) NSMutableSet *timeObserverContainer;

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation STTimeManager

- (instancetype)init{
    return nil;
}

- (instancetype)_init{
    if (self = [super init]){
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(update) userInfo:nil repeats:YES];
        _timeObserverContainer = [NSMutableSet set];
    }
    return self;
}

+ (instancetype)shared{
    static STTimeManager *_shared_mgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared_mgr = [[STTimeManager alloc] _init];
    });
    return _shared_mgr;
}

+ (void)fire{
    [[self shared] fire];
}

+ (void)addTimeObserver:(id)observer{
    [[[self shared] timeObserverContainer] addObject:observer];
}

+ (void)removeTimeObserver:(id)observer{
    [[[self shared] timeObserverContainer] removeObject:observer];
}

+ (NSArray *)timeObservers{
    return [NSArray arrayWithArray:[[[self shared] timeObserverContainer] allObjects]];
}

- (void)fire{
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)update{
    [_timeObserverContainer enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        [obj performSelector:@selector(update) withObject:nil];
    }];
}


@end











