//
//  STTabbar.h
//  STClockDemo
//
//  Created by zhenlintie on 15/7/28.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STTabbar;
@protocol STTabbarDelegate <NSObject>

- (void)tabbar:(STTabbar *)tabbar didSelectedIndex:(NSInteger)index;
- (BOOL)tabbar:(STTabbar *)tabbar shouldSelectedIndex:(NSInteger)index;

@end

@interface STTabbar : UIView

@property (assign, nonatomic) NSInteger selectedIndex;

@property (strong, nonatomic) NSArray *items;

@property (weak, nonatomic) id <STTabbarDelegate> delegate;

@end

@interface STTabbarButton : UIControl

@property (strong, nonatomic) UIImage *selectedBackgroundImage;

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImage *selectedImage;

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) void (^didClicked)(STTabbarButton *sender);

@end
