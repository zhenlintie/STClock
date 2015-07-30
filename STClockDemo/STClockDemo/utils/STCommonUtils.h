//
//  STCommonUtils.h
//  STUtils
//
//  Created by zhenlintie on 15/6/4.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#ifndef STUtils_STCommonUtils_h
#define STUtils_STCommonUtils_h

// C函数声明
#define STDF(TYPE, PRE, NAME, ...) extern TYPE PRE##NAME(__VA_ARGS__);
// C函数实现
#define STIMPF(TYPE, PRE, NAME, ...) TYPE PRE##NAME(__VA_ARGS__)

// 定义weak类型实例
#define STWeakObj(weakObj, obj)  __weak __typeof(&*obj)weakObj = obj
#define STDefineWeakSelf STWeakObj(weakSelf, self)
// 使用block
#define STSafeBlock(block,...)  \
if (block){\
block(__VA_ARGS__);\
}

// 控制台输出
#ifdef DEBUG
#define STLog(...) NSLog(__VA_ARGS__)
#else
#define STLog(...) NSLog(@"")
#endif

// 版本号
#define ST_iOS7_Later  ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define ST_iOS8_Later  ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )

// application
#define STApp [UIApplication sharedApplication]

// 字体
static inline UIFont *st_font(CGFloat size){
    return [UIFont systemFontOfSize:size];
}
static inline UIFont *st_fontBlod(CGFloat size){
    return [UIFont boldSystemFontOfSize:size];
}


#endif
