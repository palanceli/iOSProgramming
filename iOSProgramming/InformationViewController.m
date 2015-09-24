//
//  InformationViewController.m
//  iOSProgramming
//
//  Created by palance on 15/8/31.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "InformationViewController.h"
@interface InformationViewController()

@property (weak, nonatomic) IBOutlet UILabel *informationLabel;
@end

@implementation InformationViewController
-(void)viewDidLoad
{
	self.informationLabel.text = self.informationString;
}
@end
