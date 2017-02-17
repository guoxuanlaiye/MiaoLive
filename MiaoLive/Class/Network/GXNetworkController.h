//
//  GXNetworkController.h
//  MiaoLive
//
//  Created by yingcan on 17/2/3.
//  Copyright © 2017年 Guoxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerUrlHeader.h"

typedef NS_ENUM(NSInteger,AFNetworkType) {
    
    AFNetworkTypeGET = 1, //GET请求
    AFNetworkTypePOST     //POST请求
};
@interface GXNetworkController : UIViewController
- (void)loadDataUrl:(NSString *)url networkType:(AFNetworkType)type params:(NSMutableDictionary *)paramsDict successBlock:(void(^)(NSDictionary * result))result failureBlock:(void(^)(NSError * error))failure;

@end
