//
//  GXNetworkManager.m
//  MiaoLive
//
//  Created by yingcan on 17/2/3.
//  Copyright © 2017年 Guoxuan. All rights reserved.
//

#import "GXNetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "NSObject+GXAlertView.h"

/*
 * 网络请求配置
 */
@implementation GXRequestConfigure
+ (instancetype)configure {
    GXRequestConfigure * conf = [[GXRequestConfigure alloc]init];
    conf.networkType = GXNetworkTypePOST; //默认post请求
    return conf;
}
@end

@implementation GXNetworkManager

+ (void)loadDataUrl:(NSString *)url networkType:(GXNetworkType)type params:(NSMutableDictionary *)paramsDict successBlock:(void(^)(NSDictionary * result))result failureBlock:(void(^)(NSError * error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/javascript", nil];

    if (type == GXNetworkTypeGET) { //GET请求
        
        [manager GET:url parameters:paramsDict progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (result) {
                result(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
        
    } else { //POST请求
        
        [manager POST:url parameters:paramsDict progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (result) {
                result(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}

+ (void)loadDataWithRequestConfigure:(GXRequestConfigure *)configure callBackBlock:(void(^)(NSDictionary * result))result failureBlock:(void(^)(NSError * error))failure {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/javascript", nil];
    
    if (configure.networkType == GXNetworkTypeGET) { //GET请求
        
        [manager GET:configure.urlPath parameters:configure.paramsDict progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (result) {
                result(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self showAlertWithMessage:@"网络状况不太好哦亲~"];
            if (failure) {
                failure(error);
            }
        }];
        
    } else { //POST请求
        
        [manager POST:configure.urlPath parameters:configure.paramsDict progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (result) {
                result(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self showAlertWithMessage:@"网络状况不太好哦亲~"];
            if (failure) {
                failure(error);
            }
        }];
    }
}

@end
