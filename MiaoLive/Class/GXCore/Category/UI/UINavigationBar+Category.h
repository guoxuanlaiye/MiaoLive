//
//  UINavigationBar+Category.h
//  switchJB
//
//  Created by C on 16/5/10.
//  Copyright © 2016年 程旭东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Category)

/**
 *  设置导航栏所有属性的配色
 * 
 *  @param barColor                导航栏颜色
 *  @param allItemColor            导航栏所有按钮的颜色
 *  @param titleTextColor          导航栏标题颜色
 *  @param lineViewAlpha           导航栏底部View线图alpha
 */
- (void)lt_setNavgationBarColor:(UIColor *)barColor allItemColor:(UIColor *)allItemColor titleTextColor:(UIColor *)titleTextColor NavgationBarBottomLineViewAlpha:(CGFloat)lineViewAlpha;
- (void)lt_setNavgationBarAlpha:(CGFloat)alpha;
- (void)lt_setImageViewAlpha:(CGFloat)alpha;
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;
- (void)lt_setElementsAlpha:(CGFloat)alpha;
- (void)lt_setTranslationY:(CGFloat)translationY;
- (void)lt_reset;

@end
