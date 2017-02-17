//
//  HomeHotListModel.h
//  MiaoLive
//
//  Created by yingcan on 17/2/4.
//  Copyright © 2017年 Guoxuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

@interface HomeHotListModel : NSObject
@property (nonatomic, assign) NSInteger pos;
@property (nonatomic, assign) NSInteger allnum;
@property (nonatomic, assign) NSInteger roomid;
@property (nonatomic, assign) NSInteger serverid;
@property (nonatomic, copy)   NSString * gps;
@property (nonatomic, copy)   NSString * flv;
@property (nonatomic, assign) NSInteger starlevel;
@property (nonatomic, copy)   NSString * familyName;
@property (nonatomic, assign) NSInteger isSign;
@property (nonatomic, copy)   NSString * nation;
@property (nonatomic, copy)   NSString * nationFlag;
@property (nonatomic, assign) NSInteger distance;
@property (nonatomic, assign) NSInteger useridx;
@property (nonatomic, copy)   NSString * userId;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, copy)   NSString * myname;
@property (nonatomic, copy)   NSString * signatures;
@property (nonatomic, copy)   NSString * smallpic;
@property (nonatomic, copy)   NSString * bigpic;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) NSInteger grade;
@property (nonatomic, assign) NSInteger curexp;

@end
