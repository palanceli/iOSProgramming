//
//  Sec0503ViewController.m
//  iOSProgramming
//
//  Created by palance on 15/9/1.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0503ViewController.h"
#import "Sec0503BNRHypnosisView.h"

@interface Sec0503ViewController()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation Sec0503ViewController

-(void)viewDidLoad
{
    CGRect contentRect = self.view.bounds;
    contentRect.size.width *= 2.0;
    
    Sec0503BNRHypnosisView * hypnosisView = [[Sec0503BNRHypnosisView alloc]initWithFrame:self.view.bounds];
    [self.scrollView addSubview:hypnosisView];
    
    CGRect secondViewRect = self.view.bounds;
    secondViewRect.origin.x += secondViewRect.size.width;
    Sec0503BNRHypnosisView *secondHypnosisView = [[Sec0503BNRHypnosisView alloc]initWithFrame:secondViewRect];
    [self.scrollView addSubview:secondHypnosisView];
    
    self.scrollView.contentSize = contentRect.size;
    [self.scrollView setPagingEnabled:YES];
}
@end
