//
//  Sec0802BNRItemViewController.m
//  iOSProgramming
//
//  Created by palance on 15/9/3.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0802BNRItemViewController.h"
#import "Sec0802BNRItem.h"
#import "Sec0802BNRItemStore.h"
#import "InformationViewController.h"

@implementation Sec0802BNRItemViewController

-(void)viewDidLoad
{
    for (int i=0; i<20; i++) {
        [[Sec0802BNRItemStore sharedStore]createItem];
    }
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Sec0802UITableViewCell"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"背景.png"]];
    self.tableView.backgroundView = imageView;

    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"•••" style:UIBarButtonItemStylePlain target:self action:@selector(showInformation:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
}

-(IBAction)showInformation:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    InformationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"InformationViewController"];
    vc.informationString = @"要想让背景显示出来，需要完成两步：1、创建UIImageView，并设为UITableView的backgroundview：\n\
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@\"背景.png\"]];\n\
    self.tableView.backgroundView = imageView;\n\n\n\
    2、在UITableViewDelegate的tableView:willDisplayCell:forRowAtIndexPath:方法中，将cell的背景色设为半透明：\n\
    -(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath\n\
    {\n\
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];\n\
    }";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDateSource方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"小于等于$50";
    }else{
        return @"大于$50";
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *items = [[Sec0802BNRItemStore sharedStore]allItemsInSection:section];
    if (section == 1) {
        return ([items count] + 1);
    }
    return [items count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Sec0802UITableViewCell" forIndexPath:indexPath];
    
    NSArray *items = [[Sec0802BNRItemStore sharedStore]allItemsInSection:indexPath.section];
    if (indexPath.section == 1 && indexPath.row == items.count) {
        cell.textLabel.text = @"No more items!";
        
    }else{
        Sec0802BNRItem *item = items[indexPath.row];
        cell.textLabel.text = [item description];
    }
    return cell;
}

#pragma mark - UITableViewDelegate方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *items = [[Sec0802BNRItemStore sharedStore]allItemsInSection:indexPath.section];
    if (indexPath.section == 1 && indexPath.row == items.count) {
        return 44;
    }else{
        return 60;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
}

@end
