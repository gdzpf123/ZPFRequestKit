//
//  CommonReqCollectionView.m
//  ZPFRequestKit
//
//  Created by fcar on 2019/8/22.
//  Copyright © 2019 fcar. All rights reserved.
//

#import "CommonReqCollectionView.h"

@implementation CommonReqCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self=[super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.alwaysBounceVertical = YES;
    }
    return self;
}

@end
