//
//  STToast.m
//  STClockDemo
//
//  Created by zhenlintie on 15/7/29.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STToast.h"

@interface STToast ()

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation STToast

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        _titleLabel = [UILabel new];
        _titleLabel.textColor = st_colorWhite();
        _titleLabel.font = st_font(13);
        [self addSubview:_titleLabel];
        
        self.backgroundColor = st_colorGrayA(0, 0.85);
        self.layer.cornerRadius = 5;
    }
    return self;
}

+ (instancetype)toastWithMessage:(NSString *)message{
    STToast *toast = [STToast new];
    [toast setMessage:message];
    return toast;
}

- (void)setMessage:(NSString *)message{
    _titleLabel.text = message;
    [_titleLabel sizeToFit];
    self.width = _titleLabel.width+8;
    self.height = _titleLabel.height+8;
    _titleLabel.center = CGPointMake(self.width/2, self.height/2);
}

@end
