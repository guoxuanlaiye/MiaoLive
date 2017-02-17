//
//  HomeHotViewModel.h
//  MiaoLive
//
//  Created by yingcan on 17/2/4.
//  Copyright © 2017年 Guoxuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class HomeHotListSmallViewCell;
@class HomeHotListModel;

@interface HomeHotViewModel : NSObject
@property (nonatomic, strong) HomeHotListModel * listModel;
- (HomeHotListSmallViewCell *)setupSmallViewCellWithIndexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView;
//进入直播详情
- (void)intoLiveDetailControllerWithVC:(UIViewController*)baseViewController;
@end
