//
//  MACMenuView.h
//  MACCircle
//
//  Created by Marco on 2018/12/26.
//  Copyright © 2018年 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MACCircleModel;

NS_ASSUME_NONNULL_BEGIN

@interface MACMenuView : UIView

@property (nonatomic,assign)BOOL show;

// 赞
@property (nonatomic, copy) void (^likeMoment)(void);
// 评论
@property (nonatomic, copy) void (^commentMoment)(void);
//点击了评论按钮
@property (nonatomic,copy) void (^clickMoment)(void);
//评论的model
@property (nonatomic,strong)MACCircleModel *circleModel;

@end

NS_ASSUME_NONNULL_END
