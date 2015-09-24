//
//  Sec0202BNRContainerViewController.m
//  iOSProgramming
//
//  Created by palance on 15/8/30.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0202BNRContainerViewController.h"
#import "Sec0202BNRContainer.h"

@interface Sec0202BNRContainerViewController ()

@property (weak, nonatomic) IBOutlet UILabel *outputLabel;
@end

@implementation Sec0202BNRContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Sec0202BNRContainer *rootContainer = [Sec0202BNRContainer randomContainerWithChild:3];
    Sec0202BNRContainer *childContainer = [Sec0202BNRContainer randomContainerWithChild:2];
    [rootContainer AddItem:childContainer];
    self.outputLabel.text = [NSString stringWithFormat:@"%@", rootContainer];
}

@end
