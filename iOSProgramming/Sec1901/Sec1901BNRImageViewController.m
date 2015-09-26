//
//  Sec1901BNRImageViewController.m
//  iOSProgramming
//
//  Created by palance on 15/9/27.
//  Copyright © 2015年 binglen. All rights reserved.
//

#import "Sec1901BNRImageViewController.h"

@interface Sec1901BNRImageViewController ()

@end

@implementation Sec1901BNRImageViewController

-(void)loadView
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.view = imageView;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 必须将view转换为UIImageView对象，以便向其发送setImage:消息
    UIImageView *imageView = (UIImageView *)self.view;
    imageView.image = self.image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
