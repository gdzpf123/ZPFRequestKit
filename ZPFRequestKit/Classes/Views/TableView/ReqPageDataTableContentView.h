//
//  ReqPageDataTableContentView.h
//  ZPFRequestKit
//
//  Created by fcar on 2019/8/22.
//  Copyright © 2019 fcar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestDataHandler.h"
#import "RequestCellDelegates.h"
#import "CommonReqTableView.h"

NS_ASSUME_NONNULL_BEGIN



@interface ReqPageDataTableContentView : UIView

@property (nonatomic,assign) RequestDataType dataType;
@property (nonatomic,assign) BOOL showLoadingFooter;
@property (nonatomic,strong) NSMutableArray *reqDataArr;
@property (nonatomic,strong) PageDataReqModel *pageModel;
@property (nonatomic,strong) RequestDataHandler *requestHandler;
@property (nonatomic,strong) CommonReqTableView *tableView;


-(Class)preferNoDataViewClass;
-(Class)preferNoMoreFooterClass;
-(Class)preferLoadMoreFooterClass;
-(Class)preferCellClassForModel:(id)model;

-(void)addHUD;
-(void)removeHUD;
-(void)addHUD:(NSString *)text time:(int)time;

-(void)regetData;
-(NSDictionary *)requestParamDic;


@end



NS_ASSUME_NONNULL_END
