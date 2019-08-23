//
//  LoadingMoreCollectionFooter.m
//  ZPFRequestKit
//
//  Created by fcar on 2019/8/22.
//  Copyright © 2019 fcar. All rights reserved.
//

#import "LoadingMoreCollectionFooter.h"

@implementation LoadingMoreCollectionFooter
{
    UILabel *lab;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
        
    }
    return self;
}

-(void)setupSubViews
{
    
    lab=[[UILabel alloc] init];
    
    [self addSubview:lab];
    
    lab.font=[UIFont systemFontOfSize:14.0];
    lab.textColor=[UIColor whiteColor];
    lab.text=@"正在加载中";
    [lab sizeToFit];
}

-(void)layoutSubviews
{
    lab.center=CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
}

+(CGFloat)loadingMoreFooterHeight
{
    return 40;
}


@end
