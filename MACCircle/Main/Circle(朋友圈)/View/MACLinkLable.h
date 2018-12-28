//
//  MACLinkLable.h
//  MACCircle
//
//  Created by Marco on 2018/12/26.
//  Copyright © 2018年 Marco. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MACLinkLable : NSObject
// 获取linkLabel
MLLinkLabel *MACLinkLabel(void);
// 获取富文本
NSMutableAttributedString *MLLinkLabelAttributedText(id object);
@end

NS_ASSUME_NONNULL_END
