//
//  LoadingMoreFooter.m
//  FCar_KaBaYiJia
//
//  Created by fcar on 2019/7/15.
//  Copyright © 2019 fcar. All rights reserved.
//

#import "LoadingMoreTableFooter.h"

@implementation LoadingMoreTableFooter
{
    UILabel *lab;
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
    
    lab=[[UILabel alloc] init];
    
    [self.contentView addSubview:lab];
  
    lab.font=[UIFont systemFontOfSize:14.0];
    lab.textColor=[UIColor whiteColor];
    lab.text=@"正在加载中";
    [lab sizeToFit];
}

-(void)layoutSubviews
{
    lab.center=CGPointMake(self.contentView.bounds.size.width/2.0, self.contentView.bounds.size.height/2.0);
}

+(CGFloat)loadingMoreFooterHeight
{
    return 40;
}


@end
