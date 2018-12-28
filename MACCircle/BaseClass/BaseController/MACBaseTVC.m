//
//  MACBaseTVC.m
//  NavTestForMarco
//
//  Created by Marco on 2018/12/19.
//  Copyright © 2018年 Marco. All rights reserved.
//

#import "MACBaseTVC.h"


@interface MACBaseTVC ()<UIGestureRecognizerDelegate>

@end

@implementation MACBaseTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hbd_titleTextAttributes = @{ NSForegroundColorAttributeName: [UIColor.whiteColor colorWithAlphaComponent:1] };
    self.hbd_barTintColor = [UIColor grayColor];

}

/**
 点击空白处取消编辑状态
 */
- (void)addViewEndEditTap{
    UITapGestureRecognizer *TapGesturRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endViewEditing)];
    TapGesturRecognizer.delegate = self;
    [self.view addGestureRecognizer:TapGesturRecognizer];
    
}

//结束页面编辑
- (void)endViewEditing
{
    [self.tableView endEditing:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
