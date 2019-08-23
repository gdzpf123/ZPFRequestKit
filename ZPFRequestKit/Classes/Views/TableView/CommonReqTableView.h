//
//  CommonReqTableView.h
//  ZPFRequestKit
//
//  Created by fcar on 2019/8/22.
//  Copyright © 2019 fcar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonReqTableView : UITableView<UIGestureRecognizerDelegate>

//是否支持 同时识别多个手势 ，默认为不支持
@property (nonatomic,assign) BOOL enableRecognizeMultiGestureRecognizer;


@end

NS_ASSUME_NONNULL_END
