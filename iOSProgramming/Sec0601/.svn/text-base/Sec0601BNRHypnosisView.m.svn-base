//
//  Sec0601BNRHypnosisView.m
//  iOSProgramming
//
//  Created by palance on 15/9/2.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0601BNRHypnosisView.h"

@implementation Sec0601BNRHypnosisView

-(void)drawRect:(CGRect)rect
{
    CGPoint center;
    center.x = (self.bounds.origin.x + self.bounds.size.width) / 2.0;
    center.y = (self.bounds.origin.y + self.bounds.size.height) / 2.0;
    
    float maxRadius = hypot(self.bounds.size.width, self.bounds.size.height) / 2.0;
    
    UIBezierPath *path = [[UIBezierPath alloc]init];
    for (int radius=maxRadius; radius>0; radius -= 20) {
        [path moveToPoint:CGPointMake(center.x + radius, center.y)];
        [path addArcWithCenter:center radius:radius startAngle:0 endAngle:M_PI * 2.0 clockwise:YES];
    }
    path.lineWidth = 10;
    
    [[UIColor lightGrayColor]setStroke];
    [path stroke];
}
@end
