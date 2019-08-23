//
//  ReqPageDataTableContentView.m
//  ZPFRequestKit
//
//  Created by fcar on 2019/8/22.
//  Copyright © 2019 fcar. All rights reserved.
//

#import "ReqPageDataTableContentView.h"
#import <MJExtension/MJExtension.h>
#import "NoDataView.h"
#import "NoMoreDataTableFooter.h"
#import "LoadingMoreTableFooter.h"
#import "UITableView+Register.h"

@interface ReqPageDataTableContentView ()<UITableViewDelegate,UITableViewDataSource,RequestDataHandlerDelegate>


@property (nonatomic,strong) UIView *noDataView;

@end


@implementation ReqPageDataTableContentView
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
    self.tableView.frame=self.bounds;
}

-(void)setup
{
    _reqDataArr=[NSMutableArray array];
    [self beforeSetUpTableView];
    
    [self addSubview:self.tableView];
    [self registCell];
    
    [self afterSetUpTableView];
}

-(void)registCell
{

}

-(void)beforeSetUpTableView
{
}

-(void)afterSetUpTableView
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
    return [NoMoreDataTableFooter class];
}

-(Class)preferLoadMoreFooterClass
{
    return [LoadingMoreTableFooter class];
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
    [self.tableView.mj_header endRefreshing];
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
    
    Class cellCls=[self preferCellClassForModel:nil];
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
    
    [self.tableView reloadData];
}

//没有更多数据的代理
-(void)noMoreData
{
    if (self.pageModel.limit==0 ) {
        return;
    }
    
    isNomoreData=YES;
   
    
    [self removeHUD];
    [self.tableView reloadData];
}

//获取数据失败
-(void)failedToGetData
{
    [self addHUD:@"获取失败" time:1.0];
    
    if (self.reqDataArr.count == 0) {
        self.noDataView.hidden=NO;
    }
    
}


#pragma mark -------tableViewDelegate----------
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataType == RequestDataType_ARR_ARR) {
        
        return [_reqDataArr[section] count];
    }else{
        return [_reqDataArr count];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataType == RequestDataType_ARR_ARR) {
        return _reqDataArr.count;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell=[tableView getRegistedCell:[self preferCellClassForModel:[self getObjectFromIndexPath:indexPath]]];
    if ([cell respondsToSelector:@selector(setItemCellModel:)]) {
        [(id)cell setItemCellModel:[self getObjectFromIndexPath:indexPath]];
    }
    
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSInteger index=0;
    NSArray *dataArr=self.reqDataArr;
    if (self.dataType == RequestDataType_ARR_ARR) {
        index=dataArr.count -1 ;
    }else{
        index=0;
    }
    
    if (index == section) {
        if (self.showLoadingFooter) {
            if (isNomoreData) {
                return [tableView getRegistedFooter:[self preferNoMoreFooterClass]];
            }else{
                return [tableView getRegistedFooter:[self preferLoadMoreFooterClass]];
            }
        }else{
            if (isNomoreData) {
                return [tableView getRegistedFooter:[self preferNoMoreFooterClass]];
            }else{
                
            }
        }
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
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
            
            return height;
        }else{
            CGFloat height=0.1;
            
            if (isNomoreData) {
                Class footerCls=[self preferNoMoreFooterClass];
                if ([footerCls respondsToSelector:@selector(noMoreFooterHeight)]) {
                    height=[footerCls noMoreFooterHeight];
                }
            }else{
              
            }
            return height;
        }
    }
    
   
    
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class cellCls=[self preferCellClassForModel:[self getObjectFromIndexPath:indexPath]];
    CGFloat height=0.1;
    if ([cellCls respondsToSelector:@selector(ItemCellHeight:)]) {
        height = [cellCls ItemCellHeight:[self getObjectFromIndexPath:indexPath]];
    }
    
    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[tableView cellForRowAtIndexPath:indexPath];
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
-(CommonReqTableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[CommonReqTableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.mj_header=[MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullRefresh)];
        [self addSubview:_tableView];
    }
    return _tableView;
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
        [self.tableView addSubview:_noDataView];
        _noDataView.frame=CGRectMake(0, 0, self.tableView.bounds.size.width, _noDataView.frame.size.height);
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
