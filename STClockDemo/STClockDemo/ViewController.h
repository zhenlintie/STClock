//
//  ViewController.h
//  STClockDemo
//
//  Created by zhenlintie on 15/7/27.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STTabbar.h"
#import "STClockView.h"
#import "UIButton+STClock.h"
#import "UIView+STAnimation.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) UINavigationBar *topBar;

@property (strong, nonatomic) UILabel *titleLabel;

- (STTabbarButton *)tabbarButtonItem;

- (void)transitionToHide:(void(^)())completion;

@end

