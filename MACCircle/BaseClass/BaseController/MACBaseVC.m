//
//  BaseVC.m
//  NavTestForMarco
//
//  Created by Marco on 2018/12/12.
//  Copyright © 2018年 Marco. All rights reserved.
//

#import "MACBaseVC.h"
#import "UIViewController+MC.h"
@interface MACBaseVC ()<UITableViewDataSource,UITableViewDelegate>

@end

BOOL hasAlphad(UIColor *color) {
    if (!color) {
        return YES;
    }
    CGFloat red = 0;
    CGFloat green= 0;
    CGFloat blue = 0;
    CGFloat alpha = 0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return alpha < 1.0;
}
@implementation MACBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hbd_barTintColor = [UIColor grayColor];
    self.hbd_titleTextAttributes = @{ NSForegroundColorAttributeName: [UIColor.whiteColor colorWithAlphaComponent:1] };
    
    if (!(self.mco_extendedLayoutIncludesTopBar || hasAlphad(self.hbd_barTintColor))) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor whiteColor];
}


-(void)addTableView:(MacTableViewStyle)tableViewType{
    
    _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:tableViewType==0?UITableViewStylePlain:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
-(void)setMac_navigationHide:(BOOL)mac_navigationHide{
    self.hbd_barHidden = mac_navigationHide;
    if (mac_navigationHide) {
        
        if (@available(iOS 11.0, *)) {
                    _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
                    // Fallback on earlier versions
        }
    }
    
}

#pragma-mark tableView代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


@end
