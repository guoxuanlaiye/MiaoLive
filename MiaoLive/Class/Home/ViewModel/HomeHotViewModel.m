//
//  HomeHotViewModel.m
//  MiaoLive
//
//  Created by yingcan on 17/2/4.
//  Copyright © 2017年 Guoxuan. All rights reserved.
//

#import "HomeHotViewModel.h"
#import "HomeHotListSmallViewCell.h"
#import "HomeHotListModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LiveDetailViewController.h"

static NSString * hotSmallCell = @"hotSmallCell";

@implementation HomeHotViewModel

/**
    直播列表视图
 */
- (HomeHotListSmallViewCell *)setupSmallViewCellWithIndexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView
{
    
    HomeHotListSmallViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:hotSmallCell forIndexPath:indexPath];
    if (_listModel) {
     
        [cell.bgPicImgV sd_setImageWithURL:[NSURL URLWithString:_listModel.smallpic]];
        cell.allNumLab.text      = [NSString stringWithFormat:@"%zd 人",_listModel.allnum];
        cell.nickNameLab.text    = _listModel.myname;
        NSString * starImgStr    = [NSString stringWithFormat:@"girl_star%zd_40x19",_listModel.starlevel];
        cell.starLevelImgV.image = [UIImage imageNamed:starImgStr];
    }
    return cell;
}
/**
    跳转直播详情
 */
- (void)intoLiveDetailControllerWithVC:(UIViewController *)baseViewController
{
    LiveDetailViewController * detailVC = [[LiveDetailViewController alloc]init];
    detailVC.liveUrl = _listModel.flv;
    [baseViewController presentViewController:detailVC animated:YES completion:nil];
}
@end
