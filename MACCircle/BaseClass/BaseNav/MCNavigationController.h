//
//  MCNavigationController.h
//  NavTestForMarco
//
//  Created by Marco on 2018/11/22.
//  Copyright © 2018年 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCNavigationController : UINavigationController

- (void)updateNavigationBarForViewController:(UIViewController *)vc;
- (void)updateNavigationBarAlphaForViewController:(UIViewController *)vc;
- (void)updateNavigationBarColorOrImageForViewController:(UIViewController *)vc;
- (void)updateNavigationBarShadowIAlphaForViewController:(UIViewController *)vc;

@end

@interface  UINavigationController(UINavigationBar) <UINavigationBarDelegate>

@property (nonatomic,strong)UIButton *leftBtn;

@end

NS_ASSUME_NONNULL_END
