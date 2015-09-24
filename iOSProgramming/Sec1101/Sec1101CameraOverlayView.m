//
//  Sec1101CameraOverlayView.m
//  iOSProgramming
//
//  Created by palance on 15/9/4.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec1101CameraOverlayView.h"

@implementation Sec1101CameraOverlayView

-(void)drawRect:(CGRect)rect
{
    CGPoint center;
    center.x = (self.bounds.origin.x + self.bounds.size.width) / 2.0;
    center.y = (self.bounds.origin.y + self.bounds.size.height) / 2.0;
    
    UIBezierPath *path = [[UIBezierPath alloc]init];
    [path moveToPoint:CGPointMake(center.x - 30, center.y)];
    [path addLineToPoint:CGPointMake(center.x + 30, center.y)];
    [path moveToPoint:CGPointMake(center.x, center.y - 50)];
    [path addLineToPoint:CGPointMake(center.x, center.y + 50)];
    path.lineWidth = 1;
    [[UIColor whiteColor]setStroke];
    [path stroke];
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return NO;
}
@end
