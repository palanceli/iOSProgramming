//
//  Sec1201BNRDrawViewController.m
//  iOSProgramming
//
//  Created by palance on 15/9/6.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec1201BNRDrawViewController.h"
#import "InformationViewController.h"

@implementation Sec1201BNRDrawViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"•••" style:UIBarButtonItemStylePlain target:self action:@selector(showInformation:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

-(IBAction)showInformation:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    InformationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"InformationViewController"];
    vc.informationString = @"注意：收到的UITouch是增量的，比如，先按下食指，收到touchesBegan:withEvent，其中touches包含一个元素；再按下中指，再次收到touchesBegan:withEvent事件，touches仍然只包含一个元素，那就是中指按下的信息。手指移动也是一样，如果双指同时移动，收到touchesMove:withEvent的touches包含两个元素，如果一个手指处于按下不动的状态，仅另一个手指移动，则touches参数仅包含这一个手指的按下信息。    \n\
    ";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
