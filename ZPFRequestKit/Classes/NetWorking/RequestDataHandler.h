//
//  RequestDataHandler.h
//  KangMei
//
//  Created by PF Z on 2017/3/15.
//  Copyright © 2017年 jiaZhengHe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PageDataReqModel.h"

@protocol RequestDataHandlerDelegate <NSObject>

@optional
//正在获取数据的代理
-(void)gettingData;

//获取到了新数据的代理
-(void)didGetData:(id )data;

//没有更多数据的代理
-(void)noMoreData;

//获取数据失败
-(void)failedToGetData;


/* 带Handler参数的代理 */
//正在获取数据的代理
-(void)gettingData:(id)handler;

//获取到了新数据的代理
-(void)didGetData:(id )data handler:(id)handler;

//没有更多数据的代理
-(void)noMoreData:(id)handler;

//获取数据失败
-(void)failedToGetData:(id)handler;

@end




@interface RequestDataHandler : NSObject


- (instancetype)initWithPageModel:(PageDataReqModel *)pageModel;

@property (nonatomic,strong) NSMutableDictionary *paramDic;

//是否正在搜索
@property (nonatomic,assign) BOOL isSearchingKeyword;

@property (nonatomic,strong) PageDataReqModel *pageModel;

//代理
@property (nonatomic,assign) id<RequestDataHandlerDelegate>delegate;

//是否正在加载数据
@property (nonatomic,assign) BOOL isLoadingData;


-(NSArray *)curDataArr;

//查询关键字
-(void)searchKeyWordParam:(NSDictionary *)paramDic;


//获取下一页
-(void)getNextPage;

//重新加载
-(void)resetPage;


@end
