//
//  STTabbar.m
//  STClockDemo
//
//  Created by zhenlintie on 15/7/28.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STTabbar.h"

static CGFloat const kSTTabbarHeight = 49;
static CGFloat const kSTTabbarImageHeight = 38;

@interface STTabbar ()

@property (strong, nonatomic) NSMutableArray *itemButtons;

@property (strong, nonatomic) UIImageView *shadowLine;

@end

@implementation STTabbar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:CGRectMake(0, 0, screenWidth(), kSTTabbarHeight)]){
        _itemButtons = [NSMutableArray array];
        _selectedIndex = 0;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
        
        self.shadowLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottom_shadow"]];
        [self addSubview:self.shadowLine];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.shadowLine.width = self.width;
    self.shadowLine.bottom = 0;
}

- (void)setItems:(NSArray *)items{
    _items = items;
    [self reloadData];
}

- (void)reloadData{
    [_itemButtons makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_itemButtons removeAllObjects];
    
    if (_items.count > 0){
        CGFloat buttonWidth = self.width/_items.count;
        _selectedIndex = 0;
        [_items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            STTabbarButton *button = (STTabbarButton *)obj;
            button.frame = CGRectMake(idx*buttonWidth, 0, buttonWidth, kSTTabbarHeight);
            [button setSelected:idx==_selectedIndex];
            [button setDidClicked:^(STTabbarButton *sender) {
                NSInteger index = [_itemButtons indexOfObject:sender];
                if ([self.delegate tabbar:self shouldSelectedIndex:index]){
                    [self.delegate tabbar:self didSelectedIndex:index];
                    _selectedIndex = index;
                    for (STTabbarButton *btn in _itemButtons){
                        [btn setSelected:btn==sender];
                    }
                }
            }];
            [self addSubview:button];
            [_itemButtons addObject:button];
        }];
    }
}

@end






@interface STTabbarButton ()

@property (strong, nonatomic) UIImageView *bgImageView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation STTabbarButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self loadUI];
        self.exclusiveTouch = YES;
        [self addTarget:self action:@selector(touchUpInside) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)loadUI{
    _bgImageView = [UIImageView new];
    _imageView = [UIImageView new];
    _imageView.contentMode = UIViewContentModeCenter;
    _titleLabel = [UILabel new];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = st_font(10);
    [self addSubview:_bgImageView];
    [self addSubview:_imageView];
    [self addSubview:_titleLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _bgImageView.frame = self.bounds;
    _imageView.frame = CGRectMake(0, 0, self.width, kSTTabbarImageHeight);
    _titleLabel.frame = CGRectMake(0, kSTTabbarImageHeight-2, self.width, kSTTabbarHeight-kSTTabbarImageHeight);
    [self updateState];
}

#pragma mark - setter

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    [self updateState];
}

- (void)setSelectedBackgroundImage:(UIImage *)selectedBackgroundImage{
    _selectedBackgroundImage = selectedBackgroundImage;
    [self updateState];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = title;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    [self updateState];
}

- (void)setSelectedImage:(UIImage *)selectedImage{
    _selectedImage = selectedImage;
    [self updateState];
}

#pragma mark - other

- (void)updateState{
    if (self.selected){
        _bgImageView.image = self.selectedBackgroundImage;
        _imageView.image = self.selectedImage;
        _titleLabel.textColor = STRGB(242, 242, 242);
    }
    else{
        _bgImageView.image = nil;
        _imageView.image = self.image;
        _titleLabel.textColor = STRGB(160, 160, 160);
    }
}

- (void)touchUpInside{
    STSafeBlock(self.didClicked, self);
}

@end
