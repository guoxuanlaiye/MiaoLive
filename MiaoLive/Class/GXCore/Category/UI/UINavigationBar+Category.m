//
//  UINavigationBar+Category.m
//  switchJB
//
//  Created by C on 16/5/10.
//  Copyright © 2016年 程旭东. All rights reserved.
//

#import "UINavigationBar+Category.h"
#import <objc/runtime.h>

@implementation UINavigationBar (Category)
static char overlayKey;
#pragma mark - ***** 运行时加属性 *****

- (UIView *)overlay {
    return objc_getAssociatedObject(self, &overlayKey);
}
- (void)setOverlay:(UIView *)overlay {
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)lt_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}

- (void)lt_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)lt_setElementsAlpha:(CGFloat)alpha
{
    
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

- (void)lt_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

- (void)lt_setImageViewAlpha:(CGFloat)alpha
{
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

- (void)lt_setNavgationBarColor:(UIColor *)barColor allItemColor:(UIColor *)allItemColor titleTextColor:(UIColor *)titleTextColor NavgationBarBottomLineViewAlpha:(CGFloat)lineViewAlpha{

    // 导航栏颜色
    [self lt_setBackgroundColor:barColor];
    
    
    //导航栏上Item的颜色
    [self setTintColor:allItemColor];
    
    //导航栏标题颜色为透明
    [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleTextColor, NSForegroundColorAttributeName,nil]];
    
    // 隐藏导航栏自带的底部线条
    [self lt_setImageViewAlpha:lineViewAlpha];

}

- (void)lt_setNavgationBarAlpha:(CGFloat)alpha{

    self.alpha = alpha;
}


@end
