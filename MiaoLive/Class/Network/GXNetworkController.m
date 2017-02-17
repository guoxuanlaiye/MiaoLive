//
//  GXNetworkController.m
//  MiaoLive
//
//  Created by yingcan on 17/2/3.
//  Copyright © 2017年 Guoxuan. All rights reserved.
//

#import "GXNetworkController.h"
#import <AFNetworking/AFNetworking.h>

@interface GXNetworkController ()

@end

@implementation GXNetworkController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)loadDataUrl:(NSString *)url networkType:(AFNetworkType)type params:(NSMutableDictionary *)paramsDict successBlock:(void (^)(NSDictionary *))result failureBlock:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/javascript", nil];
    
    if (type == AFNetworkTypeGET) {
        
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
        
    } else {
        
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

@end
