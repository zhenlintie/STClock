//
//  UIColor+STUtils.h
//  STUtils
//
//  Created by zhenlintie on 15/6/4.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCommonUtils.h"

#define STDColor(name,...) STDF(UIColor *,st_color,name,__VA_ARGS__)
#define STRGB(r,g,b) st_colorRGBA(r,g,b,1)

STDColor(RGBA, int red, int green, int blue, CGFloat alpha);
STDColor(GrayA, int gray, CGFloat alpha);

// 系统颜色
STDColor(Black);
STDColor(DarkGray);
STDColor(LightGray);
STDColor(White);
STDColor(Gray);
STDColor(Red);
STDColor(Green);
STDColor(Blue);
STDColor(Cyan);
STDColor(Yellow);
STDColor(Magenta);
STDColor(Orange);
STDColor(Purple);
STDColor(Brown);
STDColor(Clear);
STDColor(LightText);
STDColor(DarkText);
STDColor(GroupTableViewBackground);

//
// 常用颜色
// 浅一些的
#define STDColorL(name,...) STDF(UIColor *,st_light,name,__VA_ARGS__)
STDColorL(Black);
STDColorL(Blue);
STDColorL(Brown);
STDColorL(Coffee);
STDColorL(ForestGreen);
STDColorL(Gray);
STDColorL(Green);
STDColorL(Lime);
STDColorL(Magenta);
STDColorL(Maroon);
STDColorL(Mint);
STDColorL(NavyBlue);
STDColorL(Orange);
STDColorL(Pink);
STDColorL(Plum);
STDColorL(PowderBlue);
STDColorL(Purple);
STDColorL(Red);
STDColorL(Sand);
STDColorL(SkyBlue);
STDColorL(Teal);
STDColorL(Watermelon);
STDColorL(White);
STDColorL(Yellow);
//深一些的
#define STDColorD(name,...) STDF(UIColor *,st_dark,name,__VA_ARGS__)
STDColorD(Black);
STDColorD(Blue);
STDColorD(Brown);
STDColorD(Coffee);
STDColorD(ForestGreen);
STDColorD(Gray);
STDColorD(Green);
STDColorD(Lime);
STDColorD(Magenta);
STDColorD(Maroon);
STDColorD(Mint);
STDColorD(NavyBlue);
STDColorD(Orange);
STDColorD(Pink);
STDColorD(Plum);
STDColorD(PowderBlue);
STDColorD(Purple);
STDColorD(Red);
STDColorD(Sand);
STDColorD(SkyBlue);
STDColorD(Teal);
STDColorD(Watermelon);
STDColorD(White);
STDColorD(Yellow);


@interface UIColor (STUtils)

@end


