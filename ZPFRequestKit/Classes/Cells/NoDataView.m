//
//  NoDataView.m
//  ZPFRequestKit
//
//  Created by fcar on 2019/8/22.
//  Copyright © 2019 fcar. All rights reserved.
//

#import "NoDataView.h"

@implementation NoDataView
{
    UILabel *lab;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame=CGRectMake(0, 0, 320, 300);
        [self setUP];
    }
    return self;
}

-(void)setUP
{
    lab=[[UILabel alloc] init];
    [self addSubview:lab];
    
    lab.font=[UIFont systemFontOfSize:14.0];
    lab.textColor=[UIColor whiteColor];
    lab.text=@"暂无数据";
    [lab sizeToFit];
    
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    lab.center=CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
}



@end
