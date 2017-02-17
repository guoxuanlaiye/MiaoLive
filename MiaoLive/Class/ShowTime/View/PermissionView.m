//
//  PermissionView.m
//  MiaoLive
//
//  Created by yingcan on 17/2/6.
//  Copyright © 2017年 Guoxuan. All rights reserved.
//

#import "PermissionView.h"

@implementation PermissionView

+(instancetype)createPermissionView {
    return [[[NSBundle mainBundle]loadNibNamed:@"PermissionView" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
}
- (void)show
{
    UIWindow * mainWindow = [UIApplication sharedApplication].keyWindow;
    
//    [mainWindow addSubview:self];
    UIView * backgroundView = [[UIView alloc]initWithFrame:mainWindow.frame];
    backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    [backgroundView addSubview:self];
    [mainWindow addSubview:backgroundView];
    
}
@end
