//
//  GXMacro.h
//  GXShareDemo
//
//  Created by yingcan on 17/1/5.
//  Copyright © 2017年 Guoxuan. All rights reserved.
//

#ifndef GXMacro_h
#define GXMacro_h

// MainScreen Height&Width
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

// MainScreen bounds
#define Main_Screen_Bounds      [[UIScreen mainScreen] bounds]

// App版本号
#define appMPVersion            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

// 当前版本
#define FSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define SSystemVersion          ([[UIDevice currentDevice] systemVersion])

// 是否空对象
#define IS_NULL_CLASS(OBJECT)   [OBJECT isKindOfClass:[NSNull class]]

//色值
#define RGBA(r,g,b,a)           [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b)              RGBA(r,g,b,1.0f)

//AppDelegate对象
#define AppDelegateInstance [[UIApplication sharedApplication] delegate]
//一些缩写
#define kApplication        [UIApplication sharedApplication]
#define kKeyWindow          [UIApplication sharedApplication].keyWindow
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

//Library/Caches 文件路径
#define FilePath            ([[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil])
//获取 temp
#define kPathTemp           NSTemporaryDirectory()
//获取沙盒 Document
#define kPathDocument       [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define kPathCache          [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//字符串是否为空
#define kStringIsEmpty(str)  ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic)    (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//中文字体
#define CHINESE_FONT_NAME  @"Heiti SC"
#define CHINESE_SYSTEM(x)  [UIFont fontWithName:CHINESE_FONT_NAME size:x]

//不同屏幕尺寸字体适配（320，568是因为效果图为IPHONE5 如果不是则根据实际情况修改）
#define kScreenWidthRatio  (Main_Screen_Width / 320.0)
#define kScreenHeightRatio (Main_Screen_Height / 568.0)
#define AdaptedWidth(x)    ceilf((x) * kScreenWidthRatio)
#define AdaptedHeight(x)   ceilf((x) * kScreenHeightRatio)
#define AdaptedFontSize(R) CHINESE_SYSTEM(AdaptedWidth(R))

#define UNICODETOUTF16(x) (((((x - 0x10000) >>10) | 0xD800) << 16)  | (((x-0x10000)&3FF) | 0xDC00))
#define MULITTHREEBYTEUTF16TOUNICODE(x,y) (((((x ^ 0xD800) << 2) | ((y ^ 0xDC00) >> 8)) << 8) | ((y ^ 0xDC00) & 0xFF)) + 0x10000



#endif /* GXMacro_h */
