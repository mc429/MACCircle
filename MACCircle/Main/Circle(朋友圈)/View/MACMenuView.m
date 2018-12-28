//
//  MACMenuView.m
//  MACCircle
//
//  Created by Marco on 2018/12/26.
//  Copyright © 2018年 Marco. All rights reserved.
//

#import "MACMenuView.h"
#import <UUButton.h>
#import "MACCircleModel.h"
@interface MACMenuView ()
@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UIButton *menuBtn;
@end

@implementation MACMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _show = NO;
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI{

    // 菜单容器视图
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(MACOperateWidth-MACOperateBtnWidth, 0, MACOperateWidth-MACOperateBtnWidth,MACOperateHeight )];
    view.backgroundColor = [UIColor colorWithRed:70.0/255.0 green:74.0/255.0 blue:75.0/255.0 alpha:1.0];
    view.layer.cornerRadius = 4.0;
    view.layer.masksToBounds = YES;
    // 点赞
    UUButton *btn = [[UUButton alloc] initWithFrame:CGRectMake(0, 0, view.width/2, MACOperateHeight)];
    btn.backgroundColor = [UIColor clearColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    btn.spacing = 3;
    [btn setTitle:@"赞" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"moment_like"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(likeClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    // 分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(btn.right-5, 8, 0.5, MACOperateHeight-16)];
    line.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    [view addSubview:line];
    // 评论
    btn = [[UUButton alloc] initWithFrame:CGRectMake(line.right, 0, btn.width, MACOperateHeight)];
    btn.backgroundColor = [UIColor clearColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    btn.spacing = 3;
    [btn setTitle:@"评论" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"moment_comment"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    self.menuView = view;
    [self addSubview:self.menuView];
    // 菜单操作按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(MACOperateWidth-MACOperateBtnWidth, 0, MACOperateBtnWidth, MACOperateHeight)];
    [button setImage:[UIImage imageNamed:@"moment_operate"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"moment_operate_hl"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(menuClick) forControlEvents:UIControlEventTouchUpInside];
    self.menuBtn = button;
    [self addSubview:self.menuBtn];
}

#pragma mark - 显示/不显示
- (void)setShow:(BOOL)show
{
    _show = show;
    CGFloat menu_left = MACOperateWidth-MACOperateBtnWidth;
    CGFloat menu_width = 0;
    if (_show) {
        menu_left = 0;
        menu_width = MACOperateWidth-MACOperateBtnWidth;
    }
    self.menuView.width = menu_width;
    self.menuView.left = menu_left;
}

#pragma mark - 事件
- (void)menuClick
{
    _show = !_show;
    _circleModel.isHidenMenu= _show;
    
    if (self.clickMoment) {
        self.clickMoment();
    }
    
    CGFloat menu_left = MACOperateWidth-MACOperateBtnWidth;
    CGFloat menu_width = 0;
    if (_show) {
        menu_left = 0;
        menu_width = MACOperateWidth-MACOperateBtnWidth;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.menuView.width = menu_width;
        self.menuView.left = menu_left;
    }];
}
//点击评论
- (void)likeClick
{
    if (self.likeMoment) {
        self.likeMoment();
    }
    
     _show = !_show;
    CGFloat menu_left = MACOperateWidth-MACOperateBtnWidth;
    CGFloat menu_width = 0;
    [UIView animateWithDuration:0.2 animations:^{
        self.menuView.width = menu_width;
        self.menuView.left = menu_left;
    }];
}

//点赞
- (void)commentClick
{
    if (self.commentMoment) {
        self.commentMoment();
    }
    
    _show = !_show;
    CGFloat menu_left = MACOperateWidth-MACOperateBtnWidth;
    CGFloat menu_width = 0;
    [UIView animateWithDuration:0.2 animations:^{
        self.menuView.width = menu_width;
        self.menuView.left = menu_left;
    }];
}

-(void)setCircleModel:(MACCircleModel *)circleModel{
    _circleModel = circleModel;
    
}


@end
