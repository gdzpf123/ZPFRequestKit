//
//  ReqPageDataCollectionContnetnView.m
//  ZPFRequestKit
//
//  Created by fcar on 2019/8/22.
//  Copyright © 2019 fcar. All rights reserved.
//

#import "ReqPageDataCollectionContnetnView.h"
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import "NoDataView.h"
#import "NoMoreDataCollectionFooter.h"
#import "LoadingMoreCollectionFooter.h"
#import "UICollectionView+Register.h"

@interface ReqPageDataCollectionContnetnView ()<UICollectionViewDelegate,UICollectionViewDataSource,RequestDataHandlerDelegate>


@property (nonatomic,strong) UIView *noDataView;

@end

@implementation ReqPageDataCollectionContnetnView
{
    BOOL isNomoreData;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.collectionView.frame=self.bounds;
}

-(void)setup
{
    _reqDataArr=[NSMutableArray array];
    [self beforeSetUpCollectionView];
    
    [self addSubview:self.collectionView];
    [self registCell];
    
    [self afterSetUpCollectionView];
}

-(void)registCell
{
    
}

-(void)beforeSetUpCollectionView
{
}

-(void)afterSetUpCollectionView
{
}

-(void)addHUD
{
}

-(void)removeHUD
{
}

-(void)addHUD:(NSString *)text time:(int)time
{
}

-(Class)preferNoDataViewClass
{
    return [NoDataView class];
}

-(Class)preferNoMoreFooterClass
{
    return [NoMoreDataCollectionFooter class];
}

-(Class)preferLoadMoreFooterClass
{
    return [LoadingMoreCollectionFooter class];
}

-(Class)preferCellClassForModel:(id)model
{
    return [UITableViewCell class];
}

-(void)pullRefresh
{
    [self regetData];
}

-(void)regetData
{
    isNomoreData=NO;
    [self.collectionView.mj_header endRefreshing];
    [_reqDataArr removeAllObjects];
    
    [self.requestHandler.paramDic removeAllObjects];
    [self.requestHandler.paramDic setValuesForKeysWithDictionary:[self requestParamDic]];
    [self.requestHandler resetPage];
}

-(BOOL)checkIsNomoreDataIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section>=self.reqDataArr.count) {
        return YES;
    }
    
    NSArray *dataArr=self.reqDataArr;
    
    id obj=nil;
    if (self.dataType==RequestDataType_ARR_OBJ) {
        obj=dataArr[indexPath.row];
    }else
    {
        obj=dataArr[indexPath.section][indexPath.row];
    }
    
    if ([obj isKindOfClass:[NSString class]] && [obj isEqualToString: (@"没有更多了...")]) {
        return YES;
    }else{
        return NO;
    }
}


-(BOOL)checkIsNodata
{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    id obj=[self getObjectFromIndexPath:indexPath];
    if ([obj isKindOfClass:[NSString class]] && [obj isEqualToString: (@"没有更多了...")]) {
        return YES;
    }else{
        return NO;
    }
}

-(id)getObjectFromIndexPath:(NSIndexPath *)indexPath
{
    NSArray *dataArr=self.reqDataArr;
    if (self.dataType == RequestDataType_ARR_ARR) {
        if (indexPath.section>=dataArr.count) {
            return nil;
        }
        if (indexPath.row>=[dataArr[indexPath.section] count]) {
            return nil;
        }
        
        return dataArr[indexPath.section][indexPath.row];
    }else{
        if (indexPath.row>=[dataArr count]) {
            return nil;
        }
        
        return dataArr[indexPath.row];
    }
}


-(NSDictionary *)requestParamDic
{
    return nil;
}

#pragma mark -------requestHandlerDelegate-------
//正在获取数据的代理
-(void)gettingData
{
    if (self.showLoadingFooter) {
        return;
    }
    
    [self addHUD];
}

//获取到了新数据的代理
-(void)didGetData:(id )data
{
    [self removeHUD];
    self.noDataView.hidden=YES;
    
    [self.reqDataArr removeAllObjects];
    
    Class cellCls=[self preferCellClassForModel:@""];
    if (cellCls == nil ) {
        return;
    }
    Class modelCls=[NSObject class];
    if ([cellCls respondsToSelector:@selector(ItemCellModelClass)]) {
        modelCls = [cellCls ItemCellModelClass];
    }
    
    if (data) {
        NSArray *dataArr=data;
        for (int i=0; i<dataArr.count; i++) {
            NSDictionary *dataDic=dataArr[i];
            id model=[modelCls mj_objectWithKeyValues:dataDic];
            if (self.dataType == RequestDataType_ARR_ARR) {
                [self.reqDataArr addObject:@[model]];
            }else{
                [self.reqDataArr addObject:model];
            }
        }
    }
    
    [self.collectionView reloadData];
}

//没有更多数据的代理
-(void)noMoreData
{
    if (self.pageModel.limit==0 ) {
        return;
    }
    
    isNomoreData=YES;
    
    
    [self removeHUD];
    [self.collectionView reloadData];
}

//获取数据失败
-(void)failedToGetData
{
    [self addHUD:@"获取失败" time:1.0];
    
    if (self.reqDataArr.count == 0) {
        self.noDataView.hidden=NO;
    }
    
}


#pragma mark -------CollectionViewDelegate----------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataType == RequestDataType_ARR_ARR) {
        
        return [_reqDataArr[section] count];
    }else{
        return [_reqDataArr count];
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.dataType == RequestDataType_ARR_ARR) {
        return _reqDataArr.count;
    }else{
        return 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell=[collectionView getRegistedCell:[self preferCellClassForModel:[self getObjectFromIndexPath:indexPath]]  indexPath:indexPath];
    if ([cell respondsToSelector:@selector(setItemCellModel:)]) {
        [(id)cell setItemCellModel:[self getObjectFromIndexPath:indexPath]];
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *header=[collectionView getRegistedHeader:[UICollectionReusableView class] indexPath:indexPath];
        
        return header;
    }
    else if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        NSInteger index=0;
        NSArray *dataArr=self.reqDataArr;
        if (self.dataType == RequestDataType_ARR_ARR) {
            index=dataArr.count -1 ;
        }else{
            index=0;
        }
        
        if (index == indexPath.section) {
            if (self.showLoadingFooter) {
                if (isNomoreData) {
                    return [collectionView getRegistedFooter:[self preferNoMoreFooterClass] indexPath:indexPath];
                }else{
                    return [collectionView getRegistedFooter:[self preferLoadMoreFooterClass] indexPath:indexPath];
                }
            }else{
                if (isNomoreData) {
                    return [collectionView getRegistedFooter:[self preferNoMoreFooterClass] indexPath:indexPath];
                }else{
                    return [collectionView getRegistedFooter:[UICollectionReusableView class] indexPath:indexPath];
                }
            }
        }else{
            return [collectionView getRegistedFooter:[UICollectionReusableView class] indexPath:indexPath];

        }
        
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Class cellCls=[self preferCellClassForModel:[self getObjectFromIndexPath:indexPath]];
    CGSize size=CGSizeMake(100, 100);
    if ([cellCls respondsToSelector:@selector(ItemCellSize:)]) {
        size = [cellCls ItemCellSize:[self getObjectFromIndexPath:indexPath]];
    }
    
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){collectionView.bounds.size.width,0.1};
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGFloat width=collectionView.bounds.size.width;
    CGFloat height=0.1;
    
    NSInteger index=0;
    NSArray *dataArr=self.reqDataArr;
    if (self.dataType == RequestDataType_ARR_ARR) {
        index=dataArr.count-1;
    }else{
        index=0;
    }
    
    if (index == section) {
        if (self.showLoadingFooter) {
            CGFloat height=0.1;
            
            if (isNomoreData) {
                Class footerCls=[self preferNoMoreFooterClass];
                if ([footerCls respondsToSelector:@selector(noMoreFooterHeight)]) {
                    height=[footerCls noMoreFooterHeight];
                }
            }else{
                Class footerCls=[self preferLoadMoreFooterClass];
                if ([footerCls respondsToSelector:@selector(loadingMoreFooterHeight)]) {
                    height=[footerCls loadingMoreFooterHeight];
                }
            }
            
        }else{
            
            if (isNomoreData) {
                Class footerCls=[self preferNoMoreFooterClass];
                if ([footerCls respondsToSelector:@selector(noMoreFooterHeight)]) {
                    height=[footerCls noMoreFooterHeight];
                }
            }else{
                
            }
        }
    }
    return CGSizeMake(width, height);
}

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell=[collectionView cellForItemAtIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(cellDidSelected)]) {
        [(id)cell cellDidSelected];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (isNomoreData || _reqDataArr.count==0 || self.pageModel.limit==0) {
        return;
    }
    
    CGFloat offsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.bounds.size.height;
    if (scrollView.contentOffset.y >= offsetY)
    {
        //正在加载数据的时候，没有更多数据的时候和已经删除过数据之后都不能再加载更多，以免数据出现错乱
        if (!self.requestHandler.isLoadingData) {
            [self.requestHandler getNextPage];
        }
    }
}


#pragma mark ------LAZY

-(CommonReqCollectionView *)collectionView{
    if (_collectionView == nil) {
        _collectionView =[[CommonReqCollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;;
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.mj_header=[MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullRefresh)];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

-(NSMutableArray *)reqDataArr{
    if (_reqDataArr == nil) {
        _reqDataArr = [NSMutableArray new];
    }
    return _reqDataArr;
}

-(RequestDataHandler *)requestHandler{
    if (_requestHandler == nil) {
        _requestHandler = [[RequestDataHandler alloc] initWithPageModel:self.pageModel];
        _requestHandler.delegate=self;
    }
    return _requestHandler;
}

-(UIView *)noDataView
{
    if (!_noDataView) {
        Class viewCls=[self preferNoDataViewClass];
        _noDataView=[[viewCls alloc] init];
        [self.collectionView addSubview:_noDataView];
        _noDataView.frame=CGRectMake(0, 0, self.collectionView.bounds.size.width, _noDataView.frame.size.height);
        _noDataView.hidden=YES;
    }
    
    return _noDataView;
}

-(PageDataReqModel *)pageModel{
    if (_pageModel == nil) {
        _pageModel = [[PageDataReqModel alloc] init];
        _pageModel.requestType=PageDataReqType_POST;
    }
    return _pageModel;
}

@end
