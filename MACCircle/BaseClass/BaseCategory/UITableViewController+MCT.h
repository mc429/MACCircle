//
//  UITableViewController+MCT.h
//  NavTestForMarco
//
//  Created by Marco on 2018/12/11.
//  Copyright © 2018年 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewController (MCT)
@property (nonatomic, assign) IBInspectable BOOL hbd_blackBarStyle;

/**
 导航栏样式
 */
@property (nonatomic, assign) UIBarStyle hbd_barStyle;

/**
 导航背景颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *hbd_barTintColor;

/**
 导航栏背景图片
 如果使用图片来设置背景，并且希望带有透明度，使用带有透明度的图片即可。
 */
@property (nonatomic, strong) IBInspectable UIImage *hbd_barImage;

/**
 导航栏按钮颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *hbd_tintColor;

/**
 导航栏标题属性
 */
@property (nonatomic, strong) NSDictionary *hbd_titleTextAttributes;

/**
 导航栏背景透明度
 */
@property (nonatomic, assign) IBInspectable float hbd_barAlpha;

/**
 是否隐藏导航栏
 hbd_barHidden 并不真正隐藏导航栏，只是把它变透明了，当然事件是可以穿透的，也正因为并不真正隐藏导航栏，才可以在导航栏有无之间平滑而优雅地切换
 */
@property (nonatomic, assign) IBInspectable BOOL hbd_barHidden;

/**
 是否隐藏导航栏下面的阴影
 */
@property (nonatomic, assign) IBInspectable BOOL hbd_barShadowHidden;

/**
 当前页面是否影响右滑返回，以及通过UINavigationBar的返回按钮返回，默认是yYES
 */
@property (nonatomic, assign) IBInspectable BOOL hbd_backInteractive;

/**
 当前界面是否可以右滑返回，默认是YES
 */
@property (nonatomic, assign) IBInspectable BOOL hbd_swipeBackEnabled;

// computed
@property (nonatomic, assign, readonly) float hbd_computedBarShadowAlpha;
@property (nonatomic, strong, readonly) UIColor *hbd_computedBarTintColor;
@property (nonatomic, strong, readonly) UIImage *hbd_computedBarImage;

- (void)hbd_setNeedsUpdateNavigationBar;
- (void)hbd_setNeedsUpdateNavigationBarAlpha;
- (void)hbd_setNeedsUpdateNavigationBarColorOrImage;
- (void)hbd_setNeedsUpdateNavigationBarShadowAlpha;
@end

NS_ASSUME_NONNULL_END
