//
//  Sec1901BNRItemsViewController.m
//  iOSProgramming
//
//  Created by palance on 15/9/26.
//  Copyright © 2015年 binglen. All rights reserved.
//

#import "Sec1901BNRItemsViewController.h"
#import "Sec1901BNRItem.h"
#import "Sec1901BNRImageStore.h"
#import "Sec1901BNRItemStore.h"
#import "Sec1901BNRDetailViewController.h"
#import "Sec1901BNRItemCell.h"
#import "Sec1901BNRImageViewController.h"
#import "InformationViewController.h"

@interface Sec1901BNRItemsViewController()<UIPopoverControllerDelegate>
@property (nonatomic, strong)UIPopoverController *imagePopover;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@end

@implementation Sec1901BNRItemsViewController
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(updateTableViewForDynamicTypeSize) name:UIContentSizeCategoryDidChangeNotification object:nil];
    }
    return self;
}

-(void)dealloc
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setTableHeaderView:self.headerView];
    
    // 创建UINib对象，该对象代表包含了BNRItemCell的NIB文件
    UINib *nib = [UINib nibWithNibName:@"Sec19BNRItemCell" bundle:nil];
    //    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Sec1901UITableViewCell"];
    // 通过UINib对象注册相应的NIB文件
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Sec1901BNRItemCell"];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"•••" style:UIBarButtonItemStylePlain target:self action:@selector(showInformation:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

-(IBAction)showInformation:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    InformationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"InformationViewController"];
    vc.informationString = @"为什么Label不会随系统字体修改而变化？\n\n\n\
    ";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateTableViewForDynamicTypeSize];
}

#pragma mark - UITableViewDateSource方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[Sec1901BNRItemStore sharedStore] allItems] count] + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Sec1901UITableViewCell" forIndexPath:indexPath];
    // 获取BNRItemCell对象，返回的可能是现有的对象，也可能是新创建的对象
    Sec1901BNRItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Sec1901BNRItemCell" forIndexPath:indexPath];
    
    NSArray *items = [[Sec1901BNRItemStore sharedStore] allItems];
    if (indexPath.row == items.count) {
        cell.nameLabel.text = @"No more items!";
        cell.serialNumberLabel.text = @"";
        cell.valueLabel.text = @"";
    }else{
        Sec1901BNRItem *item = items[indexPath.row];
        cell.nameLabel.text = item.itemName;
        cell.serialNumberLabel.text = item.serialNumber;
        cell.valueLabel.text = [NSString stringWithFormat:@"$%d", item.valueInDollars];
        if (item.valueInDollars > 50) {
            cell.valueLabel.textColor = [UIColor greenColor];
        }else{
            cell.valueLabel.textColor = [UIColor redColor];
        }
        cell.thumbnailView.image = item.thumbnail;
        __weak Sec1901BNRItemCell *weakCell = cell;
        cell.actionBlock = ^{NSLog(@"Going to show image for %@", item);
            if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                NSString *itemKey = item.itemKey;
                // 如果BNRItem对象没有图片，就直接返回
                UIImage *img = [[Sec1901BNRImageStore sharedStore]imageForKey:itemKey];
                if (!img) {
                    return;
                }
                // 根据UITableView对象的坐标系获取UIImageView对象的位置和大小
                
                int x = weakCell.thumbnailView.bounds.origin.x;
                int y = weakCell.thumbnailView.bounds.origin.y;
                int w = weakCell.thumbnailView.bounds.size.width;
                int h = weakCell.thumbnailView.bounds.size.height;
                CGRect rect = [self.view convertRect:weakCell.thumbnailView.bounds fromView:weakCell.thumbnailView];
                NSLog(@"(x=%d, y=%d, w=%d, h=%d)=>(x=%f, y=%f, w=%f, h=%f)", x, y, w, h, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);

                // 创建BNRImageViewController对象并为image属性赋值
                Sec1901BNRImageViewController *ivc = [[Sec1901BNRImageViewController alloc]init];
                ivc.image = img;
                // 根据UIImageView对象的位置和大小，显示一个大小为600 * 600 的UIPopoverController对象
                self.imagePopover = [[UIPopoverController alloc]initWithContentViewController:ivc];
                self.imagePopover.delegate = self;
                self.imagePopover.popoverContentSize = CGSizeMake(600, 600);
                [self.imagePopover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            }
        };
    }
    return cell;
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.imagePopover = nil;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[Sec1901BNRItemStore sharedStore]allItems];
        if (indexPath.row == items.count) {
            return;
        }
        Sec1901BNRItem *item = items[indexPath.row];
        [[Sec1901BNRItemStore sharedStore]removeItem:item];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[Sec1901BNRItemStore sharedStore]moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
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
    Sec1901BNRItem *newItem = [[Sec1901BNRItemStore sharedStore]createItem];
    
    Sec1901BNRDetailViewController *detailViewController = [[Sec1901BNRDetailViewController alloc]initForNewItem:YES];
    detailViewController.item = newItem;
    detailViewController.dismissBlock = ^{[self.tableView reloadData];};
    
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:detailViewController];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        navController.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    //    navController.modalPresentationStyle = UIModalPresentationCurrentContext;
    //    self.definesPresentationContext = YES;
    //    navController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:navController animated:YES completion:nil];
    
    //    NSInteger lastRow = [[[Sec1101BNRItemStore sharedStore]allItems]indexOfObject:newItem];
    //
    //    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    //    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

#pragma mark - UITableViewDelegate 方法
-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(NSIndexPath*)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    NSArray *items = [[Sec1901BNRItemStore sharedStore]allItems];
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
    NSArray *items = [[Sec1901BNRItemStore sharedStore]allItems];
    if (indexPath.row == items.count) {
        return;
    }
    Sec1901BNRItem *item = items[indexPath.row];
    
    //    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //    Sec1101BNRDetailViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Sec1101BNRDetailViewController"];
    Sec1901BNRDetailViewController *vc = [[Sec1901BNRDetailViewController alloc]initForNewItem:NO];
    vc.item = item;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
-(void)updateTableViewForDynamicTypeSize
{
    static NSDictionary *cellHeightDictionary;
    if (!cellHeightDictionary) {
        cellHeightDictionary = @{
                                 UIContentSizeCategoryExtraSmall : @44,
                                 UIContentSizeCategorySmall : @44,
                                 UIContentSizeCategoryMedium : @44,
                                 UIContentSizeCategoryLarge : @44,
                                 UIContentSizeCategoryExtraLarge : @55,
                                 UIContentSizeCategoryExtraExtraLarge : @65,
                                 UIContentSizeCategoryExtraExtraExtraLarge : @75
                                 };
    }
    NSString *userSize = [[UIApplication sharedApplication]preferredContentSizeCategory];
    NSNumber *cellHeight = cellHeightDictionary[userSize];
    [self.tableView setRowHeight:cellHeight.floatValue];
    [self.tableView reloadData];
}

@end
