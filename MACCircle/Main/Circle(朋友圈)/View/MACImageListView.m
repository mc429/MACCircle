//
//  MACImageListView.m
//  MACCircle
//
//  Created by Marco on 2018/12/24.
//  Copyright © 2018年 Marco. All rights reserved.
//

#import "MACImageListView.h"
#import "MACImagePreviewView.h"
#import "MACCircleModel.h"

@interface MACImageListView ()
// 图片视图数组
@property (nonatomic, strong) NSMutableArray *imageViewsArray;
//点击预览后查看的大图
@property (nonatomic,strong)MACImagePreviewView *previewView;
@end

@implementation MACImageListView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        // 小图(九宫格)
        _imageViewsArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 9; i++) {
           MACImageView *imageView = [[MACImageView alloc] initWithFrame:CGRectZero];
            imageView.tag = 1000 + i;
            [imageView setTapSmallView:^(MACImageView *imageView){
                [self singleTapSmallViewCallback:imageView];
            }];
            [_imageViewsArray addObject:imageView];
            [self addSubview:imageView];
        }
        // 预览视图
        _previewView = [[MACImagePreviewView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return self;
}

/**
 内容model
 */
-(void)setCircleModel:(MACCircleModel *)circleModel{
    _circleModel= circleModel;
    
    for (MACImageView *imageView in _imageViewsArray) {
        imageView.hidden = YES;
    }
    //图片
    NSInteger count = circleModel.fileCount;
    if (count==0) {
        self.size = CGSizeZero;
        return;
    }
    
    // 更新视图数据
    _previewView.pageNum = count;
    _previewView.scrollView.contentSize = CGSizeMake(_previewView.width*count, _previewView.height);
    // 添加图片
   MACImageView *imageView = nil;
    for (int i=0; i<count; i++) {
        if (i>8) {
            return;
        }
        NSInteger yNum = i/3;//行数
        NSInteger xNum = i%3;//列数
        if (count==4) {
            yNum = i/2;
            xNum = i%2;
        }
        CGFloat imageX = xNum*(MACImageWidth+MACImagePadding);
        CGFloat imageY = yNum*(MACImageWidth+MACImagePadding);
        CGRect frame = CGRectMake(imageX, imageY, MACImageWidth, MACImageWidth);
        //单张图片需计算实际显示size
        if (count==1) {
            CGSize singleSize = [Utility getSingleSize:CGSizeMake(circleModel.singleWidth, circleModel.singleHeight)];
            frame = CGRectMake(0, 0, singleSize.width, singleSize.height);
        }
        imageView = [self viewWithTag:1000+i];
        imageView.hidden = NO;
        imageView.frame = frame;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"WechatIMG%d",(int)i]];
       // imageView.image = [UIImage imageNamed:@"text_one"];
        
    }
    self.width = MACTextWidth;
    self.height = imageView.bottom;
}

#pragma mark - 小图单击
- (void)singleTapSmallViewCallback:(MACImageView *)imageView{
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    // 解除隐藏
    [window addSubview:_previewView];
    //将view调整到父视图的最上面
    [window bringSubviewToFront:_previewView];
    
    // 清空
    [_previewView.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 添加子视图
    NSInteger index = imageView.tag-1000;
    NSInteger count = _circleModel.fileCount;
    CGRect convertRect;
    if (count == 1) {
        [_previewView.pageControl removeFromSuperview];
    }
    for (NSInteger i = 0; i < count; i ++)
    {
        // 转换Frame
        MACImageView *pImageView = (MACImageView *)[self viewWithTag:1000+i];
        convertRect = [[pImageView superview] convertRect:pImageView.frame toView:window];
        // 添加
        MACScrollView *scrollView = [[MACScrollView alloc] initWithFrame:CGRectMake(i*_previewView.width, 0, _previewView.width, _previewView.height)];
        scrollView.tag = 100+i;
        scrollView.maximumZoomScale = 2.0;
        scrollView.image = pImageView.image;
        scrollView.contentRect = convertRect;
        // 单击
        [scrollView setTapBigView:^(MACScrollView *scrollView){
            [self singleTapBigViewCallback:scrollView];
        }];
        // 长按
        [scrollView setLongPressBigView:^(MACScrollView *scrollView){
            
            [self longPresssBigViewCallback:scrollView];
            
        }];
        [_previewView.scrollView addSubview:scrollView];
        if (i == index) {
            [UIView animateWithDuration:0.3 animations:^{
                self->_previewView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
                self->_previewView.pageControl.hidden = NO;
                [scrollView updateOriginRect];
            }];
        } else {
            [scrollView updateOriginRect];
        }
    }
    // 更新offset
    CGPoint offset = _previewView.scrollView.contentOffset;
    offset.x = index *Screen_width;
    _previewView.scrollView.contentOffset = offset;
    
}

#pragma mark - 大图单击||长按
- (void)singleTapBigViewCallback:(MACScrollView *)scrollView
{
    [UIView animateWithDuration:0.3 animations:^{
        self->_previewView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self->_previewView.pageControl.hidden = YES;
        scrollView.contentRect = scrollView.contentRect;
        scrollView.zoomScale = 1.0;
    } completion:^(BOOL finished) {
        [self->_previewView removeFromSuperview];
    }];
}

- (void)longPresssBigViewCallback:(MACScrollView *)scrollView
{
    
}
@end

@implementation MACImageView
#pragma mark - ------------------ 单个小图显示视图 ------------------
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds  = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.contentScaleFactor = [[UIScreen mainScreen] scale];
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCallback:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)singleTapGestureCallback:(UIGestureRecognizer *)gesture
{
    if (self.tapSmallView) {
        self.tapSmallView(self);
    }
}


@end
