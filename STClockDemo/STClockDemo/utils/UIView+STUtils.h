//
//  UIView+STUtils.h
//  STUtils
//
//  Created by zhenlintie on 15/6/3.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import <UIKit/UIKit.h>

// 获取屏幕尺寸
extern CGRect  screenBounds();
extern CGSize  screenSize();
extern CGFloat screenWidth();
extern CGFloat screenHeight();

// 判断设备高度
#define STScreenHeight  st_screenHeight()
#define STIPhone4       (STScreenHeight==480)
#define STIPhone5       (STScreenHeight==568)
#define STIPhone6       (STScreenHeight==667)
#define STIPhone6Plus   (STScreenHeight==736)
#define STLargeIPhone   STIPhone6||STIPhone6Plus


@interface UIView (STUtils)

@property (nonatomic) CGFloat left;// x
@property (nonatomic) CGFloat top;// y
@property (nonatomic) CGFloat right;// x+width
@property (nonatomic) CGFloat bottom;// y+height
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic, readonly) CGFloat inScreenViewX;
@property (nonatomic, readonly) CGFloat inScreenViewY;
@property (nonatomic, readonly) CGRect inScreenFrame;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

@end



