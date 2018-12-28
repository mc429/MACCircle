//
//  AppDelegate.m
//  MACCircle
//
//  Created by Marco on 2018/12/22.
//  Copyright © 2018年 Marco. All rights reserved.
//

#import "AppDelegate.h"
#import "LSMainTabbar.h"
#import "MCNavigationController.h"
#import "MACMessageVC.h"
#import "MACAddressBookVC.h"
#import "MACSetingVC.h"
#import "MACFoundVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.rootViewController = [self setMainTabBar];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(LSMainTabbar*)setMainTabBar{
    
    //初始化tabbar
    LSMainTabbar *mainTabBar = [[LSMainTabbar alloc]init];
    
    
    //配置属性
    [CYTabBarConfig shared].selectedTextColor = [UIColor greenColor];
    [CYTabBarConfig shared].textColor = [UIColor blackColor];
    [CYTabBarConfig shared].backgroundColor = [UIColor whiteColor];
    [CYTabBarConfig shared].selectIndex = 0;
    // [CYTabBarConfig shared].centerBtnIndex = 1;//带商城为2 不带商城为1
    [CYTabBarConfig shared].HidesBottomBarWhenPushedOption = HidesBottomBarWhenPushedAlone;
    
    [self setThreeController:mainTabBar];
 
    
    return mainTabBar;
    
}

-(void)setThreeController:(CYTabBarController *)tabBar{
    
    //首页
    MCNavigationController *nav= [[MCNavigationController alloc]initWithRootViewController:[[MACMessageVC alloc]init]];
   
    [tabBar addChildController:nav title:@"消息" imageName:@"tabbar_0" selectedImageName:@"tabbar_hl_0"];
    
    //通讯录
   MCNavigationController *nav1 = [[MCNavigationController alloc]initWithRootViewController:[[MACAddressBookVC alloc]init] ];
 
    [tabBar addChildController:nav1 title:@"通讯录" imageName:@"tabbar_1" selectedImageName:@"tabbar_hl_1"];
    
    //发现
    MCNavigationController *nav2 = [[MCNavigationController alloc]initWithRootViewController:[[MACFoundVC alloc]init] ];
    [tabBar addChildController:nav2 title:@"发现" imageName:@"tabbar_2" selectedImageName:@"tabbar_hl_2"];
    
    //设置
    MCNavigationController *nav3 = [[MCNavigationController alloc]initWithRootViewController:[[MACSetingVC alloc]init] ];
    [tabBar addChildController:nav3 title:@"设置" imageName:@"tabbar_3" selectedImageName:@"tabbar_hl_3"];
    
}

@end
