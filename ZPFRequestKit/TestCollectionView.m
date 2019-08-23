//
//  TestCollectionView.m
//  ZPFRequestKit
//
//  Created by fcar on 2019/8/23.
//  Copyright © 2019 fcar. All rights reserved.
//

#import "TestCollectionView.h"
#import "RequestCellDelegates.h"

@interface TestCollectionCell : UICollectionViewCell<ReqCollectionViewCell>

@end

@implementation TestCollectionCell

//设置Cell模型
-(void)setItemCellModel:(id)model
{
    self.contentView.backgroundColor=[UIColor orangeColor];
}

//获取Cell高度
+(CGSize)ItemCellSize:(id)model
{
    return CGSizeMake(100, 100);
}

//获取绑定模型的类
+(Class)ItemCellModelClass
{
    return [NSObject class];
}

//CELL被点击事件
-(void)cellDidSelected
{
    NSLog(@"");
}


@end



@implementation TestCollectionView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pageModel.requestUrl=@"http://app.astrotravelgo.com/Goods/show_list";
        
        self.backgroundColor=[UIColor blueColor];
        self.collectionView.backgroundColor=[UIColor grayColor];
        self.dataType=RequestDataType_ARR_OBJ;
    }
    return self;
}

-(Class)preferCellClassForModel:(id)model
{
    return [TestCollectionCell class];
}

-(NSDictionary *)requestParamDic
{
    return nil;
}

@end
