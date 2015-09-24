//
//  Sec0801BNRItemsViewController.m
//  iOSProgramming
//
//  Created by palance on 15/9/3.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0801BNRItemsViewController.h"
#import "InformationViewController.h"
#import "Sec0801BNRItemStore.h"
#import "Sec0801BNRItem.h"

@implementation Sec0801BNRItemsViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"•••" style:UIBarButtonItemStylePlain target:self action:@selector(showInformation:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    for (int i=0; i<20; i++) {
        [[Sec0801BNRItemStore sharedStore]createItem];
    }
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Sec0801UITableViewCell"];
}

-(IBAction)showInformation:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    InformationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"InformationViewController"];
    vc.informationString = @"singleton的关键步骤：1、工厂方法\n\
    +(instancetype)sharedStore\n\
    {\n\
        static Singleton *sharedStore = nil;\n\
        if (sharedStore == nil) {\n\
            sharedStore = [[self alloc]initPrivate];\n\
        }\n\
        return sharedStore;\n\
    }\n\
    \n\
    2、私有初始化方法\n\
    -(instancetype)initPrivate\n\
    {\n\
        self = [super init];\n\
        return self;\n\
    }\n\
    3、封住初始化方法\n\
    -(instancetype)init\n\
    {\n\
        @throw [NSException exceptionWithName:@\"Singleton\" reason:@\"Use + [BNRItemStore sharedStore]\" userInfo:nil];\n\
        return nil;\n\
    }\n\
    ";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDateSource方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[Sec0801BNRItemStore sharedStore] allItems] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Sec0801UITableViewCell" forIndexPath:indexPath];
    
    NSArray *items = [[Sec0801BNRItemStore sharedStore] allItems];
    Sec0801BNRItem *item = items[indexPath.row];
    
    cell.textLabel.text = [item description];
    return cell;
}
@end
