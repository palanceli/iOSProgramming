//
//  Sec0402BNRHypnosisViewController.m
//  iOSProgramming
//
//  Created by palance on 15/8/31.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0402BNRHypnosisViewController.h"
#import "Sec0402BNRHypnosisInfoViewController.h"
#import "InformationViewController.h"

@implementation Sec0402BNRHypnosisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"•••" style:UIBarButtonItemStylePlain target:self action:@selector(showInformation:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

-(IBAction)showInformation:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    InformationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Sec0402BNRHypnosisInfoViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
