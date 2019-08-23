//
//  PageDataReqModel.h
//  LaiFengHui_App
//
//  Created by PF Z on 2018/8/23.
//  Copyright © 2018年 zengPengFei. All rights reserved.
//

#import <Foundation/Foundation.h>

//请求分页数据的模型
typedef enum {
    PageDataReqType_Get,
    PageDataReqType_POST,
    
}PageDataReqType;


@interface PageDataReqModel : NSObject

//请求参数
@property (nonatomic,copy) NSString *requestUrl;    //请求地址
@property (nonatomic,assign) PageDataReqType requestType;   //请求类型，get或者post

@property (nonatomic,assign) int offset;        //offset
@property (nonatomic,assign)   int   limit;         //页容量（默认10）
@property (nonatomic,copy) NSString *order;         //根据何字段排序
@property (nonatomic,copy) NSString *sort;          //排序方式（ASC：顺序，DESC：倒序）
@property (nonatomic,assign) BOOL enableJson;       //是否以JSon格式提交参数,否则以表单

//对后台返回的数据对象进行处理，返回分页数组
-(NSArray *)getPageDataListArrFromResponseObj:(NSDictionary *)responseObj;

//检查返回的数据是否正确
-(BOOL)checkData:(NSDictionary *)dataDic;

//获取分页参数
-(NSDictionary *)getParamDic;


@end
