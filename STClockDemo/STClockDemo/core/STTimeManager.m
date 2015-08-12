//
//  STTimeManager.m
//  STClockDemo
//
//  Created by zhenlintie on 15/7/29.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STTimeManager.h"
#import "NSDate+STClock.h"

@interface STTimeManager ()

@property (strong, nonatomic) NSMutableSet *timeObserverContainer;

@property (strong, nonatomic) CADisplayLink *timer;

@end

@implementation STTimeManager{
    BOOL _onFire;
}

- (instancetype)init{
    return nil;
}

- (instancetype)_init{
    if (self = [super init]){
        _onFire = NO;
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
    if (!_onFire){
        _onFire = YES;
        self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)update{
    [_timeObserverContainer enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        [obj performSelector:@selector(update) withObject:nil];
    }];
}

@end











