//
//  Sec1001BNRItemsViewController.m
//  iOSProgramming
//
//  Created by palance on 15/9/4.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec1001BNRItemsViewController.h"
#import "InformationViewController.h"
#import "Sec1001BNRItem.h"
#import "Sec1001BNRItemStore.h"
#import "Sec1001BNRDetailViewController.h"

@interface Sec1001BNRItemsViewController()

@property (weak, nonatomic) IBOutlet UIView *headerView;
@end

@implementation Sec1001BNRItemsViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Sec1001UITableViewCell"];
    [self.tableView setTableHeaderView:self.headerView];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"•••" style:UIBarButtonItemStylePlain target:self action:@selector(showInformation:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(IBAction)showInformation:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    InformationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"InformationViewController"];
    vc.informationString = @"注意：UINavigationController是不能叠加的，也就是说不能在一个UINavigationController内部再推入一个UINavigationController，否则会在运行时报错。\n\
    具体UINavigationController的创建和使用可以参见本程序的RootNavigationController，其实也没啥实质的内容，注意设置一个root view controller，在需要弹出新视图时调用pushViewController即可。\n\n\
    关于日期时间格式的设定：NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];\n\
        [dateFormatter setDateFormat:@\"yyyy-MM-dd HH:mm:ss\"];\n\
        [dateFormatter stringFromDate:self.item.dateCreated]\n\
    我发现这样会直接转换成本地时区。\n\n\
    关于数据传递，新叠入的视图在出现和消失时分别会收到viewWillAppear:和viewWillDisappear:消息，应该在前一个消息中完成数据到视图的更新，后一个消息中完成视图到数据的更新。下面一层视图应该在viewWillAppear:消息中调用[self.tableView reloadData];这会刷新UITableView对象，重新获取一遍数据，使用户看到的是更新后的数据。\n\n\
    原书例子中在ItemsViewController的左右导航按钮分别设置为编辑和添加，把原tableview的headerview干掉了。此处因为不能叠加NavigationController，ItemsViewController的左右导航分别用作了返回和更多信息，所以就不随原书例子修改了。\n\n\
    关于关闭键盘，比较好的做法是当触摸到非输入区时讲键盘隐藏掉，这需要把背景窗体由UIView改为UIControl，并响应它的Touch up inside事件，在该事件中调用当前窗体的endEditing方法。\n\n\
    注意：NSDate是个只读的数据类型，也就是说它表示一个时间点，这个时间点是不可修改的。因此在高级练习中我把BNRItem(而不是它的dateCreated)传入时间修改的vc，当在该vc内修改时间数值后，直接把新的NSDate更新给BNRItem。\n\
    ";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDateSource方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[Sec1001BNRItemStore sharedStore] allItems] count] + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Sec1001UITableViewCell" forIndexPath:indexPath];
    
    NSArray *items = [[Sec1001BNRItemStore sharedStore] allItems];
    if (indexPath.row == items.count) {
        cell.textLabel.text = @"No more items!";
    }else{
        Sec1001BNRItem *item = items[indexPath.row];
        cell.textLabel.text = [item description];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[Sec1001BNRItemStore sharedStore]allItems];
        if (indexPath.row == items.count) {
            return;
        }
        Sec1001BNRItem *item = items[indexPath.row];
        [[Sec1001BNRItemStore sharedStore]removeItem:item];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[Sec1001BNRItemStore sharedStore]moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
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
    Sec1001BNRItem *newItem = [[Sec1001BNRItemStore sharedStore]createItem];
    
    NSInteger lastRow = [[[Sec1001BNRItemStore sharedStore]allItems]indexOfObject:newItem];
    
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
    NSArray *items = [[Sec1001BNRItemStore sharedStore]allItems];
    if (sourceIndexPath.row == items.count) {
        return sourceIndexPath;
    }
    if (proposedDestinationIndexPath.row == items.count) {
        return sourceIndexPath;
    }
    return proposedDestinationIndexPath;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *items = [[Sec1001BNRItemStore sharedStore]allItems];
    if (indexPath.row == items.count) {
        return;
    }
    Sec1001BNRItem *item = items[indexPath.row];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Sec1001BNRDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Sec1001BNRDetailViewController"];
    vc.item = item;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
