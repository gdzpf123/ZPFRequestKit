//
//  ViewController.m
//  ZPFRequestKit
//
//  Created by fcar on 2019/8/22.
//  Copyright © 2019 fcar. All rights reserved.
//

#import "ViewController.h"
#import "TestListView.h"
#import "TestCollectionView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    TestListView *view=[[TestListView alloc] init];
//    [self.view addSubview:view];
//    view.frame=self.view.bounds;
//
//    [view regetData];
    
    TestCollectionView *view=[[TestCollectionView alloc] init];
    [self.view addSubview:view];
    view.frame=self.view.bounds;
    
    [view regetData];

}


@end
