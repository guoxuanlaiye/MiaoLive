//
//  HomeViewController.m
//  MiaoLive
//
//  Created by yingcan on 17/1/5.
//  Copyright © 2017年 Guoxuan. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHotListSmallViewCell.h"
#import "HomeHotViewModel.h"
#import "HomeHotListModel.h"
#import "GXScrollMenuView.h"
#import "UIViewController+GXHUD.h"
#import <MJRefresh/MJRefresh.h>
#import "GXNetworkManager.h"


static NSString * hotSmallCell = @"hotSmallCell";

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView * hotSmallCollectionView;
@property (nonatomic, strong) NSMutableArray * hotListArray;
@property (nonatomic, strong) GXScrollMenuView * menuView;
@property (nonatomic, assign) NSInteger currentPageIndex;

@end

@implementation HomeViewController
- (NSMutableArray *)hotListArray
{
    if (!_hotListArray) {
        _hotListArray = [NSMutableArray array];
    }
    return _hotListArray;
}
- (GXScrollMenuView *)menuView
{
    if (!_menuView) {
        _menuView = [[GXScrollMenuView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 50.0) menuTitles:@[@"热门",@"才艺",@"最新",@"关注",@"附近",@"海外",@"官方"]];
        
    }
    return _menuView;
}
- (UICollectionView *)hotSmallCollectionView
{
    if (!_hotSmallCollectionView) {
        
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        _hotSmallCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 114.0, self.view.frame.size.width, self.view.frame.size.height - 114.0 - 49.0) collectionViewLayout:flowLayout];
        _hotSmallCollectionView.backgroundColor = [UIColor whiteColor];
        _hotSmallCollectionView.dataSource = self;
        _hotSmallCollectionView.delegate   = self;
        
    }
    return _hotSmallCollectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    
    [self loadHomeData];
  
    [self setupRefresh];
}
#pragma mark - 设置界面
- (void)setupView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.hotSmallCollectionView];
    
    UINib * nib = [UINib nibWithNibName:@"HomeHotListSmallViewCell" bundle:nil];
    [self.hotSmallCollectionView registerNib:nib forCellWithReuseIdentifier:hotSmallCell];
}
#pragma mark - 首次加载数据
- (void)loadHomeData {
    _currentPageIndex = 1;
    [self loadDataWithUrl:Home_HotList pageIndex:_currentPageIndex];
}
#pragma mark - 设置下拉和上拉
- (void)setupRefresh
{
    __weak typeof(self)ws = self;
    //下拉刷新
    MJRefreshGifHeader * header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [ws.hotListArray removeAllObjects];
        _currentPageIndex = 1;
        [ws loadDataWithUrl:Home_HotList pageIndex:_currentPageIndex];
    }];
    
    [header setImages:@[[UIImage imageNamed:@"hold1_60x72_"]] forState:MJRefreshStateIdle];
    [header setImages:@[[UIImage imageNamed:@"hold3_60x72_"]] forState:MJRefreshStatePulling];
    [header setImages:@[[UIImage imageNamed:@"hold1_60x72_"],
                        [UIImage imageNamed:@"hold2_60x72_"],
                        [UIImage imageNamed:@"hold3_60x72_"]] forState:MJRefreshStateRefreshing];
    //隐藏上一次刷新时间文字
    header.lastUpdatedTimeLabel.hidden = YES;
    //隐藏状态文字
    header.stateLabel.hidden = YES;
    self.hotSmallCollectionView.mj_header = header;
    
    //上拉加载更多
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       
        _currentPageIndex++;
        [ws loadDataWithUrl:Home_HotList pageIndex:_currentPageIndex];
    }];
    self.hotSmallCollectionView.mj_footer = footer;
}
#pragma mark - 加载数据
- (void)loadDataWithUrl:(NSString *)url pageIndex:(NSInteger )index
{
    NSLog(@"------url = %@",url);
    
    GXRequestConfigure * requestConf = [GXRequestConfigure configure];
    requestConf.urlPath    = url;
    requestConf.paramsDict = @{@"page":[NSString stringWithFormat:@"%zd",index]};
    
    [GXNetworkManager loadDataWithRequestConfigure:requestConf callBackBlock:^(NSDictionary *result) {
        [self.hotSmallCollectionView.mj_header endRefreshing];
        [self.hotSmallCollectionView.mj_footer endRefreshing];
        if ([result[@"code"] isEqualToString:@"100"]) {
            
            NSDictionary * dataDict = result[@"data"];
            [self.hotListArray addObjectsFromArray:[HomeHotListModel mj_objectArrayWithKeyValuesArray:dataDict[@"list"]]];
            [self.hotSmallCollectionView reloadData];
        }

    } failureBlock:^(NSError *error) {
        [self.hotSmallCollectionView.mj_header endRefreshing];
        [self.hotSmallCollectionView.mj_footer endRefreshing];
    }];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    HomeHotViewModel * VM = [[HomeHotViewModel alloc]init];
    if (self.hotListArray.count > 0) {
        VM.listModel = self.hotListArray[indexPath.row];
    }
    return [VM setupSmallViewCellWithIndexPath:indexPath collectionView:collectionView];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.hotListArray.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake((self.view.frame.size.width-10)/2, (self.view.frame.size.width-2)/2);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {

    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    HomeHotViewModel * VM = [[HomeHotViewModel alloc]init];
    if (self.hotListArray.count > 0) {
        VM.listModel = self.hotListArray[indexPath.row];
    }
    [VM intoLiveDetailControllerWithVC:self];
}
@end
