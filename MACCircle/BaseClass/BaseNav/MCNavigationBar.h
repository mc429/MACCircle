//
//  MCNavigationBar.h
//  NavTestForMarco
//
//  Created by Marco on 2018/11/22.
//  Copyright © 2018年 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCNavigationBar : UINavigationBar
@property (nonatomic, strong, readonly) UIImageView *shadowImageView;
@property (nonatomic, strong, readonly) UIVisualEffectView *fakeView;
@property (nonatomic, strong, readonly) UIImageView *backgroundImageView;

@end

NS_ASSUME_NONNULL_END
