//
//  GXScrollMenuView.m
//  MiaoLive
//
//  Created by yingcan on 17/2/4.
//  Copyright © 2017年 Guoxuan. All rights reserved.
//

#import "GXScrollMenuView.h"

//const CGFloat menuWidth  = 60.0f;
#define MenuHeight self.frame.size.height

@interface GXScrollMenuView ()

//@property (nonatomic, strong) UIScrollView * backScrollView;

@end

@implementation GXScrollMenuView

- (instancetype)initWithFrame:(CGRect)frame menuTitles:(NSArray *)titles {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViewWithTitles:titles frame:frame];
    }
    return self;
}
- (void)setupViewWithTitles:(NSArray *)titles frame:(CGRect)frame
{
    if (titles.count == 0) {
        return;
    }
    UIScrollView * backScrollView  = [[UIScrollView alloc]init];
    backScrollView.frame           = CGRectMake(0, 0, frame.size.width, frame.size.height);
    backScrollView.contentSize     = CGSizeMake(60 * titles.count, 0);
    backScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:backScrollView];


    for (NSInteger i = 0; i < titles.count; i++) {
        
        UIButton * menuBtn      = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn.frame           = CGRectMake(60.0 * i, 0, 60.0, frame.size.height);
        [menuBtn setTitle:titles[i] forState:UIControlStateNormal];
        [menuBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [backScrollView addSubview:menuBtn];
    }
    
}
@end
