//
//  MACBaseTVC.h
//  NavTestForMarco
//
//  Created by Marco on 2018/12/19.
//  Copyright © 2018年 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewController+MCT.h"
NS_ASSUME_NONNULL_BEGIN

@interface MACBaseTVC : UITableViewController
/**
 点击空白处取消编辑状态
 */
- (void)addViewEndEditTap;

/**
 结束编辑
 */
- (void)endViewEditing;
@end

NS_ASSUME_NONNULL_END
