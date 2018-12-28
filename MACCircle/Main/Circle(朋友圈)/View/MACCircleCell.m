//
//  MACCircleCell.m
//  MACCircle
//
//  Created by Marco on 2018/12/24.
//  Copyright © 2018年 Marco. All rights reserved.
//

#import "MACCircleCell.h"
#import "MACCircleModel.h"
#import "MACCommentModel.h"
#import "MACLinkLable.h"
#import "MACImageListView.h"


@interface MACCircleCell ()


@end
#pragma mark - ------------------ 动态 ------------------

// 最大高度限制
CGFloat maxLimitHeight = 0;
@implementation MACCircleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
        
    }
    return  self;
}

/**
 设置控件
 */
-(void)setUI{
  //头像
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, MACBlank, MACFaceWidth, MACFaceWidth)];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_headImageView];
    //给头像添加一个点击手势
    
    
    
    //名称
    _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(_headImageView.right+10, _headImageView.top, MACTextWidth, 20)];
    _nameLab.textColor =MACTextColor;
    _nameLab.font = [UIFont boldSystemFontOfSize:17];//字体 bold ：醒目的；雄浑的；突出的，使用后会加粗字体
    _nameLab.backgroundColor = [UIColor clearColor];
    [self addSubview:_nameLab];
    
    //内容
    _linkLabel =MACLinkLabel();
    _linkLabel.font = MACTextFont;
    _linkLabel.delegate = self;
    _linkLabel.linkTextAttributes = @{NSForegroundColorAttributeName:MACLinkTextColor};
    _linkLabel.activeLinkTextAttributes = @{NSForegroundColorAttributeName:MACLinkTextColor,NSBackgroundColorAttributeName:MACBgColor};
    [self.contentView addSubview:_linkLabel];
    
    //查看全文的按钮
    _showAllBtn = [[UIButton alloc]init];
    _showAllBtn.titleLabel.font = MACTextFont;
    _showAllBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _showAllBtn.backgroundColor = [UIColor clearColor];
    [_showAllBtn setTitle:@"全文" forState:UIControlStateNormal];
    [_showAllBtn setTitleColor:MACTextColor forState:UIControlStateNormal];
    [_showAllBtn addTarget:self action:@selector(fullTextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_showAllBtn];
    
    //图片

    _imageListView = [[MACImageListView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_imageListView];
    // 位置视图
    _locationLab = [[UILabel alloc] init];
    _locationLab.textColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.43 alpha:1.0];
    _locationLab.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:_locationLab];
    // 时间视图
    _timeLab = [[UILabel alloc] init];
    _timeLab.textColor = [UIColor colorWithRed:0.43 green:0.43 blue:0.43 alpha:1.0];
    _timeLab.font = [UIFont systemFontOfSize:13.0f];
    [self.contentView addSubview:_timeLab];
    // 删除视图
    _deleteBtn = [[UIButton alloc] init];
    _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    _deleteBtn.backgroundColor = [UIColor clearColor];
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:MACTextColor forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(deleteMoment:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteBtn];
    // 评论视图
    _bgImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_bgImageView];
    _commentView = [[UIView alloc] init];
    [self.contentView addSubview:_commentView];
    
    //点赞评论的按钮
    _menuView = [[MACMenuView alloc]initWithFrame:CGRectZero];
    __weak typeof(self) weakSelf =self;
    [_menuView setLikeMoment:^{
        if ([weakSelf.delegate respondsToSelector:@selector(didLikeMoment:)]) {
            [weakSelf.delegate didLikeMoment:weakSelf];
        }
    }];
    [_menuView setCommentMoment:^{
        if ([weakSelf.delegate respondsToSelector:@selector(didAddComment:)]) {
            [weakSelf.delegate didAddComment:weakSelf];
        }
    }];
    
    [_menuView setClickMoment:^{
        if (weakSelf.delegate &&[weakSelf.delegate respondsToSelector:@selector(didClickMoment:)]) {
            [weakSelf.delegate didClickMoment:weakSelf];
        }
        
    }];
    [self.contentView addSubview:_menuView];
    
    
    // 最大高度限制
    maxLimitHeight = _linkLabel.font.lineHeight * 6;
    
    
}


/**
 重写mmomentModel的set方法
 */
-(void)setMoment:(MACCircleModel *)moment{
    _moment = moment;
    //头像
    _headImageView.image = [UIImage imageNamed:@"head"];
    //昵称
    _nameLab.text = moment.userName;
    //内容
    _showAllBtn.hidden = YES;
    _linkLabel.hidden = YES;
    
    CGFloat bottom = _nameLab.bottom + MACPaddingValue;
    CGFloat rowHeight = 0;
    if ([moment.text length]) {
        _linkLabel.hidden = NO;
        _linkLabel.text = moment.text;
        //判断全文/收起
        CGSize attrStrSize = [_linkLabel preferredSizeWithMaxWidth:MACTextWidth];
        CGFloat labH = attrStrSize.height;
        if (labH>maxLimitHeight) {
            if (!_moment.isFullText) {
                labH = maxLimitHeight;
                [self.showAllBtn setTitle:@"全文" forState:UIControlStateNormal];
            } else {
                [self.showAllBtn setTitle:@"收起" forState:UIControlStateNormal];
            }
            _showAllBtn.hidden = NO;
        }
        _linkLabel.frame =CGRectMake(_nameLab.left, bottom, attrStrSize.width, labH);
        _showAllBtn.frame =  CGRectMake(_nameLab.left, _linkLabel.bottom + MACArrowHeight, MACMoreLabWidth, MACMoreLabHeight);
        if (_showAllBtn.hidden) {
            bottom = _linkLabel.bottom + MACPaddingValue;
        } else {
            bottom = _showAllBtn.bottom + MACPaddingValue;
        }
        
    }
    
    // 图片
    _imageListView.circleModel = moment;
    if (moment.fileCount>0) {
        _imageListView.origin = CGPointMake(_nameLab.left, bottom);
        bottom = _imageListView.bottom + MACPaddingValue;
    }
    
    //
    // 位置
    _locationLab.frame = CGRectMake(_nameLab.left, bottom, _nameLab.width, MACTimeLabelH);
    _timeLab.text = [NSString stringWithFormat:@"%@",[Utility getDateFormatByTimestamp:moment.time]];
    CGFloat textW = [_timeLab.text boundingRectWithSize:CGSizeMake(200, MACTimeLabelH)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:_timeLab.font}
                                                context:nil].size.width;
    if ([moment.location length]) {
        _locationLab.hidden = NO;
        _locationLab.text = moment.location;
        _timeLab.frame = CGRectMake(_nameLab.left, _locationLab.bottom+MACPaddingValue, textW, MACTimeLabelH);
    } else {
        _locationLab.hidden = YES;
        _timeLab.frame = CGRectMake(_nameLab.left, bottom, textW, MACTimeLabelH);
    }
    _deleteBtn.frame = CGRectMake(_timeLab.right + 25, _timeLab.top, 30, MACTimeLabelH);
    bottom = _timeLab.bottom + MACPaddingValue;
    // 操作视图
    _menuView.frame = CGRectMake(Screen_width-MACOperateWidth-10, _timeLab.top-(MACOperateHeight-MACTimeLabelH)/2, MACOperateWidth, MACOperateHeight);
    _menuView.circleModel = moment;
    _menuView.show = NO;
    // 处理评论/赞
    _commentView.frame = CGRectZero;
    _bgImageView.frame = CGRectZero;
    _bgImageView.image = nil;
    [_commentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 处理赞
    CGFloat top = 0;
    CGFloat width = Screen_width-MACRightMargin-_nameLab.left;
    if (moment.praiseNameList.length) {//点赞的人的名字
        MLLinkLabel *likeLabel = MACLinkLabel();
        likeLabel.delegate = self;
        likeLabel.attributedText =MLLinkLabelAttributedText (moment.praiseNameList);
        CGSize attrStrSize = [likeLabel preferredSizeWithMaxWidth:MACTextWidth];
        likeLabel.frame = CGRectMake(5, 8, attrStrSize.width, attrStrSize.height);
        [_commentView addSubview:likeLabel];
        // 分割线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, likeLabel.bottom + 7, width, 0.5)];
        line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
        [_commentView addSubview:line];
        // 更新
        top = attrStrSize.height + 15;
    }
    
    // 处理评论
    NSInteger count = [moment.commentList count];
    if (count > 0) {
        for (NSInteger i = 0; i < count; i ++) {
            CommentLable *label = [[CommentLable alloc] initWithFrame:CGRectMake(0, top, width, 0)];
            label.comment = [moment.commentList objectAtIndex:i];
            [label setDidClickText:^(MACCommentModel *comment) {
                if ([self.delegate respondsToSelector:@selector(didSelectComment:)]) {
                    [self.delegate didSelectComment:comment];
                }
            }];
            [label setDidClickLinkText:^(MLLink *link, NSString *linkText) {
                if ([self.delegate respondsToSelector:@selector(didClickLink:linkText:)]) {
                    [self.delegate didClickLink:link linkText:linkText];
                }
            }];
            [_commentView addSubview:label];
            // 更新
            top += label.height;
        }
    }
    // 更新UI
    if (top > 0) {
        _bgImageView.frame = CGRectMake(_nameLab.left, bottom, width, top + MACArrowHeight);
        _bgImageView.image = [[UIImage imageNamed:@"comment_bg"] stretchableImageWithLeftCapWidth:40 topCapHeight:30];
        _commentView.frame = CGRectMake(_nameLab.left, bottom + MACArrowHeight, width, top);
        rowHeight = _commentView.bottom + MACBlank;
    } else {
        rowHeight = _timeLab.bottom + MACBlank;
    }
    
    // 这样做就是起到缓存行高的作用，省去重复计算!!!
    _moment.rowHeight = rowHeight;
}

#pragma mark - 点击事件
// 查看全文/收起
- (void)fullTextClicked:(UIButton *)sender
{
    _showAllBtn.titleLabel.backgroundColor = MACBgColor;
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        self->_showAllBtn.titleLabel.backgroundColor = [UIColor clearColor];
        self->_moment.isFullText = !self->_moment.isFullText;
        if ([self.delegate respondsToSelector:@selector(didSelectFullText:)]) {
            [self.delegate didSelectFullText:self];
        }
    });
}

// 点击头像
- (void)clickHead:(UITapGestureRecognizer *)gesture
{
    if ([self.delegate respondsToSelector:@selector(didClickProfile:)]) {
        [self.delegate didClickProfile:self];
    }
}

// 删除动态
- (void)deleteMoment:(UIButton *)sender
{
    _deleteBtn.titleLabel.backgroundColor = [UIColor lightGrayColor];
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        self->_deleteBtn.titleLabel.backgroundColor = [UIColor clearColor];
        if ([self.delegate respondsToSelector:@selector(didDeleteMoment:)]) {
            [self.delegate didDeleteMoment:self];
        }
    });
}

#pragma mark - MLLinkLabelDelegate
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{
    // 点击动态正文或者赞高亮
    if ([self.delegate respondsToSelector:@selector(didClickLink:linkText:)]) {
        [self.delegate didClickLink:link linkText:linkText];
    }
}
@end

#pragma mark--评论
@implementation CommentLable

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _linkLabel =MACLinkLabel();
        _linkLabel.delegate = self;
        [self addSubview:_linkLabel];
    }
    return self;
}

#pragma mark - Setter
- (void)setComment:(MACCommentModel *)comment
{
    _comment = comment;
    _linkLabel.attributedText = MLLinkLabelAttributedText(comment);
    CGSize attrStrSize = [_linkLabel preferredSizeWithMaxWidth:MACTextWidth];
    _linkLabel.frame = CGRectMake(5, 3, attrStrSize.width, attrStrSize.height);
    self.height = attrStrSize.height + 5;
}

#pragma mark - MLLinkLabelDelegate
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{
    if (self.didClickLinkText) {
        self.didClickLinkText(link,linkText);
    }
}

#pragma mark - 点击
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = MACBgColor;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        self.backgroundColor = [UIColor clearColor];
        if (self.didClickText) {
            self.didClickText(self->_comment);
        }
    });
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = [UIColor clearColor];
}

@end

