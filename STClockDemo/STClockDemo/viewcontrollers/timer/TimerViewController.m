//
//  TimerViewController.m
//  STClockDemo
//
//  Created by zhenlintie on 15/7/27.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "TimerViewController.h"
#import "STTimerClockView.h"

@interface TimerViewController ()

@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) STTimerClockView *clockView;

@end

@implementation TimerViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        self.title = @"计时器";
    }
    return self;
}

- (void)loadView{
    [super loadView];
    
    self.leftButton = [UIButton infoTypeButton];
    [self.topBar addSubview:_leftButton];
    
    self.clockView = [[STTimerClockView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:self.clockView belowSubview:self.topBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.clockView.frame = self.view.bounds;
}

#pragma mark - transition

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.clockView willShow];
}

- (void)transitionToHide:(void(^)())completion{
    [self.clockView transitionToHide:completion];
    [@[self.titleLabel, self.leftButton] alphaTo:0
                                        duration:STCLOCK_ALPHA_ANIMATION_DURATION
                                      completion:nil];
}

- (void)transitionToShow:(void(^)())completion{
    [self.clockView transitionToShow:completion];
    [@[self.titleLabel, self.leftButton] alphaTo:1
                                        duration:STCLOCK_ALPHA_ANIMATION_DURATION
                                      completion:nil];
}

#pragma mark - tabbar item

- (STTabbarButton *)tabbarButtonItem{
    STTabbarButton *item = [super tabbarButtonItem];
    item.image = [UIImage imageNamed:@"icon_timer_off"];
    item.selectedImage = [UIImage imageNamed:@"icon_timer_on"];
    return item;
}

@end
