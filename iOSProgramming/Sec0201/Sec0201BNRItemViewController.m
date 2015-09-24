//
//  Sec0201BNRItemViewController.m
//  iOSProgramming
//
//  Created by palance on 15/8/30.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0201BNRItemViewController.h"
#import "Sec0201BNRItem.h"
@interface Sec0201BNRItemViewController()

@property (weak, nonatomic) IBOutlet UILabel *outputLabel;
@end

@implementation Sec0201BNRItemViewController
-(void)viewDidLoad
{
    NSMutableArray *items = [[NSMutableArray alloc]init];
    NSString *outputString = @"";
    for (int i=0; i<10; i++) {
        Sec0201BNRItem *item = [Sec0201BNRItem randomItem];
        [items addObject:item];
        outputString = [NSString stringWithFormat:@"%@\n%@", outputString, item];
    }
    NSLog(@"%@", outputString);
    self.outputLabel.text = outputString;
}
@end
