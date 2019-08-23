//
//  PageDataReqModel.m
//  LaiFengHui_App
//
//  Created by PF Z on 2018/8/23.
//  Copyright © 2018年 zengPengFei. All rights reserved.
//

#import "PageDataReqModel.h"

@implementation PageDataReqModel

- (instancetype)init
{
    self = [super init];
    if (self) {

        self.offset=1;
        self.limit=20;
        self.order=nil;
        self.sort=nil;
        self.enableJson=YES;
    }
    return self;
}

//获取分页参数
-(NSDictionary *)getParamDic
{
//    return @{@"offset":@(self.offset),@"limit":@(self.limit)};
    return @{@"page":@(self.offset),@"limit":@(self.limit)};
}

//对后台返回的数据对象进行处理，返回分页数组
-(NSArray *)getPageDataListArrFromResponseObj:(NSDictionary *)responseObj
{
    if ([responseObj isKindOfClass:[NSDictionary class]]) {
        for (NSArray *arr in [responseObj allValues]) {
            if ([arr isKindOfClass:[NSArray class]]) {
                return arr;
            }
        }
    }else if ([responseObj isKindOfClass:[NSArray class]]){
        return responseObj;
    }
    
    return @[];
}

-(BOOL)checkData:(NSDictionary *)dataDic
{
    return YES;
}



@end
