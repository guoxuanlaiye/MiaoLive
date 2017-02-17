//
//  LiveDetailViewController.m
//  MiaoLive
//
//  Created by yingcan on 17/2/6.
//  Copyright © 2017年 Guoxuan. All rights reserved.
//

#import "LiveDetailViewController.h"
#import <IJKMediaFramework/IJKFFMoviePlayerController.h>

@interface LiveDetailViewController ()
@property(nonatomic,strong)IJKFFMoviePlayerController * player;
@end

@implementation LiveDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.player prepareToPlay];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.player shutdown];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault]; //使用默认配置
    NSURL * url = [NSURL URLWithString:_liveUrl];
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:options]; //初始化播放器，播放在线视频或直播(RTMP)
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.player.view.frame  = self.view.bounds;
    self.player.scalingMode = IJKMPMovieScalingModeAspectFit; //缩放模式
    self.player.shouldAutoplay = YES; //开启自动播放
    
    self.view.autoresizesSubviews = YES;
    [self.view addSubview:self.player.view];
}

@end
