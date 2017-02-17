//
//  LoginViewController.m
//  MiaoLive
//
//  Created by yingcan on 17/1/5.
//  Copyright © 2017年 Guoxuan. All rights reserved.
//

#import "LoginViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "GXTabbarController.h"

@interface LoginViewController ()

@property (nonatomic, strong) AVPlayerLayer * loginPlayLayer;
@property (nonatomic, strong) AVPlayer * loginPlay;
@property (nonatomic, strong) UIButton * loginBtn;

@end

@implementation LoginViewController
- (UIButton *)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame = CGRectMake(100, 200, 100, 30);
        _loginBtn.backgroundColor = [UIColor orangeColor];
        [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    }
    return _loginBtn;
}
- (AVPlayerLayer *)loginPlayLayer
{
    if (!_loginPlayLayer) {

        NSString *path = arc4random_uniform(10) % 2 ? @"login_video" : @"loginmovie";
        
        NSURL * sourceMovieUrl    = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:path ofType:@"mp4"]];
        AVAsset * movieAsset      = [AVURLAsset URLAssetWithURL:sourceMovieUrl options:nil];
        AVPlayerItem * playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
        
        _loginPlay                   = [AVPlayer playerWithPlayerItem:playerItem];
        _loginPlayLayer              = [AVPlayerLayer playerLayerWithPlayer:_loginPlay];
        _loginPlayLayer.frame        = self.view.bounds;
        _loginPlayLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
    }
    return _loginPlayLayer;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_loginPlay pause];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _loginPlayLayer = nil;
    _loginPlay      = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initObserver];
    
    [self setupPlayer];
}
- (void)loginBtnClick
{
    UIWindow * mainWindow = [UIApplication sharedApplication].keyWindow;
    mainWindow.rootViewController = [[GXTabbarController alloc]init];
    
}
#pragma mark - 播放结束监听
- (void)initObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}
- (void)didFinish:(NSNotification *)notification
{
    //重复播放
    AVPlayerItem * p = [notification object];
    [p seekToTime:kCMTimeZero];
    [_loginPlay play];
}
#pragma mark - 设置播放界面
- (void)setupPlayer
{
    [self.view.layer addSublayer:self.loginPlayLayer];
    [_loginPlay play];
    [self.view addSubview:self.loginBtn];
}
@end
