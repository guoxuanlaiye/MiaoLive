//
//  UIViewController+GXHUD.h
//  MiaoLive
//
//  Created by yingcan on 17/2/6.
//  Copyright © 2017年 Guoxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface UIViewController (GXHUD)
/** HUD */
@property (nonatomic, weak, readonly) MBProgressHUD *HUD;
/**
 *  提示信息
 *
 *  @param view 显示在哪个view
 *  @param hint 提示
 */
- (void)showTextHudInView:(UIView *)view hint:(NSString *)hint;
/**
 *  提示信息
 *
 *  显示在当前window上
 *  @param hint 提示
 */
- (void)showTextHud:(NSString *)hint;
/**
 *  隐藏
 */
- (void)hideHud;

@end
