//
//  CustomTabController.m
//  STClockDemo
//
//  Created by zhenlintie on 15/7/28.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "CustomTabController.h"
#import "STTabbar.h"
#import "ViewController.h"

@interface CustomTabController () <STTabbarDelegate>

@property (strong, nonatomic) UIView *containerView;

@property (strong, nonatomic) STTabbar *tabbar;

@property (strong, nonatomic) NSArray *viewControllers;

@end

@implementation CustomTabController{
    NSInteger _index;
    BOOL _isTransioning;
}

- (void)loadView{
    self.view = [[UIView alloc] initWithFrame:screenBounds()];
    self.view.backgroundColor = st_colorBlack();
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, screenWidth(), screenHeight()-49-20)];
    self.containerView.backgroundColor = st_colorBlack();
    [self.view addSubview:self.containerView];
    
    [self loadTabbar];
}


- (void)loadTabbar{
    self.tabbar = [STTabbar new];
    self.tabbar.bottom = self.view.height;
    self.tabbar.delegate = self;
    [self.view addSubview:self.tabbar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadViewControllers:(NSArray *)viewControllers{
    [self reset];
    _viewControllers = viewControllers;
    [self reloadData];
}

- (void)reset{
    if (_viewControllers.count > 0){
        [_viewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
        _viewControllers = nil;
    }
}

- (void)reloadData{
    self.view.frame = screenBounds();
    NSMutableArray *tempItems = [NSMutableArray array];
    [_viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ViewController *vc = (ViewController *)obj;
        vc.view.frame = _containerView.bounds;
        [self addChildViewController:vc];
        [tempItems addObject:[vc tabbarButtonItem]];
    }];
    _tabbar.items = tempItems;
    _index = _tabbar.selectedIndex;
    [self.containerView addSubview:[_viewControllers[_index] view]];
}

- (void)transitionFromVC:(ViewController *)fromVC toVC:(ViewController *)toVC{
    _isTransioning = YES;
    [fromVC transitionToHide:^{
        [self transitionFromViewController:fromVC toViewController:toVC duration:0 options:0 animations:nil completion:^(BOOL finished) {
            _index = [_viewControllers indexOfObject:toVC];
            _isTransioning = NO;
        }];
    }];
    
}

#pragma mark - tabbar delegate

- (void)tabbar:(STTabbar *)tabbar didSelectedIndex:(NSInteger)index{
    [self transitionFromVC:_viewControllers[_index] toVC:_viewControllers[index]];
}

- (BOOL)tabbar:(STTabbar *)tabbar shouldSelectedIndex:(NSInteger)index{
    return (_index!=index)&&!_isTransioning;
}

@end
