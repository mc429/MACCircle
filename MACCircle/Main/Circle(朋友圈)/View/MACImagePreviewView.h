//
//  MACImagePreviewView.h
//  MACCircle
//
//  Created by Marco on 2018/12/24.
//  Copyright © 2018年 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MACImagePreviewView : UIView <UIScrollViewDelegate>

// 横向滚动视图
@property (nonatomic,strong) UIScrollView *scrollView;
// 页码指示
@property (nonatomic,strong) UIPageControl *pageControl;
// 页码数目
@property (nonatomic,assign) NSInteger pageNum;
// 页码索引
@property (nonatomic,assign) NSInteger pageIndex;

@end

@interface MACScrollView : UIScrollView <UIScrollViewDelegate>
// 显示的大图
@property (nonatomic,strong) UIImageView *imageView;
// 原始Frame
@property (nonatomic,assign) CGRect originRect;
// 过程Frame
@property (nonatomic,assign) CGRect contentRect;
// 图片
@property (nonatomic,strong) UIImage *image;
// 点击大图(关闭预览)
@property (nonatomic, copy) void (^tapBigView)(MACScrollView *scrollView);
// 长按大图
@property (nonatomic, copy) void (^longPressBigView)(MACScrollView *scrollView);

// 更新Frame
- (void)updateOriginRect;

@end

NS_ASSUME_NONNULL_END
