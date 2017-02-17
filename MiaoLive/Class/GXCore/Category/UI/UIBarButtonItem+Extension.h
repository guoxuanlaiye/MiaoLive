//
//  UIBarButtonItem+Extension.h
//  GXWeibo
//
//  Created by ailimac100 on 15/8/18.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)creatItemWithTarget:(id)target action:(SEL)action image:(NSString *)image highlightImage:(NSString *)highImage;
+ (UIBarButtonItem *)creatItemWithTarget:(id)target action:(SEL)action image:(NSString *)image selectedImage:(NSString *)selectedImage;
+ (UIBarButtonItem *)creatItemWithTarget:(id)target action:(SEL)action backgroundImage:(NSString *)image selectedBackgroundImage:(NSString *)selectedImage;
+ (UIBarButtonItem *)creatItemWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title;

+ (UIBarButtonItem *)creatItemWithTarget:(id)target action:(SEL)action title:(NSString *)title titleColor:(UIColor *)color font:(UIFont*)font;

@end
