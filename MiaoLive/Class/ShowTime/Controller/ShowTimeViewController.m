//
//  ShowTimeViewController.m
//  MiaoLive
//
//  Created by yingcan on 17/2/6.
//  Copyright © 2017年 Guoxuan. All rights reserved.
//

#import "ShowTimeViewController.h"
#import <LFLiveKit/LFLiveKit.h>
@interface ShowTimeViewController () <LFLiveSessionDelegate>
@property (nonatomic, strong) LFLiveSession *session;
@property (nonatomic, strong) UIView * livingPreView;
@property (weak, nonatomic) IBOutlet UILabel *liveStatusLab;

@property (nonatomic, copy) NSString *rtmpUrl;

@end

@implementation ShowTimeViewController
- (UIView *)livingPreView
{
    if (!_livingPreView) {
        _livingPreView = [[UIView alloc]initWithFrame:self.view.bounds];
        _livingPreView.backgroundColor  = [UIColor clearColor];
        _livingPreView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view insertSubview:_livingPreView atIndex:0];
    }
    return _livingPreView;
}
- (LFLiveSession *)session
{
    if (!_session) {
        
        /***   默认分辨率368 ＊ 640  音频：44.1 iphone6以上48  双声道  方向竖屏 ***/
        
        _session = [[LFLiveSession alloc]initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Medium2] captureType:LFLiveCaptureMaskAll];
        _session.delegate = self;
        _session.running  = YES;
        _session.preView  = self.livingPreView;
        
        
        /**    自己定制高质量音频128K 分辨率设置为720*1280 方向竖屏 */
        /*
         LFLiveAudioConfiguration *audioConfiguration = [LFLiveAudioConfiguration new];
         audioConfiguration.numberOfChannels = 2;
         audioConfiguration.audioBitrate = LFLiveAudioBitRate_128Kbps;
         audioConfiguration.audioSampleRate = LFLiveAudioSampleRate_44100Hz;
         
         LFLiveVideoConfiguration *videoConfiguration = [LFLiveVideoConfiguration new];
         videoConfiguration.videoSize = CGSizeMake(720, 1280);
         videoConfiguration.videoBitRate = 800*1024;
         videoConfiguration.videoMaxBitRate = 1000*1024;
         videoConfiguration.videoMinBitRate = 500*1024;
         videoConfiguration.videoFrameRate = 15;
         videoConfiguration.videoMaxKeyframeInterval = 30;
         videoConfiguration.orientation = UIInterfaceOrientationPortrait;
         videoConfiguration.sessionPreset = LFCaptureSessionPreset720x1280;
         
         _session = [[LFLiveSession alloc] initWithAudioConfiguration:audioConfiguration videoConfiguration:videoConfiguration liveType:LFLiveRTMP];
         */

    }
    return _session;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}
- (void)setupView
{
    //默认前置摄像头
    self.session.captureDevicePosition = AVCaptureDevicePositionFront;
}
//关闭直播
- (IBAction)closeBtnClick:(UIButton *)sender {
    
    if (self.session.state == LFLivePending || self.session.state == LFLiveStart){
        [self.session stopLive];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
//智能美颜开启
- (IBAction)beautyBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    // 默认是开启了美颜功能的
    self.session.beautyFace = !self.session.beautyFace;
}
//开始直播
- (IBAction)beginLivingBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) { // 开始直播
        
        LFLiveStreamInfo *stream = [LFLiveStreamInfo new];
        // 如果是跟我blog教程搭建的本地服务器, 记得填写你电脑的IP地址
        stream.url = @"rtmp://192.168.1.187:1935/rtmplive/room";
        self.rtmpUrl = stream.url;
        [self.session startLive:stream];
    } else { // 结束直播
        [self.session stopLive];
        self.liveStatusLab.text = [NSString stringWithFormat:@"状态: 直播被关闭\nRTMP: %@", self.rtmpUrl];
    }
}
//切换相机镜头
- (IBAction)changeCameraBtnClick:(UIButton *)sender {
    
    AVCaptureDevicePosition devicePositon = self.session.captureDevicePosition;
    self.session.captureDevicePosition = (devicePositon == AVCaptureDevicePositionBack) ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
}

#pragma mark -- LFStreamingSessionDelegate
/** live status changed will callback */
- (void)liveSession:(nullable LFLiveSession *)session liveStateDidChange:(LFLiveState)state{
    NSString *tempStatus;
    switch (state) {
        case LFLiveReady:
            tempStatus = @"准备中";
            break;
        case LFLivePending:
            tempStatus = @"连接中";
            break;
        case LFLiveStart:
            tempStatus = @"已连接";
            break;
        case LFLiveStop:
            tempStatus = @"已断开";
            break;
        case LFLiveError:
            tempStatus = @"连接出错";
            break;
        default:
            break;
    }
    NSLog(@"--连接状态--%@",tempStatus);
    self.liveStatusLab.text = [NSString stringWithFormat:@"状态: %@\nRTMP: %@", tempStatus, self.rtmpUrl];
}

/** live debug info callback */
- (void)liveSession:(nullable LFLiveSession *)session debugInfo:(nullable LFLiveDebug*)debugInfo{
    
}

/** callback socket errorcode */
- (void)liveSession:(nullable LFLiveSession*)session errorCode:(LFLiveSocketErrorCode)errorCode{
    
}


@end
