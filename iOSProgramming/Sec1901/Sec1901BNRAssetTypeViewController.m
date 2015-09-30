//
//  Sec1901BNRAssetTypeViewController.m
//  iOSProgramming
//
//  Created by palance on 15/9/30.
//  Copyright © 2015年 binglen. All rights reserved.
//

#import "Sec1901BNRAssetTypeViewController.h"
#import "Sec1901BNRItemStore.h"
#import "Sec1901BNRItem.h"

@implementation Sec1901BNRAssetTypeViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Sec1901UITableViewCell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[Sec1901BNRItemStore sharedStore]allAssetTypes]count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Sec1901UITableViewCell" forIndexPath:indexPath];
    NSArray *allAssets = [[Sec1901BNRItemStore sharedStore]allAssetTypes];
    NSManagedObject *assetType = allAssets[indexPath.row];
    
    // 通过键-值编码得到BNRAssetType对象的label属性
    NSString *assetLabel = [assetType valueForKey:@"label"];
    cell.textLabel.text = assetLabel;
    
    // 为当前选中的对象加上勾选标记
    if (assetType == self.item.assetType) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    NSArray *allAssets = [[Sec1901BNRItemStore sharedStore]allAssetTypes];
    NSManagedObject *assetType = allAssets[indexPath.row];
    self.item.assetType = assetType;
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
