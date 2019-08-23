//
//  NoMoreDataCell.m
//  ZPFRequestKit
//
//  Created by fcar on 2019/8/22.
//  Copyright © 2019 fcar. All rights reserved.
//

#import "NoMoreDataTableFooter.h"

@implementation NoMoreDataTableFooter
{
    UILabel *titleLab;
}


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupSubViews];
    }
    return self;
}

-(void)setupSubViews
{
    
    titleLab=[[UILabel alloc] init];
    
    [self.contentView addSubview:titleLab];
    
    titleLab.font=[UIFont systemFontOfSize:14.0];
    titleLab.textColor=[UIColor whiteColor];
    titleLab.textAlignment=NSTextAlignmentCenter;
    titleLab.text=@"没有更多了";
    [titleLab sizeToFit];
    
    
}

-(void)layoutSubviews
{
    titleLab.center=CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
}

//获取Footer高度
+(CGFloat)noMoreFooterHeight
{
    return 40;
}

@end
