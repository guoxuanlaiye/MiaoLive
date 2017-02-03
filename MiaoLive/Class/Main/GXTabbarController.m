//
//  GXTabbarController.m
//  GXWeibo
//
//  Created by ailimac100 on 15/8/13.
//  Copyright (c) 2015年 GX. All rights reserved.
//


#import "GXTabbarController.h"
#import "RememberViewController.h"
#import "CircleViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "GXNavigationViewController.h"
#import "CommonHeader.h"
#import "UITabBar+LittleRedDotBadge.h"

#import "MessageDBTool.h"
#import "ContactsDBTool.h"

#import "IMClientManager.h"
#import "LocalUDPDataSender.h"
#import "GXAccountTool.h"
#import <sys/utsname.h>
@interface GXTabbarController ()
//{
//    NSString *_str;
//}
@property (nonatomic, copy) ObserverCompletion onLoginSucessObserver;// block代码块一定要用copy属性，否则报错！
@property (nonatomic, strong) NSMutableDictionary *dic;
@end

@implementation GXTabbarController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.selectedViewController beginAppearanceTransition: YES animated: animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.selectedViewController endAppearanceTransition];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.selectedViewController beginAppearanceTransition: NO animated: animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.selectedViewController endAppearanceTransition];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transDataNotification:) name:@"TransDataEvent" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(msgPushNotification:) name:@"MsgPushNotification" object:nil];
    RememberViewController * rememberVC = [[RememberViewController alloc]init];
    
    [self addChildVCWith:rememberVC tabbarTitle:@"记忆" tabbarNormalImage:@"tabbar_jiyihui" tabbarSelectedImage:@"tabbar_jiyi"];

    CircleViewController * circleVC = [[CircleViewController alloc]init];
    [self addChildVCWith:circleVC tabbarTitle:@"通讯录" tabbarNormalImage:@"tabbar_tongxunluhui" tabbarSelectedImage:@"tabbar_tongxunlu"];

    MessageViewController * messageVC = [[MessageViewController alloc]init];
    [self addChildVCWith:messageVC tabbarTitle:@"消息" tabbarNormalImage:@"tabbar_xiaoxihui" tabbarSelectedImage:@"tabbar_xiaoxi"];

    ProfileViewController * profileVC = [[ProfileViewController alloc]init];
    [self addChildVCWith:profileVC tabbarTitle:@"我的" tabbarNormalImage:@"tabbar_wohui" tabbarSelectedImage:@"tabbar_wo"];
    
    //进行udp连接
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        [self sendUDPRequest];
        
    });

    
    //进行IP地址连接
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        
//        [self ipUpData];
//        
//    });
    
    //手机型号
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self phoneUpData];
    });
    
    //请求好友数据
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self requestContacts];
    });
}

//手机型号
- (NSString *)iphoneType {
    
    //需要导入头文件：#import <sys/utsname.h>
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone4,1"])
    {
        return @"iPhone 4S";
    }else if ([platform isEqualToString:@"iPhone5,1"])
    {
        return @"iPhone 5";
    }else if ([platform isEqualToString:@"iPhone5,2"])
    {
        return @"iPhone 5";
    }else if ([platform isEqualToString:@"iPhone5,3"])
    {
        return @"iPhone 5c";
    }else if ([platform isEqualToString:@"iPhone5,4"])
    {
        return @"iPhone 5c";
    }else  if ([platform isEqualToString:@"iPhone6,1"])
    {
        return @"iPhone 5s";
    }else if ([platform isEqualToString:@"iPhone6,2"])
    {
        return @"iPhone 5s";
    }else if ([platform isEqualToString:@"iPhone7,1"])
    {
        return @"iPhone 6 Plus";
    }else if ([platform isEqualToString:@"iPhone7,2"])
    {
        return @"iPhone 6";
    }else if ([platform isEqualToString:@"iPhone8,1"])
    {
        return @"iPhone 6s";
    }else if ([platform isEqualToString:@"iPhone8,2"])
    {
        return @"iPhone 6s Plus";
    }else if ([platform isEqualToString:@"iPhone8,4"])
    {
        return @"iPhone SE";
    }else if ([platform isEqualToString:@"iPhone9,1"])
    {
        return @"iPhone 7";
    }else if ([platform isEqualToString:@"iPhone9,2"])
    {
        return @"iPhone 7 Plus";
    }else if ([platform isEqualToString:@"iPod1,1"])
    {
        return @"iPod Touch 1G";
    }else if ([platform isEqualToString:@"iPod2,1"])
    {
        return @"iPod Touch 2G";
    }else if ([platform isEqualToString:@"iPod3,1"])
    {
        return @"iPod Touch 3G";
    }else if ([platform isEqualToString:@"iPod4,1"])
    {
        return @"iPod Touch 4G";
    }else if ([platform isEqualToString:@"iPod5,1"])
    {
        return @"iPod Touch 5G";
    }else if ([platform isEqualToString:@"i386"])
    {
        return @"iPhone Simulator";
    }else if ([platform isEqualToString:@"x86_64"])
    {
        return @"iPhone Simulator";
    }
    return platform;
}

-(void)phoneUpData
{
    NSString * userToken          = [[NSUserDefaults standardUserDefaults]valueForKey:@"currentUserToken"];
    NSMutableDictionary * dataDic = [NSMutableDictionary dictionary];
    
    NSDictionary * infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    // 当前应用软件版本  比如：1.0.1
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    dataDic[@"deviceName"]  = [self iphoneType];
    dataDic[@"userToken"]   = userToken;
    dataDic[@"channel"]     = @"";
    dataDic[@"appVersion"]  = appCurVersion;
    dataDic[@"deviceFlg"]   = @"0";
    dataDic[@"deviceVersion"] = [[UIDevice currentDevice] systemVersion];
    [GXHttpTool post:ServiceURL_PhoneUrl params:dataDic success:^(id json) {
        
        NSLog(@"phoneData = %@",json);
        
    } failure:^(NSError *error) {
    }];
}
-(void)uploadIpData
{
    NSString * taobaoUrl          = @"http://ip.taobao.com/service/getIpInfo.php?ip=myip";
    NSMutableDictionary * dataDic = [NSMutableDictionary dictionary];
    [GXHttpTool post:taobaoUrl params:dataDic success:^(id json) {
        
        NSLog(@"ipdata ----- %@",json);
        if (json) {
            NSString * code = [NSString stringWithFormat:@"%@",json[@"code"]];
            if ([code isEqualToString:@"0"]) {
                
            }
        }
    } failure:^(NSError *error) {
    }];
}

- (void)msgPushNotification:(NSNotification *)notification
{
    self.selectedIndex = 2;
}

#pragma mark - 预请求通讯录数据（在本地没有好友数据的情况下）
- (void)requestContacts
{
//    NSArray * contactsArray = [[ContactsDBTool shareDBManager] getContactsFromDBWithUserId:CurrentUserId];
//    if (contactsArray.count == 0) {
    
        NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
        paramDict[@"userToken"]         = CurrentUserToken;
        
        [GXHttpTool post:ServiceURL_GetContactsList params:paramDict success:^(id json) {
            
            if (json) {
                NSString * code = [NSString stringWithFormat:@"%@",json[@"code"]];
                if ([code isEqualToString:@"0"]) {
                    //存本地数据库
                    [[ContactsDBTool shareDBManager] saveContacts:[NSArray arrayWithArray:json[@"userVoList"]] userId:CurrentUserId];
                }
            }
        } failure:^(NSError *error) {
        }];
        
//    } else {
//        return;
//    }
}

#pragma mark - 发送UDP请求
- (void)sendUDPRequest
{
    
    [[[IMClientManager sharedInstance] getBaseEventListener] setLoginOkForLaunchObserver:self.onLoginSucessObserver];
    
    GXAccount * account = [GXAccountTool account];
    
    // * 发送登陆数据包(提交登陆名和密码)
    int code = [[LocalUDPDataSender sharedInstance] sendLogin:CurrentUserId withPassword:account.userPw];
    if (code == COMMON_CODE_OK) {
        
    } else {
        
    }
    [[IMClientManager sharedInstance] getBaseEventListener].loginOkForLaunchObserver = ^(NSString * observerble ,NSString * arg1) {
        
        if ([arg1 isEqualToString:@"0"]) {
            NSLog(@"--------- 连接成功 ++++++++++userid = %@,errorCode = %@",observerble,arg1);
            
        } else {
            NSLog(@"--------- 连接失败 ！！！");
        }
    };
    
}
- (void)transDataNotification:(NSNotification *)notification
{
    NSDictionary * userInfo = notification.userInfo;
    
    NSLog(@"+++++++监听接收到的数据+++++++%@",userInfo);

    NSString * type = [NSString stringWithFormat:@"%@", userInfo[@"type"]];
    NSString * code = [NSString stringWithFormat:@"%@", userInfo[@"code"]];
    
    if (type) {
        
        if ([type isEqualToString:@"SM01"]) { //消息
            
            if ([code isEqualToString:@"0"]) {
                
                [self.tabBar showBadgeOnItemIndex:2];
                //发送新消息通知到消息界面
                [[NSNotificationCenter defaultCenter] postNotificationName:@"msgDataEvent" object:nil userInfo:userInfo];
                
            } else {
                NSLog(@"消息数据错误");
            }
            
        } else if ([type isEqualToString:@"SG02"]) {  //SG02:通知加好友
            
            if ([code isEqualToString:@"0"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"circleAndFriendEvent" object:nil userInfo:userInfo];

                
            } else {
                NSLog(@"消息数据错误");
            }
            
            
        } else if ([type isEqualToString:@"SA20"] ||
                   [type isEqualToString:@"SW01"] ||
                   [type isEqualToString:@"SG01"] ||
                   [type isEqualToString:@"SG03"] ||
                   [type isEqualToString:@"SG04"] ||
                   [type isEqualToString:@"SA10"] ||
                   [type isEqualToString:@"SA01"] ) { //SA20: 补充记忆  SW01: 新增记忆  SG01:通知进群  SG03:通知被圈子移除  SG04:通知圈子名被修改   SA10:评论   SA01: 点赞
        
//            if ([code isEqualToString:@"0"]) {
            
                [[NSNotificationCenter defaultCenter] postNotificationName:@"homeMemoryUnreadEvent" object:nil userInfo:userInfo];

//            } else {
//                NSLog(@"消息数据错误");
//            }
            
        
        }

        
        
    }
}
- (void)addChildVCWith:(UIViewController *)childVc tabbarTitle:(NSString *)tabbarTitle tabbarNormalImage:(NSString *)imageName tabbarSelectedImage:(NSString *)selectedImageName
{
//    childVc.view.backgroundColor = [UIColor whiteColor];
    
    childVc.title = tabbarTitle;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    //按照原始样式显示出来图片，不被系统渲染成蓝色
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置文字样式
    NSMutableDictionary * textAttrs                 = [[NSMutableDictionary alloc]init];
    textAttrs[NSForegroundColorAttributeName]       = [UIColor grayColor];
    NSMutableDictionary * selectTextAttrs           = [[NSMutableDictionary alloc]init];
    selectTextAttrs[NSForegroundColorAttributeName] = RGBA_COLOR(208, 177, 132, 1);
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
       //添加导航条
    GXNavigationViewController * nav = [[GXNavigationViewController alloc]initWithRootViewController:childVc];
    //添加子控制器
    [self addChildViewController:nav];
}

@end
