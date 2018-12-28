//
//  MACCircleCell.h
//  MACCircle
//
//  Created by Marco on 2018/12/24.
//  Copyright © 2018年 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MACImageListView.h"
#import "MACMenuView.h"
NS_ASSUME_NONNULL_BEGIN

@class MACCircleModel;
@class MACCommentModel;
@protocol MomentCellDelegate;
@interface MACCircleCell : UITableViewCell <MLLinkLabelDelegate>
// 头像
@property (nonatomic, strong) UIImageView *headImageView;
// 名称
@property (nonatomic, strong) UILabel *nameLab;
// 时间
@property (nonatomic, strong) UILabel *timeLab;
// 位置
@property (nonatomic, strong) UILabel *locationLab;
// 时间
@property (nonatomic, strong) UIButton *deleteBtn;
// 全文
@property (nonatomic, strong) UIButton *showAllBtn;
// 内容
@property (nonatomic, strong) MLLinkLabel *linkLabel;
// 图片
@property (nonatomic, strong) MACImageListView *imageListView;
// 赞和评论视图
@property (nonatomic, strong) UIView *commentView;
// 赞和评论视图背景
@property (nonatomic, strong) UIImageView *bgImageView;
// 操作视图
@property (nonatomic, strong) MACMenuView *menuView;

// 动态
@property (nonatomic, strong) MACCircleModel *moment;
// 代理
@property (nonatomic, assign) id<MomentCellDelegate> delegate;


@end

@protocol MomentCellDelegate <NSObject>

@optional

// 点击用户头像
- (void)didClickProfile:(MACCircleCell *)cell;
// 删除
- (void)didDeleteMoment:(MACCircleCell *)cell;
// 点赞
- (void)didLikeMoment:(MACCircleCell *)cell;
// 评论
- (void)didAddComment:(MACCircleCell *)cell;
// 查看全文/收起
- (void)didSelectFullText:(MACCircleCell *)cell;
// 选择评论
- (void)didSelectComment:(MACCommentModel *)comment;
// 点击高亮文字
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText;
//点击评论按钮
-(void)didClickMoment:(MACCircleCell *)cell;

@end

@interface CommentLable : UIView <MLLinkLabelDelegate>
// 内容Label
@property (nonatomic,strong) MLLinkLabel *linkLabel;
// 评论
@property (nonatomic,strong) MACCommentModel *comment;
// 点击评论高亮内容
@property (nonatomic, copy) void (^didClickLinkText)(MLLink *link , NSString *linkText);
// 点击评论
@property (nonatomic, copy) void (^didClickText)(MACCommentModel *comment);

@end

NS_ASSUME_NONNULL_END
