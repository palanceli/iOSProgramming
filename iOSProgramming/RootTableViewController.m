//
//  RootTableViewController.m
//  iOSProgramming
//
//  Created by palance on 15/8/26.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "RootTableViewController.h"

@interface RootTableViewController ()
@property (nonatomic, strong) NSArray *viewControllerIDs;
@property (nonatomic, strong) NSArray *cellTexts;

@end

@implementation RootTableViewController

#pragma mark -
-(void)viewDidLoad
{
    self.navigationItem.title = @"iOS编程";
    self.viewControllerIDs = @[@"Sec0101BNRQuizeViewController",
                               @"Sec0201BNRItemViewController",
                               @"Sec0202BNRContainerViewController",
                               @"Sec0401BNRHypnosisViewController",
                               @"Sec0402BNRHypnosisViewController",
                               @"Sec0501ViewController",
                               @"Sec0502ViewController",
                               @"Sec0503ViewController",
                               @"Sec0601TableBarController",
                               @"Sec0602TableBarController",
                               @"Sec0701ViewController",
                               @"Sec0702ViewController",
                               @"Sec0801ViewController",
                               @"Sec0802ViewController",
                               @"Sec0901ViewController",
                               @"Sec1001ViewController",
                               @"Sec1101ViewController",
                               @"Sec1201ViewController",
                               @"Sec1301ViewController",
                               @"SecEndViewController",
                               ];
    self.cellTexts = @[@"第1章 第一个简单的iOS应用",
                       @"第2章 编写命令行工具RandomItems",
                       @"第2章 高级练习",
                       @"第4章 创建UIView子类",
                       @"第4章 练习",
                       @"第5章 重绘",
                       @"第5章 UIScrollView",
                       @"第5章 分页",
                       @"第6章 另一个视图控制器",
                       @"第6章 练习",
                       @"第7章 委托",
                       @"第7章 高级练习：捏合-缩放",
                       @"第8章 UITableView与UITableViewController",
                       @"第8章 练习",
                       @"第9章 编辑模式",
                       @"第10章 UINavigationController",
                       @"第11章 相机 & 第15章 自动布局入门 & 第17章 自动转屏，UIPopoverController与模态视图控制器",
                       @"第12章 触摸事件与UIResponder",
                       @"第13章 UIGestureRecognizer与UIMenuController",
                       @"遗留问题"];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewControllerIDs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.cellTexts[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= self.viewControllerIDs.count) {
        @throw [NSException exceptionWithName:@"错误" reason:@"没有找到对应的章节数据" userInfo:nil];
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *secViewController = [storyboard instantiateViewControllerWithIdentifier:self.viewControllerIDs[indexPath.row]];
    [self.navigationController pushViewController:secViewController animated:YES];
}

@end
