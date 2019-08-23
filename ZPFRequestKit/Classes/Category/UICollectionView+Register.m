//
//  UICollectionView+Register.m
//  ZPFRequestKit
//
//  Created by fcar on 2019/8/22.
//  Copyright © 2019 fcar. All rights reserved.
//

#import "UICollectionView+Register.h"
#import <objc/runtime.h>

static NSString *arrKey = @"arrKey";


@implementation UICollectionView (Register)


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


-(UICollectionViewCell *)getRegistedCell:(Class)cellCls indexPath:(NSIndexPath *)indexPath
{
    NSString *name=NSStringFromClass(cellCls);
    name=[name stringByAppendingString:@"_Cell"];
    if (![self.registNameArr containsObject:name]) {
        [self registerClass:cellCls forCellWithReuseIdentifier:name];
        
        [self.registNameArr addObject:name];
    }
    
    return [self dequeueReusableCellWithReuseIdentifier:name forIndexPath:indexPath];
}

-(UICollectionReusableView *)getRegistedHeader:(Class)headCls indexPath:(NSIndexPath *)indexPath
{
    NSString *name=NSStringFromClass(headCls);
    name=[name stringByAppendingString:@"_Header"];
    if (![self.registNameArr containsObject:name]) {
        [self registerClass:headCls forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:name];
        [self.registNameArr addObject:name];
    }
    
    return [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:name forIndexPath:indexPath];
}

-(UICollectionReusableView *)getRegistedFooter:(Class)footCls indexPath:(NSIndexPath *)indexPath
{
    NSString *name=NSStringFromClass(footCls);
    name=[name stringByAppendingString:@"_Footer"];
    if (![self.registNameArr containsObject:name]) {
        [self registerClass:footCls forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:name];
        [self.registNameArr addObject:name];
    }
    
    return [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:name forIndexPath:indexPath];
}




@end
