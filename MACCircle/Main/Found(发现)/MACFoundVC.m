//
//  MACFoundVC.m
//  MACCircle
//
//  Created by Marco on 2018/12/22.
//  Copyright © 2018年 Marco. All rights reserved.
//

#import "MACFoundVC.h"
#import "MACTableViewController.h"
@implementation MACFoundVC
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"发现";
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
}

#pragma mark-tableView代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //设置cell分割线距离边距的距离
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.imageView.image = [UIImage imageNamed:@"moment_refresh"];
    cell.textLabel.text = @"朋友圈";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MACTableViewController *circle = [[MACTableViewController alloc]init];
    [self.navigationController pushViewController:circle animated:YES];
}

@end
