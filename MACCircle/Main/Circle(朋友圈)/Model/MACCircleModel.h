//
//  MACCircleModel.h
//  MACCircle
//
//  Created by Marco on 2018/12/24.
//  Copyright © 2018年 Marco. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MACCircleModel : NSObject
// 正文
@property (nonatomic,copy) NSString *text;
// 发布位置
@property (nonatomic,copy) NSString *location;
// 发布者名字
@property (nonatomic,copy) NSString *userName;
// 发布者头像路径[本地路径]
@property (nonatomic,copy) NSString *userThumbPath;
// 赞的人[逗号隔开的字符串]
@property (nonatomic,copy) NSString *praiseNameList;
// 单张图片的宽度
@property (nonatomic,assign) float  singleWidth;
// 单张图片的高度
@property (nonatomic,assign) float singleHeight;
// 图片数量
@property (nonatomic,assign) NSInteger fileCount;
// 发布时间戳
@property (nonatomic,assign) long long time;
// 显示'全文'/'收起'
@property (nonatomic,assign) BOOL isFullText;
// 是否已经点赞
@property (nonatomic,assign) BOOL isPraise;
// 评论集合
@property (nonatomic,strong) NSArray *commentList;
// Moment对应cell高度
@property (nonatomic,assign) float rowHeight;

/**
 在外部是否关闭评论的按钮
 */
@property (nonatomic,assign)BOOL isHidenMenu;

@end

NS_ASSUME_NONNULL_END
