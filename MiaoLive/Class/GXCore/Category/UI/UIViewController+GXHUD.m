//
//  UIViewController+GXHUD.m
//  MiaoLive
//
//  Created by yingcan on 17/2/6.
//  Copyright © 2017年 Guoxuan. All rights reserved.
//

#import "UIViewController+GXHUD.h"
#import <objc/runtime.h>

static const void *HUDKey = &HUDKey;

@implementation UIViewController (GXHUD)
#pragma mark - 动态绑定HUD属性
- (MBProgressHUD *)HUD
{
    return objc_getAssociatedObject(self, HUDKey);
}

- (void)setHUD:(MBProgressHUD * _Nullable)HUD
{
    objc_setAssociatedObject(self, HUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - 方法实现

- (void)showTextHudInView:(UIView *)view hint:(NSString *)hint{
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.label.text = hint;
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:2];
    [self setHUD:HUD];
}


- (void)showTextHud:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:2];
    [self setHUD:hud];
}


- (void)hideHud{
    [[self HUD] hideAnimated:YES];
}

@end
