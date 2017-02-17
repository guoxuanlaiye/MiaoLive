//
//  GXNetworkManager.h
//  MiaoLive
//
//  Created by yingcan on 17/2/3.
//  Copyright © 2017年 Guoxuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerUrlHeader.h"

typedef NS_ENUM(NSInteger,GXNetworkType) {
    
    GXNetworkTypeGET = 1, //GET请求
    GXNetworkTypePOST     //POST请求
};
//请求参数配置
@interface GXRequestConfigure : NSObject
+ (instancetype)configure;
@property (nonatomic, copy)  NSString * urlPath;
@property (nonatomic, copy)  NSDictionary * paramsDict;
@property (nonatomic, assign) GXNetworkType networkType;
@end

//网络请求管理类
@interface GXNetworkManager : NSObject

+ (void)loadDataUrl:(NSString *)url networkType:(GXNetworkType)type params:(NSMutableDictionary *)paramsDict successBlock:(void(^)(NSDictionary * result))result failureBlock:(void(^)(NSError * error))failure;

+ (void)loadDataWithRequestConfigure:(GXRequestConfigure *)configure callBackBlock:(void(^)(NSDictionary * result))result failureBlock:(void(^)(NSError * error))failure;

@end
