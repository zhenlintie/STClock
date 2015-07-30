//
//  ViewController.m
//  STClockDemo
//
//  Created by zhenlintie on 15/7/27.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView{
    self.view = [[UIView alloc] initWithFrame:screenBounds()];
    self.view.backgroundColor = STCLOCK_BG_COLOR;
    self.view.clipsToBounds = YES;
    
    [self loadNavigationBarAndItem];
}

- (void)loadNavigationBarAndItem{
    self.topBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    [self.topBar setBackgroundImage:[[UIImage imageNamed:@"topbar_background"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 30) resizingMode:UIImageResizingModeTile] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    self.topBar.shadowImage = [UIImage imageNamed:@"shadow_top"];
    [self.view addSubview:self.topBar];
    
    _titleLabel = [UILabel new];
    _titleLabel.attributedText = [[NSAttributedString alloc] initWithString:self.title
                                                                 attributes:@{NSForegroundColorAttributeName:STRGB(253, 253, 253),
                                                                              NSFontAttributeName:st_fontBlod(20),
                                                                              NSShadowAttributeName:[NSShadow new]}];
    [_titleLabel sizeToFit];
    self.navigationItem.titleView = _titleLabel;
    [self.topBar setItems:@[self.navigationItem]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self transitionToShow:nil];
}

- (void)transitionToHide:(void(^)())completion{
    STSafeBlock(completion);
}

- (void)transitionToShow:(void(^)())completion{
    STSafeBlock(completion);
}

#pragma mark - tabbar item

- (STTabbarButton *)tabbarButtonItem{
    STTabbarButton *item = [STTabbarButton new];
    item.title = self.title;
    item.selectedBackgroundImage = [UIImage imageNamed:@"tabbar_selected_item_bg"];
    return item;
}

@end
