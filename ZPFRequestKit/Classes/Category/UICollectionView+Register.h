//
//  UICollectionView+Register.h
//  ZPFRequestKit
//
//  Created by fcar on 2019/8/22.
//  Copyright © 2019 fcar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (Register)

-(UICollectionViewCell *)getRegistedCell:(Class)cellCls indexPath:(NSIndexPath *)indexPath;
-(UICollectionReusableView *)getRegistedHeader:(Class)headCls indexPath:(NSIndexPath *)indexPath;
-(UICollectionReusableView *)getRegistedFooter:(Class)footCls indexPath:(NSIndexPath *)indexPath;

@property (nonatomic,strong) NSMutableArray *registNameArr;


@end

NS_ASSUME_NONNULL_END
