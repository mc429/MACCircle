//
//  MACTableViewController.m
//  MACCircle
//
//  Created by Marco on 2018/12/22.
//  Copyright © 2018年 Marco. All rights reserved.
//

#import "MACTableViewController.h"
#import "MACMomentKit.h"
#import "MACCircleCell.h"
#import "MACCircleModel.h"//内容model
#import "MACCommentModel.h"//评论的model

#define CircleCell @"circleCell"

@interface MACTableViewController ()<MomentCellDelegate,UITextFieldDelegate>
@property (nonatomic,strong)UIImageView *headView;
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic, strong) NSIndexPath *currentEditingIndexthPath;
@property (nonatomic,strong)UIView *textView;
/**
 内容数组
 */
@property (nonatomic,strong)NSMutableArray *momentList;

/**
 评论model
 */
@property (nonatomic,strong)MACCircleModel *circleModel;

@end

@implementation MACTableViewController{
    CGFloat _gradientProgress;
    CGFloat _lastScrollViewOffsetY;
    CGFloat _totalKeybordHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getContentData];
    self.hbd_barAlpha = 0.0;
    self.tableView.tableHeaderView = [self tableViewHead];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.title = @"朋友圈";
    [self.tableView registerClass:[MACCircleCell class] forCellReuseIdentifier:CircleCell];
    
  
    //键盘弹起/收回的方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self setupTextField];
    //刷新tableView防止滚动
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;

    
}


-(UIView *)tableViewHead{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"lakeside_sunset" ofType:@"png"];
    UIImage *headerImage = [UIImage imageWithContentsOfFile:imagePath];
    _headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_width, 300)];
    _headView.image = headerImage;
    return _headView;
    
}




/**
 制造朋友圈内容
 */
-(void)getContentData{
    self.momentList = [[NSMutableArray alloc] init];
    NSMutableArray *commentList = nil;
    //制造十条朋友圈
    for (int i=0; i<10; i++) {
        commentList = [[NSMutableArray alloc]init];
        int num = arc4random()%5 + 1;//随机评论条数
        for (int j=0; j<num; j++) {
        MACCommentModel *commentModel = [[MACCommentModel alloc]init];
            commentModel.userName = @"jex";
            commentModel.text = @"微信又又又双双叒叕更新了，ios版本微信昨天推出了7.0.0版本。从这个整数的版本号就能预测出这次可能会有大改版";
            commentModel.time = 1545634476;
            commentModel.pk = j;
            [commentList addObject:commentModel];
        }
        MACCircleModel *moment = [[MACCircleModel alloc]init];
        moment.commentList = commentList;
        moment.praiseNameList = @"马超，产品的就发，减肥的司机，OK二级，就发你，见佛啊，附近奥斯，年纪，就否，房间爱家，阿基德，佛卡";
        moment.userName = @"Marco";
        moment.time = 1545634476;
        moment.singleWidth = 500;
        moment.singleHeight = 315;
        moment.location = @"武汉 · 光谷";
        moment.isPraise = NO;
        if (i == 5) {
            moment.commentList = [NSArray array];
           // moment.praiseNameList = nil;
            moment.text = @"骑行是一种深受大众喜欢的一项有氧运动，无门槛，无难度，老少皆宜。但是，骑行也有一些小经验或者说小技巧，你可以了解一下，当然，做与不做，在你自己喽machaoem@163.com。";
            moment.fileCount = 1;
        } else if (i == 1) {
            moment.text = @"对于iPhone十周年纪念已经过去，不过Mobile Shop团队依旧为我们准备了苹果有史以来所有iOS版本的简要列表。其中一些我们喜欢，其中一些并非如此。尽管如此，iOS仍在我们的心中占了重要的位置。";
            moment.fileCount = arc4random()%10;
           // moment.praiseNameList = nil;
        } else if (i == 2) {
            moment.fileCount = 9;
        } else {
            moment.text = @"iOS开发没人要了😭😭。";
            moment.fileCount = arc4random()%10;
        }
        [self.momentList addObject:moment];
        
    }
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.momentList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MACCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:CircleCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.moment = [self.momentList objectAtIndex:indexPath.row];
    cell.delegate = self;
    cell.tag = indexPath.row;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MACCircleModel *model = self.momentList[indexPath.row];
    return model.rowHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [_textField resignFirstResponder];
    
    //刷新单个cell
    NSIndexPath *indexPathRow=[NSIndexPath indexPathForRow:_currentEditingIndexthPath.row inSection:0];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathRow,nil] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
  
    MACCircleModel *modle = _momentList[_currentEditingIndexthPath.row];
    
    if (modle.isHidenMenu) {
        //刷新单个cell
        NSIndexPath *indexPathRow=[NSIndexPath indexPathForRow:_currentEditingIndexthPath.row inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathRow,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat headerHeight = 300.0-64;
    CGFloat progress = scrollView.contentOffset.y + scrollView.contentInset.top;
    CGFloat gradientProgress = MIN(1, MAX(0, progress  / headerHeight));
    gradientProgress = gradientProgress * gradientProgress * gradientProgress * gradientProgress;
    if (gradientProgress != _gradientProgress) {
        _gradientProgress = gradientProgress;
        NSLog(@"滑动的比例：%lf",_gradientProgress);
        if (_gradientProgress < 0.1) {
            self.hbd_barStyle = UIBarStyleBlack;
            self.hbd_tintColor = UIColor.whiteColor;
            self.hbd_titleTextAttributes = @{ NSForegroundColorAttributeName: [UIColor.whiteColor colorWithAlphaComponent:1] };
        } else {
            self.hbd_barStyle = UIBarStyleDefault;
            self.hbd_tintColor = UIColor.whiteColor;
            self.hbd_titleTextAttributes = @{ NSForegroundColorAttributeName: [UIColor.whiteColor colorWithAlphaComponent:1] };
        }
        
        
        
        self.hbd_barAlpha = _gradientProgress;
        [self hbd_setNeedsUpdateNavigationBar];
        
    }
    
}

- (void)setupTextField
{
    _textField = [UITextField new];
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    _textField.layer.cornerRadius = 5;
    _textField.layer.masksToBounds = YES;
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.frame = CGRectMake(5, 4.5, self.view.width-10, InputTextHeight);
    
    _textView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, Screen_width, 49)];
     _textView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [_textView addSubview:_textField];
    [[UIApplication sharedApplication].keyWindow addSubview:_textView];
    
    [_textField becomeFirstResponder];
    [_textField resignFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_textField resignFirstResponder];
    
}
#pragma mark-键盘的监听方法

-(void)keyboardNotification:(NSNotification*)notification{
    
    NSDictionary *dict = notification.userInfo;
    CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    CGRect textFieldRect = CGRectMake(0, rect.origin.y - 49, rect.size.width, 49);
    if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
        textFieldRect = rect;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self->_textView.frame = textFieldRect;
    }];
    CGFloat h = rect.size.height + InputTextHeight;
    if (_totalKeybordHeight != h) {
        _totalKeybordHeight = h;
        if (rect.origin.y != [UIScreen mainScreen].bounds.size.height) {
            [self adjustTableViewToFitKeyboard];
        }
    }else{
        
        _totalKeybordHeight=0;
    }
    
    
}

- (void)adjustTableViewToFitKeyboard
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:_currentEditingIndexthPath];
    CGRect rect = [cell.superview convertRect:cell.frame toView:window];
    [self adjustTableViewToFitKeyboardWithRect:rect];
}

- (void)adjustTableViewToFitKeyboardWithRect:(CGRect)rect
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGFloat delta = CGRectGetMaxY(rect) - (window.bounds.size.height - _totalKeybordHeight);
    
    CGPoint offset = self.tableView.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }
    
    [self.tableView setContentOffset:offset animated:YES];
}
#pragma mark-cell代理方法

/**
 点击用户头像
 */
-(void)didClickProfile:(MACCircleCell *)cell{
    
    
}

/**
 删除动作
 */
-(void)didDeleteMoment:(MACCircleCell *)cell{
    
    
}

-(void)didClickMoment:(MACCircleCell *)cell{
    _currentEditingIndexthPath = [self.tableView indexPathForCell:cell];
    _circleModel = self.momentList[_currentEditingIndexthPath.row];
    
}

/**
点赞
 */
-(void)didLikeMoment:(MACCircleCell *)cell{
    
    NSLog(@"点赞");
    MACCircleModel *moment = cell.moment;
    NSMutableArray *tempArray = [NSMutableArray array];
    if (moment.praiseNameList.length) {
        tempArray = [NSMutableArray arrayWithArray:[moment.praiseNameList componentsSeparatedByString:@"，"]];
    }
    if (moment.isPraise) {
        moment.isPraise = 0;
        [tempArray removeObject:@"AMG"];
    } else {
        moment.isPraise = 1;
        [tempArray addObject:@"AMG"];
    }
    NSMutableString *tempString = [NSMutableString string];
    NSInteger count = [tempArray count];
    for (NSInteger i = 0; i < count; i ++) {
        if (i == 0) {
            [tempString appendString:[tempArray objectAtIndex:i]];
        } else {
            [tempString appendString:[NSString stringWithFormat:@"，%@",[tempArray objectAtIndex:i]]];
        }
    }
    moment.praiseNameList = tempString;
    [self.momentList replaceObjectAtIndex:cell.tag withObject:moment];
    [self.tableView reloadData];
    
}

/**
评论
 */
-(void)didAddComment:(MACCircleCell *)cell{
   
    [_textField becomeFirstResponder];
    
}

/**
 查看全文收起
 */
- (void)didSelectFullText:(MACCircleCell *)cell{
    
    
}

/**
 选择评论
 */
-(void)didSelectComment:(MACCommentModel *)comment{
    NSLog(@"点击了评论");
    
}


/**
点击高亮
 */
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText{
    
    NSLog(@"点击高亮部分:%@",linkText);
    
}





@end
