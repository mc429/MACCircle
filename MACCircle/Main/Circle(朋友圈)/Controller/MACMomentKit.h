//
//  MACMomentKit.h
//  MACCircle
//
//  Created by Marco on 2018/12/22.
//  Copyright © 2018年 Marco. All rights reserved.
//

#ifndef MACMomentKit_h
#define MACMomentKit_h

/**
 屏幕宽
 */
#define Screen_width   [UIScreen mainScreen].bounds.size.width

/**
 屏幕高
 */
#define Screen_height  [UIScreen mainScreen].bounds.size.height

// 图片间距
#define MACImagePadding       5
// 图片宽度
#define MACImageWidth         75

// 头像视图的宽、高
#define MACFaceWidth          40
// 操作按钮的宽度
#define MACOperateBtnWidth    30
// 操作视图的高度
#define MACOperateHeight      38
// 操作视图的高度
#define MACOperateWidth       200
// 名字视图高度
#define MACNameLabelH         20
// 时间视图高度
#define MACTimeLabelH         15
// 顶部和底部的留白
#define MACBlank              15
// 右侧留白
#define MACRightMargin        15
// 正文字体
#define MACTextFont           [UIFont systemFontOfSize:15.0]
// 内容视图宽度
#define MACTextWidth          (Screen_width-60-25)
// 评论字体
#define MACComTextFont        [UIFont systemFontOfSize:14.0]
// 评论高亮字体
#define MACComHLTextFont      [UIFont boldSystemFontOfSize:14.0]
// 主色调高亮颜色
#define MACTextColor        [UIColor colorWithRed:0.28 green:0.35 blue:0.54 alpha:1.0]
// 正文高亮颜色
#define MACLinkTextColor      [UIColor colorWithRed:0.09 green:0.49 blue:0.99 alpha:1.0]
// 按住背景颜色
#define MACBgColor          [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]
// 全文/收起按钮高度
#define MACMoreLabHeight      20
// 全文/收起按钮宽度
#define MACMoreLabWidth       60
// 视图之间的间距
#define MACPaddingValue       8
// 评论赞视图气泡的尖尖高度
#define MACArrowHeight        5

#define InputTextHeight       40

#endif /* MACMomentKit_h */
