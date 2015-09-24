//
//  Sec0502ViewController.m
//  iOSProgramming
//
//  Created by palance on 15/9/1.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0502ViewController.h"
#import "Sec0502BNRHypnosisView.h"

@interface Sec0502ViewController()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation Sec0502ViewController
-(void)viewDidLoad
{
    CGRect contentRect = self.view.bounds;
    contentRect.size.width *= 2.0;
    contentRect.size.height *= 2.0;
    
    Sec0502BNRHypnosisView *hypnosisView = [[Sec0502BNRHypnosisView alloc]initWithFrame:contentRect];
    [self.scrollView addSubview:hypnosisView];
    
    self.scrollView.contentSize = contentRect.size;
}
@end
