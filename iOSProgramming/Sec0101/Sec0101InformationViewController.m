//
//  Sec0101InformationViewController.m
//  iOSProgramming
//
//  Created by palance on 15/8/26.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0101InformationViewController.h"

@interface Sec0101InformationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *informationLabel;

@end

@implementation Sec0101InformationViewController

-(void)viewDidLoad
{
    NSString *infoString = @"书中的例子界面部分是用NIB完成的，我使用了StoryBoard。\n使用NIB，BNRQuizViewController的初始化会调用initWithNibName: bundle:\n使用StoryBoard，BNRQuizViewController的初始化则会调用initWithCoder:。\n\n另外我还加入了自动布局约束，确保几个控件在不同尺寸的屏幕下都是居中的。";
    self.informationLabel.text = infoString;
}
@end
