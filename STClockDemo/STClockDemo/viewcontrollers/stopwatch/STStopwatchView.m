//
//  STStopwatchView.m
//  STClockDemo
//
//  Created by zhenlintie on 15/7/28.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STStopwatchView.h"
#import "STToast.h"

@interface STStopwatchView (){
    BOOL _screenlighted;
    STToast *_toast;
}

@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UIButton *middleButton;
@property (strong, nonatomic) UIButton *rightButton;

@property (strong, nonatomic) UIImageView *blackCenter;
@property (strong, nonatomic) UIImageView *secondHand;
@property (strong, nonatomic) UIImageView *secondHandShadow;
@property (strong, nonatomic) UIImageView *degreeBg;
@property (strong, nonatomic) UIImageView *number60;
@property (strong, nonatomic) UIImageView *number15;

@property (strong, nonatomic) UIButton *screenlightButton;

@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *timePointLabel;

@end

@implementation STStopwatchView{
    CGFloat _handAngleBeforeShow;
    
    CGPoint _leftButtonOnPosition;
    CGPoint _leftButtonOffPosition;
    CGPoint _leftButtonHidePosition;
    
    CGPoint _rightButtonOnPosition;
    CGPoint _rightButtonOffPosition;
    CGPoint _rightButtonHidePosition;
    
    CGPoint _middleButtonPosition;
    CGPoint _middleButtonHidePosition;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        _screenlighted = NO;
    }
    return self;
}

- (void)loadUI{
    [super loadUI];
    
    self.leftButton = [self controlButtonWithImage:[UIImage imageNamed:@"stopwatch_left"] highlightedImage:[UIImage imageNamed:@"stopwatch_left_highlight"]];
    self.middleButton = [self controlButtonWithImage:[UIImage imageNamed:@"stopwatch_middle"] highlightedImage:[UIImage imageNamed:@"stopwatch_middle_hover"]];
    self.rightButton = [self controlButtonWithImage:[UIImage imageNamed:@"stopwatch_right"] highlightedImage:[UIImage imageNamed:@"stopwatch_right_highlight"]];
    [self insertSubview:self.leftButton belowSubview:self.clockPannel];
    [self insertSubview:self.middleButton belowSubview:self.clockPannel];
    [self insertSubview:self.rightButton belowSubview:self.clockPannel];
    [self hideControlButtons];
    
    self.degreeBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"degree_i6"]];
    self.blackCenter = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clock_center_i6"]];
    self.secondHand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"second_hand_i6"]];
    self.secondHandShadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"second_hand_shadow_i6"]];
    self.number60 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"d60"]];
    self.number15 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"d15"]];
    
    [self addSubview:self.degreeBg];
    [self addSubview:self.blackCenter];
    [self addSubview:self.secondHandShadow];
    [self addSubview:self.secondHand];
    [self addSubview:self.number15];
    [self addSubview:self.number60];
    
    self.screenlightButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 44+5, 44, 44)];
    [self.screenlightButton addTarget:self action:@selector(screenlightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self updateScreenlightButton];
    [self addSubview:self.screenlightButton];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    self.timeLabel.textColor = STRGB(172, 89, 89);
    self.timeLabel.font = st_font(23);
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.text = @"00:00.00";
    [self addSubview:self.timeLabel];
}

- (UIButton *)controlButtonWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage{
    UIButton *bu = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [bu setImage:image forState:UIControlStateNormal];
    [bu setImage:highlightedImage forState:UIControlStateHighlighted];
    return bu;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self updateItems];
}

- (void)loadPositions{
    CGFloat sideOnOffset = 13;
    CGFloat sideOffOffset = 15;
    CGFloat middeOffset = 10;
    
    _leftButtonOnPosition = CGPointMake(self.leftButton.width/2+self.clockPannel.left+sideOnOffset,
                                        self.leftButton.height/2+self.clockPannel.top+sideOnOffset);
    _rightButtonOnPosition = CGPointMake(-self.rightButton.width/2+self.clockPannel.right-sideOnOffset,
                                        self.rightButton.height/2+self.clockPannel.top+sideOnOffset);
    
    _leftButtonOffPosition = CGPointMake(self.leftButton.width/2+self.clockPannel.left+sideOffOffset,
                                        self.leftButton.height/2+self.clockPannel.top+sideOffOffset);
    _rightButtonOffPosition = CGPointMake(-self.rightButton.width/2+self.clockPannel.right-sideOffOffset,
                                         self.rightButton.height/2+self.clockPannel.top+sideOffOffset);
    
    _middleButtonPosition = CGPointMake(self.clockPannel.center.x,
                                        self.clockPannel.top+middeOffset);
    
    _leftButtonHidePosition = CGPointMake(_leftButtonOnPosition.x+_leftButton.width,
                                          _leftButtonOnPosition.y+_leftButton.height);
    _rightButtonHidePosition = CGPointMake(_rightButtonOnPosition.x-_rightButton.width,
                                           _rightButtonOnPosition.y+_rightButton.height);
    _middleButtonHidePosition = CGPointMake(_middleButtonPosition.x,
                                            _middleButtonPosition.y+_middleButton.height*2);
}

- (void)updateItems{
    [self loadPositions];
    _leftButton.center = _leftButtonOnPosition;
    _middleButton.center = _middleButtonPosition;
    _rightButton.center = _rightButtonOffPosition;
    
    self.degreeBg.center = self.clockPannel.center;
    self.blackCenter.center = self.clockPannel.center;
    self.secondHand.center = self.clockPannel.center;
    self.secondHandShadow.center = self.clockPannel.center;
    self.number60.origin = CGPointMake(self.clockPannel.center.x-self.number60.width/2, self.clockPannel.top+45);
    self.number15.right = self.clockPannel.right-38;
    self.number15.top = self.clockPannel.center.y-self.number15.height/2;
    
    self.timeLabel.center = CGPointMake(self.clockPannel.center.x, self.clockPannel.bottom+45);
    
    POPLayerSetTranslationY(self.secondHandShadow.layer, 2);
    
    if (self.onWillShow){
        [self prepareToShow];
    }else{
        [_leftButton positionTo:_leftButtonOnPosition duration:0 timingFumction:0 completion:nil];
        [_rightButton positionTo:_rightButtonOffPosition duration:0 timingFumction:0 completion:nil];
        [_middleButton positionTo:_middleButtonPosition duration:0 timingFumction:0 completion:nil];
    }
}

- (void)prepareToShow{
    [self hideControlButtons];
    [[self alphaAnimateItems] alphaTo:0 duration:STCLOCK_ALPHA_ANIMATION_DURATION completion:nil];
    _handAngleBeforeShow = -M_PI_2;
    [@[self.secondHand, self.secondHandShadow] rotateFrom:_handAngleBeforeShow to:_handAngleBeforeShow duration:0 timingFumction:STLinear completion:nil];
}

- (void)hideControlButtons{
    _leftButton.layer.position = _leftButtonHidePosition;
    _middleButton.layer.position = _middleButtonHidePosition;
    _rightButton.layer.position = _rightButtonHidePosition;
}

- (NSArray *)alphaAnimateItems{
    return @[self.screenlightButton, self.blackCenter, self.secondHandShadow,
             self.secondHand, self.degreeBg, self.timeLabel, self.number15, self.number60];
}

- (void)updateScreenlightButton{
    [self.screenlightButton setImage:[UIImage imageNamed:_screenlighted?@"btn_screenhighlight_n":@"btn_screenlight_n"] forState:UIControlStateNormal];
    [self.screenlightButton setImage:[UIImage imageNamed:_screenlighted?@"btn_screenhighlight_p":@"btn_screenlight_p"] forState:UIControlStateHighlighted];
}

#pragma mark - action

- (void)screenlightButtonClicked{
    _screenlighted = !_screenlighted;
    [[UIApplication sharedApplication] setIdleTimerDisabled:_screenlighted];
    
    [self updateScreenlightButton];
    
    if (_toast){
        [_toast removeFromSuperview];
    }
    _toast = [STToast toastWithMessage:_screenlighted?@"您已经开启了屏幕常亮":@"您已经关闭了屏幕常亮"];
    _toast.center = CGPointMake(self.clockPannel.center.x, self.clockPannel.bottom+90);
    [self addSubview:_toast];
    
    STToast *temp = _toast;
    [UIView animateWithDuration:0.7
                          delay:1
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         temp.alpha = 0;
                     } completion:^(BOOL finished) {
                         if (temp.superview){
                             [temp removeFromSuperview];
                         }
                     }];
}

#pragma mark - transition

- (void)willShow{
    self.onWillShow = YES;
    [self prepareToShow];
}

- (void)transitionToHide:(void(^)())completion{
    [[self alphaAnimateItems] alphaTo:0 duration:STCLOCK_ALPHA_ANIMATION_DURATION completion:^(BOOL finished) {
        STSafeBlock(completion)
    }];
    
    [_leftButton positionTo:_leftButtonHidePosition duration:0.5 timingFumction:STEaseIn completion:nil];
    [_rightButton positionTo:_rightButtonHidePosition duration:0.5 timingFumction:STEaseIn completion:nil];
    [_middleButton positionTo:_middleButtonHidePosition duration:0.5 timingFumction:STEaseIn completion:nil];
    
    [@[self.secondHand, self.secondHandShadow] rotateFrom:POPLayerGetRotation(self.secondHand.layer) to:POPLayerGetRotation(self.secondHand.layer)+M_PI_2 duration:0.4 timingFumction:STEaseIn completion:nil];
    
}
- (void)transitionToShow:(void(^)())completion{

    [[self alphaAnimateItems] alphaTo:1 duration:STCLOCK_ALPHA_ANIMATION_DURATION completion:nil];
    
    [_leftButton positionTo:_leftButtonOnPosition duration:0.45 timingFumction:STCustomEaseOut completion:nil];
    [_rightButton positionTo:_rightButtonOffPosition duration:0.4 timingFumction:STCustomEaseOut completion:nil];
    [_middleButton positionTo:_middleButtonPosition duration:0.45 timingFumction:STCustomEaseOut completion:nil];
    
    [@[self.secondHand, self.secondHandShadow] rotateFrom:_handAngleBeforeShow to:0 duration:0.5 timingFumction:STEaseOut completion:^(BOOL finished) {
        self.onWillShow = NO;
        STSafeBlock(completion)
    }];

}

@end
