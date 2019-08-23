//
//  CommonReqTableView.m
//  ZPFRequestKit
//
//  Created by fcar on 2019/8/22.
//  Copyright © 2019 fcar. All rights reserved.
//

#import "CommonReqTableView.h"



@implementation CommonReqTableView


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self=[super initWithFrame:frame style:style];
    if (self) {
        
        //iOS11适配
        if (@available(iOS 11.0, *)) {
            UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            self.estimatedRowHeight = 0;
            self.estimatedSectionHeaderHeight = 0;
            self.estimatedSectionFooterHeight = 0;
        }
        
        self.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        self.showsVerticalScrollIndicator=NO;
        
    }
    
    return self;
}

/**
 同时识别多个手势
 
 @param gestureRecognizer gestureRecognizer description
 @param otherGestureRecognizer otherGestureRecognizer description
 @return return value description
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return self.enableRecognizeMultiGestureRecognizer;
}



-(void)setContentInset:(UIEdgeInsets)contentInset
{
    [super setContentInset:contentInset];
    
    if (self.mj_header) {
        self.mj_header.ignoredScrollViewContentInsetTop=contentInset.top;
    }
    
}


@end
