//
//  GXTabbarController.m
//  GXWeibo
//
//  Created by ailimac100 on 15/8/13.
//  Copyright (c) 2015年 GX. All rights reserved.
//


#import "GXTabbarController.h"
#import "GXNavigationViewController.h"

#import "HomeViewController.h"
#import "ShowTimeViewController.h"
#import "ProfileViewController.h"
#import "GXMacro.h"
#import "ShowTimeViewController.h"
#import "PermissionView.h"
#import <AVFoundation/AVFoundation.h>
#import "NSObject+GXAlertView.h"

@interface GXTabbarController ()<UITabBarControllerDelegate>

@end

@implementation GXTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.delegate = self;
    
    HomeViewController * homeVC       = [[HomeViewController alloc]init];
    [self addChildVCWith:homeVC tabbarTitle:@"" tabbarNormalImage:@"toolbar_home" tabbarSelectedImage:@"toolbar_home_sel"];

    ShowTimeViewController * showVC   = [[ShowTimeViewController alloc]init];
    [self addChildVCWith:showVC tabbarTitle:@"" tabbarNormalImage:@"toolbar_live" tabbarSelectedImage:@"toolbar_live"];

    ProfileViewController * profileVC = [[ProfileViewController alloc]init];
    [self addChildVCWith:profileVC tabbarTitle:@"" tabbarNormalImage:@"toolbar_me" tabbarSelectedImage:@"toolbar_me_sel"];
}

- (void)addChildVCWith:(UIViewController *)childVc tabbarTitle:(NSString *)tabbarTitle tabbarNormalImage:(NSString *)imageName tabbarSelectedImage:(NSString *)selectedImageName
{
    
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    //按照原始样式显示出来图片，不被系统渲染成蓝色
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置文字样式
//    NSMutableDictionary * textAttrs                 = [[NSMutableDictionary alloc]init];
//    textAttrs[NSForegroundColorAttributeName]       = [UIColor grayColor];
//    NSMutableDictionary * selectTextAttrs           = [[NSMutableDictionary alloc]init];
//    selectTextAttrs[NSForegroundColorAttributeName] = RGBA(208, 177, 132, 1);
//    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    //添加导航条
    GXNavigationViewController * nav = [[GXNavigationViewController alloc]initWithRootViewController:childVc];
    //添加子控制器
    [self addChildViewController:nav];
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([tabBarController.childViewControllers indexOfObject:viewController] == tabBarController.childViewControllers.count-2) {
    
        
        // 判断是否有摄像头权限
        AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
            [self showAlertWithVC:self message:@"app需要访问您的摄像头。\n请启用摄像头-设置/隐私/摄像头"];
            return NO;
        }
        // 开启麦克风权限
        AVAudioSession * audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    return YES;
                } else {
                    [self showAlertWithVC:self message:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风"];
                    return NO;
                }
            }];
        }

        ShowTimeViewController * showVC = [[ShowTimeViewController alloc]init];
        [self presentViewController:showVC animated:YES completion:nil];
        
//        PermissionView * perView = [PermissionView createPermissionView];
//        perView.frame = [UIApplication sharedApplication].keyWindow.frame;
//        [perView show];
        return NO;
    }
    return YES;
}
@end
