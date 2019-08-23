//
//  UITableView+Register.h
//  ZPFRequestKit
//
//  Created by fcar on 2019/8/22.
//  Copyright © 2019 fcar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Register)

-(UITableViewCell *)getRegistedCell:(Class)cellCls;
-(UITableViewHeaderFooterView *)getRegistedHeader:(Class)headCls;
-(UITableViewHeaderFooterView *)getRegistedFooter:(Class)footCls;

@property (nonatomic,strong) NSMutableArray *registNameArr;

@end

NS_ASSUME_NONNULL_END
