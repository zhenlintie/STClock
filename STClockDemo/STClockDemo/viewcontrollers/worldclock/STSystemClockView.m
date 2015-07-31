//
//  STSystemClockView.m
//  STClockDemo
//
//  Created by zhenlintie on 15/7/28.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STSystemClockView.h"
#import "NSDate+STClock.h"

typedef enum : NSUInteger {
    STAngleHour = 0,
    STAngleMinute = 1,
    STAngleSecond = 2
} STAngleIndex;

@interface STSystemClockView ()

@property (strong, nonatomic) UIImageView *hourHand;
@property (strong, nonatomic) UIImageView *hourHandShadow;
@property (strong, nonatomic) UIImageView *minuteHand;
@property (strong, nonatomic) UIImageView *minuteHandShadow;
@property (strong, nonatomic) UIImageView *secondHand;
@property (strong, nonatomic) UIImageView *secondHandShadow;
@property (strong, nonatomic) UIImageView *blackCenter;
@property (strong, nonatomic) UIImageView *number12;
@property (strong, nonatomic) UIImageView *number3;

@end

@implementation STSystemClockView{
    BOOL _canUpdateHand;
    NSArray *_anglesBeforeShow;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [STTimeManager addTimeObserver:self];
        _canUpdateHand = NO;
        _updateHandBySecond = YES;
    }
    return self;
}

- (void)loadUI{
    [super loadUI];
    self.hourHand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hour_hand_i6"]];
    self.hourHandShadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hour_hand_shadow_i6"]];
    self.minuteHand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"minute_hand_i6"]];
    self.minuteHandShadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"minute_hand_shadow_i6"]];
    self.secondHand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"second_hand_i6"]];
    self.secondHandShadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"second_hand_shadow_i6"]];
    self.blackCenter = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clock_center_i6"]];
    self.number12 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"d12"]];
    self.number3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"d3"]];
    self.titleLabel = [UILabel new];
    self.titleLabel.text = @"系统时间";
    self.titleLabel.font = st_fontBlod(20);
    self.titleLabel.textColor = STCLOCK_TEXT_COLOR;
    [self.titleLabel sizeToFit];
    
    [self addSubview:self.minuteHandShadow];
    [self addSubview:self.minuteHand];
    [self addSubview:self.hourHandShadow];
    [self addSubview:self.hourHand];
    [self addSubview:self.blackCenter];
    [self addSubview:self.secondHandShadow];
    [self addSubview:self.secondHand];
    [self addSubview:self.number3];
    [self addSubview:self.number12];
    [self addSubview:self.titleLabel];
    
    [self layoutPannelItems];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self layoutPannelItems];
}

- (void)layoutPannelItems{
    self.hourHand.center = self.clockPannel.center;
    self.hourHandShadow.center = self.clockPannel.center;
    self.minuteHand.center = self.clockPannel.center;
    self.minuteHandShadow.center = self.clockPannel.center;
    self.secondHand.center = self.clockPannel.center;
    self.secondHandShadow.center = self.clockPannel.center;
    
    POPLayerSetTranslationY(self.hourHandShadow.layer, 2);
    POPLayerSetTranslationY(self.minuteHandShadow.layer, 2);
    POPLayerSetTranslationY(self.secondHandShadow.layer, 2);
    
    self.blackCenter.center = self.clockPannel.center;
    self.number12.origin = CGPointMake(self.clockPannel.center.x-self.number12.width/2, self.clockPannel.top+40);
    self.number3.right = self.clockPannel.right-33;
    self.number3.top = self.clockPannel.center.y-self.number3.height/2;
    self.titleLabel.center = CGPointMake(self.clockPannel.center.x, self.clockPannel.bottom+20);
}

- (void)prepareToShow{
    NSArray *angles = [self handAnglesFromDate:[[NSDate date] dateByAddingTimeInterval:1]];
    
    CGFloat angleHourBeforeShow = -M_PI/3.0+[angles[STAngleHour] floatValue];
    CGFloat angleMinuteBeforeShow = -M_PI/2+[angles[STAngleMinute] floatValue];
    CGFloat angleSecondBeforeShow = -M_PI/1.5+[angles[STAngleSecond] floatValue];

    [@[self.hourHand, self.hourHandShadow] rotateFrom:angleHourBeforeShow to:angleHourBeforeShow duration:0 timingFumction:STCustomEaseOut completion:nil];
    [@[self.minuteHand, self.minuteHandShadow] rotateFrom:angleMinuteBeforeShow to:angleMinuteBeforeShow duration:0 timingFumction:STCustomEaseOut completion:nil];
    [@[self.secondHand, self.secondHandShadow] rotateFrom:angleSecondBeforeShow to:angleSecondBeforeShow duration:0 timingFumction:STCustomEaseOut completion:nil];
    
    _anglesBeforeShow = @[@(angleHourBeforeShow),@(angleMinuteBeforeShow),@(angleSecondBeforeShow)];
    
    [[self alphaItems] alphaTo:0
                      duration:0
                    completion:nil];
}

- (NSArray *)alphaItems{
    return @[self.hourHand, self.minuteHand, self.secondHand, self.hourHandShadow, self.minuteHandShadow,
             self.secondHandShadow, self.number12, self.number3, self.blackCenter, self.titleLabel];
}

- (NSArray *)handAnglesFromDate:(NSDate *)date{
    CGFloat hourAngle, minuteAngle, secondAngle;
    
    NSInteger hour = [date hour];
    NSInteger minute = [date minute];
    NSInteger second = [date second];
    NSInteger nanoSecond = [date nanoSecond];
    if (hour > 12){
        hour -= 12;
    }
    float hourRatio = hour/12.0;
    float minuteRatio = minute/60.0;
    float secondRatio = second/60.0;
    float nanoSecondRatio = nanoSecond/1000.0;
    
    hourAngle = (2*M_PI*hourRatio)+(M_PI/6.0*minuteRatio);
    minuteAngle = 2*M_PI*minuteRatio+(M_PI/30.0*secondRatio);
    secondAngle = 2*M_PI*secondRatio + (_updateHandBySecond?0:M_PI/30.0*nanoSecondRatio);
    
    return @[@(hourAngle),@(minuteAngle),@(secondAngle)];
} 

- (void)updateHandToDate:(NSDate *)date animated:(BOOL)animated completion:(void(^)(BOOL))comletion{
    NSArray *angles = [self handAnglesFromDate:date];

    [@[self.hourHand, self.hourHandShadow] rotateFrom:[_anglesBeforeShow[STAngleHour] floatValue]
                                                   to:[angles[STAngleHour] floatValue] duration:animated?0.8:0
                                       timingFumction:STEaseOut completion:nil];
    [@[self.minuteHand, self.minuteHandShadow] rotateFrom:[_anglesBeforeShow[STAngleMinute] floatValue]
                                                       to:[angles[STAngleMinute] floatValue] duration:animated?0.9:0
                                           timingFumction:STEaseOut completion:nil];
    [@[self.secondHand, self.secondHandShadow] rotateFrom:[_anglesBeforeShow[STAngleSecond] floatValue]
                                                       to:[angles[STAngleSecond] floatValue] duration:animated?1:0
                                           timingFumction:STEaseOut completion:comletion];
}

#pragma mark - transition

- (void)willShow{
    self.onWillShow = YES;
    [self prepareToShow];
}

- (void)transitionToShow:(void (^)())completion{
    _canUpdateHand = NO;
    self.onTransitionToShow = YES;
    [[self alphaItems] alphaTo:1
                      duration:STCLOCK_ALPHA_ANIMATION_DURATION
                    completion:nil];
    [self updateHandToDate:[[NSDate date] dateByAddingTimeInterval:1] animated:YES completion:^(BOOL finish) {
        self.onTransitionToShow = NO;
        if (!self.onTransitionToHide){
            _canUpdateHand = YES;
        }
        self.onWillShow = NO;
        if (finish){
            STSafeBlock(completion);
        }
    }];
}

- (void)transitionToHide:(void (^)())completion{
    _canUpdateHand = NO;
    self.onTransitionToHide = YES;
    [[self alphaItems] alphaTo:0
                      duration:STCLOCK_ALPHA_ANIMATION_DURATION
                    completion:^(BOOL finished) {
                        STSafeBlock(completion);
                    }];
    [@[self.hourHand, self.hourHandShadow] rotateFrom:POPLayerGetRotation(self.hourHand.layer) to:M_PI/3+POPLayerGetRotation(self.hourHand.layer) duration:0.35 timingFumction:STEaseIn completion:nil];
    [@[self.minuteHand, self.minuteHandShadow] rotateFrom:POPLayerGetRotation(self.minuteHand.layer) to:M_PI/2.5+POPLayerGetRotation(self.minuteHand.layer) duration:0.325 timingFumction:STEaseIn completion:nil];
    [@[self.secondHand, self.secondHandShadow] rotateFrom:POPLayerGetRotation(self.secondHand.layer) to:M_PI/2+POPLayerGetRotation(self.secondHand.layer) duration:0.3 timingFumction:STEaseIn completion:^(BOOL finished) {
        self.onTransitionToHide = NO;
    }];
}

#pragma mark - time observer

- (void)update{
    if (_canUpdateHand){
        [self updateHandToDate:[NSDate date] animated:NO completion:nil];
    }
}

@end
