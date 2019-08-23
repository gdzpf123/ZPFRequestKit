//
//  UITableView+Register.m
//  ZPFRequestKit
//
//  Created by fcar on 2019/8/22.
//  Copyright © 2019 fcar. All rights reserved.
//

#import "UITableView+Register.h"
#import <objc/runtime.h>

static NSString *arrKey = @"arrKey";


@implementation UITableView (Register)

-(void)setRegistNameArr:(NSMutableArray *)registNameArr
{
    objc_setAssociatedObject(self, &arrKey, registNameArr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSMutableArray *)registNameArr
{
    NSMutableArray *arr = objc_getAssociatedObject(self, &arrKey);
    if (arr == nil) {
        arr=[NSMutableArray array];
        [self setRegistNameArr:arr];
    }
    
    return arr;
}


-(UITableViewCell *)getRegistedCell:(Class)cellCls
{
    NSString *name=NSStringFromClass(cellCls);
    name=[name stringByAppendingString:@"_Cell"];
    if (![self.registNameArr containsObject:name]) {
        [self registerClass:cellCls forCellReuseIdentifier:name];
        [self.registNameArr addObject:name];
    }
    
    return [self dequeueReusableCellWithIdentifier:name];
}

-(UITableViewHeaderFooterView *)getRegistedHeader:(Class)headCls
{
    NSString *name=NSStringFromClass(headCls);
    name=[name stringByAppendingString:@"_Header"];
    if (![self.registNameArr containsObject:name]) {
        [self registerClass:headCls forHeaderFooterViewReuseIdentifier:name];
        [self.registNameArr addObject:name];
    }
    
    return [self dequeueReusableHeaderFooterViewWithIdentifier:name];
}

-(UITableViewHeaderFooterView *)getRegistedFooter:(Class)footCls
{
    NSString *name=NSStringFromClass(footCls);
    name=[name stringByAppendingString:@"_Footer"];
    if (![self.registNameArr containsObject:name]) {
        [self registerClass:footCls forHeaderFooterViewReuseIdentifier:name];
        [self.registNameArr addObject:name];
    }
    
    return [self dequeueReusableHeaderFooterViewWithIdentifier:name];
}

@end
