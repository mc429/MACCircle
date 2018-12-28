//
//  MACLinkLable.m
//  MACCircle
//
//  Created by Marco on 2018/12/26.
//  Copyright © 2018年 Marco. All rights reserved.
//

#import "MACLinkLable.h"
#import "MACCommentModel.h"
@implementation MACLinkLable

MLLinkLabel *MACLinkLabel() {
    
    MLLinkLabel *_linkLabel = [MLLinkLabel new];
    _linkLabel.lineBreakMode = NSLineBreakByWordWrapping;//设置文字过长时的显示格式，以字符为显示单位显示，后面部分省略不显示
    _linkLabel.textColor = [UIColor blackColor];
    _linkLabel.font = MACTextFont;
    _linkLabel.numberOfLines = 0;
    _linkLabel.linkTextAttributes = @{NSForegroundColorAttributeName:MACTextColor};
    _linkLabel.activeLinkTextAttributes = @{NSForegroundColorAttributeName:MACTextColor,NSBackgroundColorAttributeName:MACBgColor};
    _linkLabel.activeLinkToNilDelay = 0.3;
    return _linkLabel;
    
}

NSMutableAttributedString *MLLinkLabelAttributedText(id object){
    
    NSMutableAttributedString *attributedText = nil;
    if ([object isKindOfClass:[MACCommentModel class]])
    {
        MACCommentModel *comment = (MACCommentModel *)object;
        if (comment.pk % 2 == 0) {
            NSString *likeString  = [NSString stringWithFormat:@"Jeanne回复%@：%@",comment.userName,comment.text];
            attributedText = [[NSMutableAttributedString alloc] initWithString:likeString];
            [attributedText setAttributes:@{NSFontAttributeName:MACComHLTextFont,NSLinkAttributeName:@"Jeanne"}
                                    range:[likeString rangeOfString:@"Jeanne"]];
            [attributedText setAttributes:@{NSFontAttributeName:MACComHLTextFont,NSLinkAttributeName:comment.userName}
                                    range:[likeString rangeOfString:comment.userName]];
        } else {
            NSString *likeString  = [NSString stringWithFormat:@"%@：%@",comment.userName,comment.text];
            attributedText = [[NSMutableAttributedString alloc] initWithString:likeString];
            [attributedText setAttributes:@{NSFontAttributeName:MACComHLTextFont,NSLinkAttributeName:comment.userName}
                                    range:[likeString rangeOfString:comment.userName]];
        }
    }
    
    if ([object isKindOfClass:[NSString class]])
    {
        NSString *content = (NSString *)object;
        NSString *likeString = [NSString stringWithFormat:@"[赞] %@",content];
        attributedText = [[NSMutableAttributedString alloc] initWithString:likeString];
        NSArray *nameList = [content componentsSeparatedByString:@"，"];
        for (NSString *name in nameList) {
            [attributedText setAttributes:@{NSFontAttributeName:MACComHLTextFont,NSLinkAttributeName:name}
                                    range:[likeString rangeOfString:name]];
        }
        
        //添加'赞'的图片
        NSRange range = NSMakeRange(0, 3);
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
        textAttachment.image = [UIImage imageNamed:@"moment_like_hl"];
        textAttachment.bounds = CGRectMake(0, -3, textAttachment.image.size.width, textAttachment.image.size.height);
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
        [attributedText replaceCharactersInRange:range withAttributedString:imageStr];
    }
    return attributedText;
}

@end
