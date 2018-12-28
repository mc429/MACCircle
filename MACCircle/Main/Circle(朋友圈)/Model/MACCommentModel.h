//
//  MACCommentModel.h
//  MACCircle
//
//  Created by Marco on 2018/12/24.
//  Copyright © 2018年 Marco. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MACCommentModel : NSObject
// 正文
@property (nonatomic,copy) NSString *text;
// 发布者名字
@property (nonatomic,copy) NSString *userName;
// 发布时间戳
@property (nonatomic,assign) long long time;
// 关联动态的PK
@property (nonatomic,assign) int pk;

@end

NS_ASSUME_NONNULL_END
