//
//  Sec0702ViewController.m
//  iOSProgramming
//
//  Created by palance on 15/9/3.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0702ViewController.h"
#import "Sec0702BNRHypnosisView.h"

@interface Sec0702ViewController() <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) Sec0702BNRHypnosisView *contentView;
@end

@implementation Sec0702ViewController
-(void)viewDidLoad
{
    CGRect contentRect = self.view.bounds;
    contentRect.size.width *= 2;
    contentRect.size.height *= 2;
    
    self.scrollView.contentSize = contentRect.size;
    
    self.contentView = [[Sec0702BNRHypnosisView alloc]initWithFrame:contentRect];
    [self.scrollView addSubview:self.contentView];
    
    self.scrollView.minimumZoomScale = 0.5;
    self.scrollView.maximumZoomScale = 2;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    NSLog(@"Zooming...");
    return self.contentView;
}
@end
