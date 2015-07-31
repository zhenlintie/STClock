//
//  STTimerRulerView.m
//  STClockDemo
//
//  Created by zhenlintie on 15/7/29.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STTimerRulerView.h"
#import "UIView+STAnimation.h"

@interface STTimerRulerView ()

@property (strong, nonatomic) UIImageView *loopView;
@property (strong, nonatomic) UIImageView *rulerView;
@property (strong, nonatomic) UIImageView *topShadowView;
@property (strong, nonatomic) UIView *rulerContentView;

@property (strong, nonatomic) NSArray *loopImages;

@property (strong, nonatomic) UIPanGestureRecognizer *pan;

@end

@implementation STTimerRulerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        NSMutableArray *images = [NSMutableArray array];
        for (int i = 1; i <= 30; i++){
            [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loop_%04d",i]]];
        }
        NSArray *temp = [NSArray arrayWithArray:images];
        for (NSInteger i = temp.count-1; i >= 0; i--){
            [images addObject:temp[i]];
        }
        self.loopImages = images;
        [self loadUI];
    }
    return self;
}

- (void)loadUI{
    self.loopView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loop_0001"]];
    self.rulerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timer_ruler_i6"]];
    self.rulerView.userInteractionEnabled = YES;
    [self.rulerView addSubview:self.loopView];
    self.loopView.bottom = self.rulerView.height;
    
    self.topShadowView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"ruler_top_shadow"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)]];
    self.topShadowView.width = self.rulerView.width;
    self.topShadowView.top = 10;
    
    self.rulerContentView = [[UIView alloc] initWithFrame:self.rulerView.bounds];
    self.rulerContentView.top = 10;
    self.rulerContentView.clipsToBounds = YES;
    
    self.rulerView.top = -(self.rulerView.height-self.loopView.height);
    [self.rulerContentView addSubview:self.rulerView];
    
    [self addSubview:self.rulerContentView];
    [self addSubview:self.topShadowView];
    
    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned)];
    [self.rulerView addGestureRecognizer:self.pan];
}



#pragma mark - animation

- (void)animateToShow{
    _rulerView.alpha = 1;
    _topShadowView.alpha = 1;
    
    CGPoint position = CGPointMake(_rulerView.center.x, [self rulerTopWithSecond:_second]+_rulerView.height/2);
    CGPoint toPosition = CGPointMake(position.x, MIN(_rulerView.height/2,position.y+15));
    
    _rulerView.layer.position = CGPointMake(position.x, [self rulerHeight]/2-_rulerView.height);
    
    [_rulerView.layer pop_removeAllAnimations];
    [_rulerView positionTo:toPosition
                  duration:0.3
            timingFumction:STCustomEaseOut
                completion:^(BOOL finished) {
                    [_rulerView positionTo:position
                                  duration:0.2
                            timingFumction:STLinear
                                completion:nil];
                }];
}

- (void)animateToHide{
    [_rulerView.layer pop_removeAllAnimations];
    CGPoint position = _rulerView.layer.position;
    [_rulerView positionTo:CGPointMake(position.x, -_rulerView.height/2) duration:STCLOCK_ALPHA_ANIMATION_DURATION
            timingFumction:STEaseInOut
                completion:nil];
    [_topShadowView alphaTo:0 duration:STCLOCK_ALPHA_ANIMATION_DURATION
                 completion:nil];
}

- (void)resetRuler{
    _second = 0;
    [_rulerView positionTo:CGPointMake(_rulerView.center.x, _rulerView.height/2-[self rulerHeight])
                  duration:STCLOCK_ALPHA_ANIMATION_DURATION
            timingFumction:STEaseOut
                completion:^(BOOL finished) {
                    _loopView.animationImages = _loopImages;
                    _loopView.animationRepeatCount = 1;
                    _loopView.animationDuration = 0.6;
                    [_loopView startAnimating];
                }];
}

#pragma mark - ruler

- (CGFloat)rulerHeight{
    return self.rulerView.height-self.loopView.height;
}

- (CGFloat)rulerTopWithSecond:(NSInteger)second{
    return -(1-second/3600.0)*([self rulerHeight]);
}

- (CGFloat)rulerRatio{
    return 1-(0-self.rulerView.top)/([self rulerHeight]);
}

- (void)setSecond:(NSInteger)second{
    _second = second;
    self.rulerView.top = [self rulerTopWithSecond:second];
}

- (void)updateSecond{
    _second = (int)floor([self rulerRatio]*3600);
    [self.delegate slideToSecond:self.second];
}

- (void)updateMinute{
    NSInteger minute = (int)floor([self rulerRatio]*60);
    [self.delegate didBeginAtMinute:minute];
    self.rulerView.top = -(1-minute/60.0)*([self rulerHeight]);
}

#pragma mark - gesture

- (void)panned{
    switch (_pan.state) {
        case UIGestureRecognizerStateBegan:{
            break;
        }
        case UIGestureRecognizerStateChanged:{
            CGFloat offset = [_pan translationInView:self].y;
            self.rulerView.top = MAX(-[self rulerHeight], MIN(0, self.rulerView.top+offset));
            [_pan setTranslation:CGPointZero inView:self];
            
            [self updateSecond];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            [self updateMinute];
            break;
        }
        default:
            break;
    }
}

@end
