//
//  UITabBar+LittleRedDotBadge.h
//  RememberTime
//
//  Created by yingcan on 16/10/10.
//  Copyright © 2016年 yingcan. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * tabbar上的小红点
 */
@interface UITabBar (LittleRedDotBadge)
- (void)showBadgeOnItemIndex:(int)index;
- (void)hideBadgeOnItemIndex:(int)index;

@end
