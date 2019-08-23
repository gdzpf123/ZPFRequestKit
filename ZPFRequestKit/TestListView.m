//
//  TestListView.m
//  ZPFRequestKit
//
//  Created by fcar on 2019/8/22.
//  Copyright © 2019 fcar. All rights reserved.
//

#import "TestListView.h"
#import "RequestCellDelegates.h"

@interface TestCell : UITableViewCell<ReqTableViewCell>

@end

@implementation TestCell

//设置Cell模型
-(void)setItemCellModel:(id)model
{
    self.contentView.backgroundColor=[UIColor orangeColor];
}

//获取Cell高度
+(CGFloat)ItemCellHeight:(id)model
{
    return 150;
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


@implementation TestListView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pageModel.requestUrl=@"http://app.astrotravelgo.com/Goods/show_list";
    
        self.backgroundColor=[UIColor blueColor];
        self.tableView.backgroundColor=[UIColor grayColor];
    }
    return self;
}

-(Class)preferCellClassForModel:(id)model
{
    return [TestCell class];
}

-(NSDictionary *)requestParamDic
{
    return @{@"class_id":@"5ec8ed2f-c1aa-fc47-554b-19546e0c968d"};
}

@end
