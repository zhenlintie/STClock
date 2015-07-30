//
//  UIColor+STUtils.m
//  STUtils
//
//  Created by zhenlintie on 15/6/4.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "UIColor+STUtils.h"

#define STIMPColorF(NAME, ...) STIMPF(UIColor *,st_color, NAME, __VA_ARGS__)

STIMPColorF(RGBA, int red, int green, int blue, CGFloat alpha){
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

STIMPColorF(GrayA, int gray, CGFloat alpha){
    return st_colorRGBA(gray, gray, gray, alpha);
}

#define STSYSC(name1, name2) STIMPColorF(name1)\
{\
    return [UIColor name2];\
}
// 系统颜色
STSYSC(Black, blackColor);
STSYSC(DarkGray, darkGrayColor);
STSYSC(LightGray, lightGrayColor);
STSYSC(White, whiteColor);
STSYSC(Gray, grayColor);
STSYSC(Red, redColor);
STSYSC(Green, greenColor);
STSYSC(Blue, blueColor);
STSYSC(Cyan, cyanColor);
STSYSC(Yellow, yellowColor);
STSYSC(Magenta, magentaColor);
STSYSC(Orange, orangeColor);
STSYSC(Purple, purpleColor);
STSYSC(Brown, brownColor);
STSYSC(Clear, clearColor);
STSYSC(LightText, lightTextColor);
STSYSC(DarkText, darkTextColor);
STSYSC(GroupTableViewBackground, groupTableViewBackgroundColor);

// 常用颜色
// 浅一点的
#define STIMPColorL(name,r,g,b) STIMPF(UIColor *,st_light, name)\
{\
    return STRGB(r, g, b);\
}
STIMPColorL(Black,43,43,43);
STIMPColorL(Blue,80,101,161);
STIMPColorL(Brown,94, 69, 52);
STIMPColorL(Coffee,163, 134, 113);
STIMPColorL(ForestGreen,52, 95, 65);
STIMPColorL(Gray,149, 165, 166);
STIMPColorL(Green,46, 204, 113);
STIMPColorL(Lime,165, 198, 59);
STIMPColorL(Magenta,155, 89, 182);
STIMPColorL(Maroon,121, 48, 42);
STIMPColorL(Mint,26, 188, 156);
STIMPColorL(NavyBlue,52, 73, 94);
STIMPColorL(Orange,230, 126, 34);
STIMPColorL(Pink,245, 110, 166);
STIMPColorL(Plum,94, 52, 94);
STIMPColorL(PowderBlue,172, 196, 253);
STIMPColorL(Purple,116, 94, 197);
STIMPColorL(Red,231, 76, 60);
STIMPColorL(Sand,240, 222, 180);
STIMPColorL(SkyBlue,52, 152, 219);
STIMPColorL(Teal,58, 111, 129);
STIMPColorL(Watermelon,239, 113, 122);
STIMPColorL(White,236, 240, 241);
STIMPColorL(Yellow,255, 205, 2);

// 深一点的
#define STIMPColorD(name,r,g,b) STIMPF(UIColor *,st_dark, name)\
{\
return STRGB(r, g, b);\
}
STIMPColorD(Black,38, 38, 38);
STIMPColorD(Blue,57, 76, 129);
STIMPColorD(Brown,80, 59, 44);
STIMPColorD(Coffee,142, 114, 94);
STIMPColorD(ForestGreen,45, 80, 54);
STIMPColorD(Gray,127, 140, 141);
STIMPColorD(Green,39, 174, 96);
STIMPColorD(Lime,142, 176, 33);
STIMPColorD(Magenta,142, 68, 173);
STIMPColorD(Maroon,102, 38, 33);
STIMPColorD(Mint,22, 160, 133);
STIMPColorD(NavyBlue,44, 62, 80);
STIMPColorD(Orange,211, 84, 0);
STIMPColorD(Pink,219, 86, 142);
STIMPColorD(Plum,79, 43, 79);
STIMPColorD(PowderBlue,140, 166, 225);
STIMPColorD(Purple,91, 72, 162);
STIMPColorD(Red,192, 57, 43);
STIMPColorD(Sand,213, 194, 149);
STIMPColorD(SkyBlue,41, 128, 185);
STIMPColorD(Teal,53, 98, 114);
STIMPColorD(Watermelon,217, 84, 89);
STIMPColorD(White,189, 195, 199);
STIMPColorD(Yellow,255, 168, 0);

@implementation UIColor (STUtils)

@end
