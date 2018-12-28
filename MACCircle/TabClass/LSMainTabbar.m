//
//  LSMainTabbar.m
//  SmartDoor
//
//  Created by Marco on 2018/7/5.
//  Copyright © 2018年 Marco. All rights reserved.
//

#import "LSMainTabbar.h"

@interface LSMainTabbar ()<CYTabBarDelegate>

@end

@implementation LSMainTabbar

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.tabbar.delegate =self;
    //去除tabar顶部分割线
//    [[UITabBar appearance] setShadowImage:[UIImage new]];
//    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    
}

#pragma mark-中间按钮的代理方法
-(void)tabbar:(CYTabBar *)tabbar clickForCenterButton:(CYCenterButton *)centerButton{
    
    
}

//是否允许切换
-(BOOL)tabBar:(CYTabBar *)tabBar willSelectIndex:(NSInteger)index{
    
    return YES;
}

-(void)tabBar:(CYTabBar *)tabBar didSelectIndex:(NSInteger)index{
    
    
}
@end
