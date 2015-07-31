//
//  UIView+STAnimation.m
//  STClockDemo
//
//  Created by zhenlintie on 15/7/30.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "UIView+STAnimation.h"

CAMediaTimingFunction *animateTimingFunction(STTimingFunctionType type){
    CAMediaTimingFunction *f;
    switch (type) {
        case STLinear:{
            f = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            break;
        }
        case STEaseIn:{
            f = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            break;
        }
        case STEaseOut:{
            f = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            break;
        }
        case STEaseInOut:{
            f = [CAMediaTimingFunction functionWithControlPoints:0.55 :0.19 :0.06 :0.92];
//            f = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            break;
        }
        case STCustomEaseOut:{
            f = [CAMediaTimingFunction functionWithControlPoints:0.60 :0.99 :0.86 :0.94];
            break;
        }
        default:
            f = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
            break;
    }
    return f;
}

@implementation UIView (STAnimation)

- (void)animatePropertyName:(NSString *)propName
                  fromValue:(id)fromValue
                    toValue:(id)toValue
                   duration:(CGFloat)duration
             timingFumction:(STTimingFunctionType)functionType
                 completion:(void(^)(BOOL finished))completion{
    POPBasicAnimation *a = [POPBasicAnimation animationWithPropertyNamed:propName];
    a.fromValue = fromValue;
    a.toValue = toValue;
    a.duration = duration;
    a.timingFunction = animateTimingFunction(functionType);
    [a setCompletionBlock:^(POPAnimation *a, BOOL f) {
        STSafeBlock(completion, f);
    }];
    a.removedOnCompletion = YES;
    [self.layer pop_addAnimation:a forKey:nil];
}

- (void)alphaTo:(CGFloat)alpha duration:(CGFloat)duration completion:(void (^)(BOOL))completion{
    [self animatePropertyName:kPOPLayerOpacity
                    fromValue:nil
                      toValue:@(alpha)
                     duration:duration
               timingFumction:STEaseInOut
                   completion:completion];
}

- (void)positionTo:(CGPoint)position duration:(CGFloat)duration timingFumction:(STTimingFunctionType)functionType completion:(void(^)(BOOL finished))completion{
    [self animatePropertyName:kPOPLayerPosition
                    fromValue:nil
                      toValue:[NSValue valueWithCGPoint:position]
                     duration:duration
               timingFumction:functionType
                   completion:completion];
}

- (void)rotateFrom:(CGFloat)fromAngle to:(CGFloat)toAngle duration:(CGFloat)duration timingFumction:(STTimingFunctionType)functionType completion:(void(^)(BOOL finished))completion{
    [self animatePropertyName:kPOPLayerRotation
                    fromValue:@(fromAngle)
                      toValue:@(toAngle)
                     duration:duration
               timingFumction:functionType
                   completion:completion];
}

@end

@implementation NSArray (STAnimation)

- (void)animatePropertyName:(NSString *)propName
                  fromValue:(id)fromValue
                    toValue:(id)toValue
                   duration:(CGFloat)duration
             timingFumction:(STTimingFunctionType)functionType
                 completion:(void(^)(BOOL finished))completion{
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(UIView *)obj animatePropertyName:propName
                                 fromValue:fromValue
                                   toValue:toValue
                                  duration:duration
                            timingFumction:functionType
                                completion:(idx==self.count-1)?completion:nil];
    }];
}

- (void)alphaTo:(CGFloat)alpha duration:(CGFloat)duration completion:(void (^)(BOOL))completion{
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(UIView *)obj alphaTo:alpha duration:duration completion:(idx==self.count-1)?completion:nil];
    }];
}

- (void)positionTo:(CGPoint)position duration:(CGFloat)duration timingFumction:(STTimingFunctionType)functionType completion:(void(^)(BOOL finished))completion{
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(UIView *)obj positionTo:position duration:duration timingFumction:functionType completion:(idx==self.count-1)?completion:nil];
    }];
}

- (void)rotateFrom:(CGFloat)fromAngle to:(CGFloat)toAngle duration:(CGFloat)duration timingFumction:(STTimingFunctionType)functionType completion:(void(^)(BOOL finished))completion{
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(UIView *)obj rotateFrom:fromAngle to:toAngle  duration:duration timingFumction:functionType completion:(idx==self.count-1)?completion:nil];
    }];
}

@end
