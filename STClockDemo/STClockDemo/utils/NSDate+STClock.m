//
//  NSDate+STClock.m
//  STClockDemo
//
//  Created by zhenlintie on 15/7/29.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "NSDate+STClock.h"

@implementation NSDate (STClock)

- (NSDateFormatter *)sharedFormatter{
    static NSDateFormatter *_sharedF = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedF = [NSDateFormatter new];
        _sharedF.dateFormat = @"HH:mm:ss:SSS";
    });
    return _sharedF;
}

- (NSArray *)timeArray{
    return [[[self sharedFormatter] stringFromDate:self] componentsSeparatedByString:@":"];
}

- (NSInteger)hour{
    return [[self timeArray][0] integerValue];
}

- (NSInteger)minute{
    return [[self timeArray][1] integerValue];
}

- (NSInteger)second{
    return [[self timeArray][2] integerValue];
}

- (NSInteger)nanoSecond{
    return [[self timeArray][3] integerValue];
}

@end
