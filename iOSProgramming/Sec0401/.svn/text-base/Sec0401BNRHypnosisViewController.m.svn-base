//
//  Sec0401BNRHypnosisViewController.m
//  iOSProgramming
//
//  Created by palance on 15/8/30.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0401BNRHypnosisViewController.h"
#import "Sec0401BNRHypnosisInfoViewController.h"

@interface Sec0401BNRHypnosisViewController ()

@end

@implementation Sec0401BNRHypnosisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"•••" style:UIBarButtonItemStylePlain target:self action:@selector(showInformation:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

-(IBAction)showInformation:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Sec0401BNRHypnosisInfoViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Sec0401BNRHypnosisInfoViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
