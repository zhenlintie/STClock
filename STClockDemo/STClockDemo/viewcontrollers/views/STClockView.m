//
//  STClockView.m
//  STClockDemo
//
//  Created by zhenlintie on 15/7/28.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STClockView.h"

@implementation STClockView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];
        _onWillShow = NO;
        [self loadUI];
    }
    return self;
}

- (void)loadUI{
    self.clockPannel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clock_panel_white_i6"]];
    [self addSubview:self.clockPannel];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.clockPannel.center = CGPointMake(screenWidth()/2, self.height/2);
}

- (CGFloat)angleOfView:(UIView *)view{
    return [(NSNumber *)[view valueForKeyPath:@"layer.transform.rotation.z"] floatValue];
}

- (void)willShow{}
- (void)transitionToHide:(void(^)())completion{STSafeBlock(completion)}
- (void)transitionToShow:(void(^)())completion{STSafeBlock(completion)}

@end
