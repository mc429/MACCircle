//
//  MACImageListView.h
//  MACCircle
//
//  Created by Marco on 2018/12/24.
//  Copyright © 2018年 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MACCircleModel;

@interface MACImageListView : UIView
@property (nonatomic,strong) MACCircleModel *circleModel;


@end

@interface MACImageView : UIImageView

// 点击朋友圈的小图
@property (nonatomic, copy) void (^tapSmallView)(MACImageView *imageView);

@end

NS_ASSUME_NONNULL_END
