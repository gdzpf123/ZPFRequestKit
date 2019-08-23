//
//  RequestCellDelegates.h
//  ZPFRequestKit
//
//  Created by fcar on 2019/8/22.
//  Copyright © 2019 fcar. All rights reserved.
//

#ifndef RequestCellDelegates_h
#define RequestCellDelegates_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    RequestDataType_ARR_ARR,
    RequestDataType_ARR_OBJ,
}RequestDataType;

@protocol ReqTableViewCell <NSObject>

@required
//设置Cell模型
-(void)setItemCellModel:(id)model;

//获取Cell高度
+(CGFloat)ItemCellHeight:(id)model;

//获取绑定模型的类
+(Class)ItemCellModelClass;

//CELL被点击事件
-(void)cellDidSelected;

@end

//Collection Cell 实现代理
@protocol ReqCollectionViewCell <NSObject>

@required
//设置Cell模型
-(void)setItemCellModel:(id)model;

//获取Cell尺寸
+(CGSize)ItemCellSize:(id)model;

//获取绑定模型的类
+(Class)ItemCellModelClass;

//CELL被点击事件
-(void)cellDidSelected;

@end

@protocol ReqLoadingMoreFooter <NSObject>

@required
//获取Footer高度
+(CGFloat)loadingMoreFooterHeight;

@end

@protocol ReqNoMoreFooter <NSObject>

@required
//获取Footer高度
+(CGFloat)noMoreFooterHeight;

@end

@protocol ReqNoDataView <NSObject>

@required
//获取Footer高度
+(CGFloat)noDataViewHeight;

@end





#endif /* RequestCellDelegates_h */
