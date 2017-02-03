//
//  GXNavigationViewController.m
//  GXWeibo
//
//  Created by ailimac100 on 15/8/18.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import "GXNavigationViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UINavigationBar+Category.h"
#import "CommonHeader.h"
@interface GXNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation GXNavigationViewController

+ (void)initialize
{
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    
    //设置普通状态
    NSMutableDictionary * textAttrs           = [[NSMutableDictionary alloc]init];
    textAttrs[NSFontAttributeName]            = [UIFont systemFontOfSize:17.0f];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];

    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置不可点击状态
//    NSMutableDictionary * disableTextAttrs = [[NSMutableDictionary alloc]init];
////    disableTextAttrs[NSForegroundColorAttributeName] = RGBA_COLOR(123, 123, 123, 1.0f);
//    disableTextAttrs[NSFontAttributeName]  = [UIFont systemFontOfSize:14.0f];
//    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBackImg_white"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19.0f],NSForegroundColorAttributeName:RGBA_COLOR(70, 70, 70, 1)}];
    
    self.interactivePopGestureRecognizer.delegate = self;

}
//右滑返回上一界面
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    BOOL ok = YES; // 默认为支持右滑反回
//    if ([self.topViewController isKindOfClass:[HYBBaseViewController class]]) {
//        if ([self.topViewController respondsToSelector:@selector(gestureRecognizerShouldBegin)]) {
//            HYBBaseViewController *vc = (HYBBaseViewController *)self.topViewController;
//            ok = [vc gestureRecognizerShouldBegin];
//        }
//    }
    
    return ok;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
//        UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        backButton.frame = CGRectMake(0, 0, 44, 44);
//        [backButton setImage:[UIImage imageNamed:@"fanhui_hui"] forState:UIControlStateNormal];
//        
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem creatItemWithTarget:self action:@selector(backBtnClick) backgroundImage:@"fanhui_hui" selectedBackgroundImage:@"fanhui_hui"];

//        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem creatItemWithTarget:self action:@selector(backBtnClick) backgroundImage:@"nav_more" selectedBackgroundImage:@"nav_more"];
        
    }
    [super pushViewController:viewController animated:animated];

}
- (void)backBtnClick
{
    [self popViewControllerAnimated:YES];
}
//- (void)moreBtnClick
//{
//    [self popToRootViewControllerAnimated:YES];
//}
@end
