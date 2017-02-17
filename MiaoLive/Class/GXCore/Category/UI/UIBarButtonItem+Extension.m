//
//  UIBarButtonItem+Extension.m
//  GXWeibo
//
//  Created by ailimac100 on 15/8/18.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)creatItemWithTarget:(id)target action:(SEL)action image:(NSString *)image highlightImage:(NSString *)highImage
{
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];

    backButton.size = backButton.currentImage.size;
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return  [[UIBarButtonItem alloc]initWithCustomView:backButton];
}
+ (UIBarButtonItem *)creatItemWithTarget:(id)target action:(SEL)action image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    backButton.backgroundColor = [UIColor redColor];
    [backButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    
    backButton.size = backButton.currentImage.size;
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return  [[UIBarButtonItem alloc]initWithCustomView:backButton];
}
+ (UIBarButtonItem *)creatItemWithTarget:(id)target action:(SEL)action backgroundImage:(NSString *)image selectedBackgroundImage:(NSString *)selectedImage
{
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    
    backButton.size = backButton.currentBackgroundImage.size;
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return  [[UIBarButtonItem alloc]initWithCustomView:backButton];
}
+ (UIBarButtonItem *)creatItemWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title
{
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if (image) {
        
        UIImage * Btnimage = [UIImage imageNamed:image];
        [backButton setImage:[Btnimage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 30)] forState:UIControlStateNormal];
        [backButton setTitle:[NSString stringWithFormat:@" %@",title] forState:UIControlStateNormal];

    } else {
        [backButton setTitle:title forState:UIControlStateNormal];
    }

    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [backButton sizeToFit];
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return  [[UIBarButtonItem alloc]initWithCustomView:backButton];

}
+ (UIBarButtonItem *)creatItemWithTarget:(id)target action:(SEL)action title:(NSString *)title titleColor:(UIColor *)color font:(UIFont*)font
{
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:title forState:UIControlStateNormal];
    [backButton setTitleColor:color forState:UIControlStateNormal];
    backButton.titleLabel.font = font;
    [backButton sizeToFit];
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return  [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
}

@end
