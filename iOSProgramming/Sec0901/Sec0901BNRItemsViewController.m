//
//  Sec0901BNRItemsViewController.m
//  iOSProgramming
//
//  Created by palance on 15/9/3.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0901BNRItemsViewController.h"
#import "Sec0901BNRItem.h"
#import "Sec0901BNRItemStore.h"
#import "InformationViewController.h"

@interface Sec0901BNRItemsViewController()
@property (weak, nonatomic) IBOutlet UIView *headerView;

@end

@implementation Sec0901BNRItemsViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Sec0901UITableViewCell"];
    [self.tableView setTableHeaderView:self.headerView];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"•••" style:UIBarButtonItemStylePlain target:self action:@selector(showInformation:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

-(IBAction)showInformation:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    InformationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"InformationViewController"];
    vc.informationString = @"注意：如果母窗体本来就是从Object library中拖出来的TableViewController，它在顶部有一个UIView，但这不是headerView，如果要添加headerView，还是应该再拉一个UIView放到TableViewController的顶部（Prototype Cells的上面）\n\\n\
    对于增删改，重点说一下修改位置，只需要实现UITableViewDataSource的table：moveRowAtIndexPath:toIndexPath，当UITableViewController处于editing状态时，自然会出现调整顺序的把手图标。\n\\n\
    修改delete按钮上的文字，只需要覆盖UITableViewDelegate方法\n\
    tableView: titleForDeleteConfirmationButtonForRowAtIndexPath:\n\n\
    当移动某行时，会调用UITableViewDelegate的方法：-(NSIndexPath*)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath\n\
    两个参数分别表示要从哪移动到哪，返回值表示确认被移动到的目标位置，因此不管是禁止某行被移动还是禁止被移动到某行，只要根据两个参数控制返回值即可。\n\
    \n\
    \n\
    }";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDateSource方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[Sec0901BNRItemStore sharedStore] allItems] count] + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Sec0901UITableViewCell" forIndexPath:indexPath];
    
    NSArray *items = [[Sec0901BNRItemStore sharedStore] allItems];
    if (indexPath.row == items.count) {
        cell.textLabel.text = @"No more items!";
    }else{
        Sec0901BNRItem *item = items[indexPath.row];
        cell.textLabel.text = [item description];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[Sec0901BNRItemStore sharedStore]allItems];
        if (indexPath.row == items.count) {
            return;
        }
        Sec0901BNRItem *item = items[indexPath.row];
        [[Sec0901BNRItemStore sharedStore]removeItem:item];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[Sec0901BNRItemStore sharedStore]moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

#pragma mark - 响应header view 按钮消息
- (IBAction)toggleEditingMode:(id)sender {
    if (self.isEditing) {
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
        [self setEditing:NO animated:YES];
    }else{
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
    }
}
- (IBAction)addNewItem:(id)sender {
    Sec0901BNRItem *newItem = [[Sec0901BNRItemStore sharedStore]createItem];
    
    NSInteger lastRow = [[[Sec0901BNRItemStore sharedStore]allItems]indexOfObject:newItem];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

#pragma mark - UITableViewDelegate 方法
-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(NSIndexPath*)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    NSArray *items = [[Sec0901BNRItemStore sharedStore]allItems];
    if (sourceIndexPath.row == items.count) {
        return sourceIndexPath;
    }
    if (proposedDestinationIndexPath.row == items.count) {
        return sourceIndexPath;
    }
    return proposedDestinationIndexPath;
}

@end
