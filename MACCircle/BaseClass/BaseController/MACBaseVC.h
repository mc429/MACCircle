//
//  BaseVC.h
//  NavTestForMarco
//
//  Created by Marco on 2018/12/12.
//  Copyright © 2018年 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//tableView样式
typedef NS_ENUM(NSInteger, MacTableViewStyle) {
    MacTableViewStylePlain,          // regular table view
    MacTableViewStyleGrouped         // preferences style table view
};

@interface MACBaseVC : UIViewController

/**
 设置yes view的坐标从0，0开始，默认是从0，64计算从导航栏下计算
 *注意此属性必须在重写父类方法之前设置
 */
@property (nonatomic, assign) BOOL mco_extendedLayoutIncludesTopBar;

/**
 导航栏隐藏
 *注意！！！此属性需要在初始化了tableView后设置才生效
 */
@property (nonatomic,assign)BOOL mac_navigationHide;

@property (nonatomic,strong)UITableView *tableView;
/**
 添加tableView
 */
-(void)addTableView:(MacTableViewStyle)tableViewType;

#pragma 将tableView代理方法公开出来供子类能够调用
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
