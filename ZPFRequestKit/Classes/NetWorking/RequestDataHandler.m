
//
//  RequestDataHandler.m
//  KangMei
//
//  Created by PF Z on 2017/3/15.
//  Copyright © 2017年 jiaZhengHe. All rights reserved.
//

#import "RequestDataHandler.h"
#import <AFNetworking/AFNetworking.h>

@interface RequestDataHandler ()

@property (nonatomic,strong) NSMutableArray *dataArr;   //存放所有数据的数组
@property (nonatomic,strong) NSMutableDictionary *keyWordDic;


@end

@implementation RequestDataHandler
{
//    int pageSize;
    

}
@synthesize delegate = _delegate;

- (instancetype)initWithPageModel:(PageDataReqModel *)pageModel
{
    self = [super init];
    if (self) {
        self.pageModel=pageModel;
    }
    return self;
}


-(NSArray *)curDataArr
{
    return [NSArray arrayWithArray:self.dataArr];
}


-(void)getNextPage
{
    if (self.isLoadingData || !self.pageModel.requestUrl) {
        return;
    }
    
    self.isLoadingData=YES;
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(gettingData)]){
        [self.delegate gettingData];
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(gettingData:)]){
        [self.delegate gettingData:self];
    }
    
    

    
    //设置参数
    [self.paramDic setValuesForKeysWithDictionary:self.keyWordDic];
    [self.paramDic setValuesForKeysWithDictionary:[self.pageModel getParamDic]];
    
    //开始请求数据
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval=15;
    if(self.pageModel.enableJson)
    {
        AFJSONRequestSerializer *requestSerializer= [AFJSONRequestSerializer serializer];
        manager.requestSerializer = requestSerializer;
        
    }else{
        AFHTTPRequestSerializer *requestSerializer= [AFHTTPRequestSerializer serializer];
        manager.requestSerializer = requestSerializer;
    }
    if (self.pageModel.requestType == PageDataReqType_Get) {
        [manager GET:self.pageModel.requestUrl parameters:self.paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self requestDataSucceed:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self requestDataFailed:error];
        }];
    }else if (self.pageModel.requestType == PageDataReqType_POST){
        [manager POST:self.pageModel.requestUrl parameters:self.paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self requestDataSucceed:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self requestDataFailed:error];
        }];
    }
    
}


//获取数据成功
-(void)requestDataSucceed:(id)data
{
    
    if ([self.pageModel checkData:data]) {
        
        NSArray *dicArr=[self.pageModel getPageDataListArrFromResponseObj:data[@"data"]];;

        if (dicArr.count>0) {
            
            [self.dataArr addObjectsFromArray:dicArr];
            if (self.delegate && [self.delegate respondsToSelector:@selector(didGetData:)]) {
                [self.delegate didGetData:self.dataArr];
            }
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(didGetData:handler:)]) {
                [self.delegate didGetData:self.dataArr handler:self];
            }
            
            self.pageModel.offset=self.pageModel.offset+1;
            
            
//            if (dicArr.count<self.pageModel.limit) {
                if (dicArr.count!=self.pageModel.limit ) {

                if (self.delegate && [self.delegate respondsToSelector:@selector(noMoreData)]) {
                    [self.delegate noMoreData];
                }
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(noMoreData:)]) {
                    [self.delegate noMoreData:self];
                }
            }
            
            
            
        }else{
            //执行没有更多数据的代理
            if (self.delegate && [self.delegate respondsToSelector:@selector(noMoreData)]) {
                [self.delegate noMoreData];
            }
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(noMoreData:)]) {
                [self.delegate noMoreData:self];
            }
        }
        
        
        //        }
        
        
        self.isLoadingData=NO;
    }else{
        
        self.isLoadingData=NO;
        
        //执行获取数据失败的代理
        if (self.delegate && [self.delegate respondsToSelector:@selector(failedToGetData)]) {
            [self.delegate failedToGetData];
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(failedToGetData:)]) {
            [self.delegate failedToGetData:self];
        }
        
    }
    
}



//获取数据失败代理
-(void)requestDataFailed:(NSError *)error
{
    
    self.isLoadingData=NO;
    
    //执行获取数据失败的代理
    if (self.delegate && [self.delegate respondsToSelector:@selector(failedToGetData)]) {
        [self.delegate failedToGetData];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(failedToGetData:)]) {
        [self.delegate failedToGetData:self];
    }
    
}


//查询关键字
-(void)searchKeyWordParam:(NSDictionary *)paramDic
{
    [self.keyWordDic removeAllObjects];
    [self.keyWordDic setValuesForKeysWithDictionary:paramDic];
    
    [self resetPage];
    self.isSearchingKeyword=YES;
    
}

//重新获取数据
-(void)resetPage
{
    self.pageModel.offset=1;
    [self.dataArr removeAllObjects];
    [self getNextPage];
}

#pragma mark -------lazy
-(NSMutableDictionary *)paramDic
{
    if (!_paramDic) {
        _paramDic=[NSMutableDictionary dictionary];
    }
    
    return _paramDic;
}

-(NSMutableDictionary *)keyWordDic
{
    if (!_keyWordDic) {
        _keyWordDic=[NSMutableDictionary dictionary];
    }
    return _keyWordDic;
}

-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}


@end
