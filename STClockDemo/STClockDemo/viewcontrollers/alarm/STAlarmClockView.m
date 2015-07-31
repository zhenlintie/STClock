//
//  STAlarmClockView.m
//  STClockDemo
//
//  Created by zhenlintie on 15/7/29.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STAlarmClockView.h"

@interface STAlarmClockView ()

@property (strong, nonatomic) UIImageView *leftEar;
@property (strong, nonatomic) UIImageView *rightEar;

@end

@implementation STAlarmClockView{
    CGPoint _leftEarPostion, _leftEarHidePosition;
    CGPoint _rightEarPostion, _rightEarHidePosition;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.updateHandBySecond = NO;
    }
    return self;
}

- (void)loadUI{
    [super loadUI];
    self.titleLabel.text = @"无闹钟";
    [self.titleLabel sizeToFit];
    
    self.leftEar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alarm_ear_left_i6"]];
    self.rightEar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alarm_ear_right_i6"]];
    
    [self insertSubview:self.leftEar belowSubview:self.clockPannel];
    [self insertSubview:self.rightEar belowSubview:self.clockPannel];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self updateItems];
}

- (void)loadEarPostions{
    CGFloat offset = 2;
    _leftEarPostion = CGPointMake(self.clockPannel.left+self.leftEar.width/2+offset,
                                  self.clockPannel.top+self.leftEar.height/2+offset);
    _rightEarPostion = CGPointMake(self.clockPannel.right-self.leftEar.width/2-offset,
                                   self.clockPannel.top+self.leftEar.height/2+offset);
    
    _leftEarHidePosition = CGPointMake(_leftEarPostion.x+_leftEar.width*1.5,
                                       _leftEarPostion.y+_leftEar.height*1.5);
    _rightEarHidePosition = CGPointMake(_rightEarPostion.x-_rightEar.width*1.5,
                                        _rightEarPostion.y+_rightEar.height*1.5);
}

- (void)updateItems{
    [self loadEarPostions];
    [self updateEarsPostion];
}

- (void)updateEarsPostion{
    _leftEar.center = self.onWillShow?_leftEarHidePosition:_leftEarPostion;
    _rightEar.center = self.onWillShow?_rightEarHidePosition:_rightEarPostion;
}

#pragma mark - transition

- (void)willShow{
    [super willShow];
    [self updateEarsPostion];
}

- (void)transitionToHide:(void (^)())completion{
    [self.leftEar positionTo:_leftEarHidePosition duration:0.5 timingFumction:STEaseIn completion:nil];
    [self.rightEar positionTo:_rightEarHidePosition duration:0.5 timingFumction:STEaseIn completion:nil];
    [super transitionToHide:completion];
}

- (void)transitionToShow:(void (^)())completion{
    [self.leftEar positionTo:_leftEarPostion duration:0.4 timingFumction:STEaseInOut completion:nil];
    [self.rightEar positionTo:_rightEarPostion duration:0.4 timingFumction:STEaseInOut completion:nil];
    [super transitionToShow:completion];
}


@end
