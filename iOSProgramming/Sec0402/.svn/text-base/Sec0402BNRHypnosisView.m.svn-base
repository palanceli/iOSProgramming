//
//  Sec0402BNRHypnosisView.m
//  iOSProgramming
//
//  Created by palance on 15/8/31.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0402BNRHypnosisView.h"
@interface Sec0402BNRHypnosisView()
@property (nonatomic, readwrite, strong) UIImage *logoImage;
@end

@implementation Sec0402BNRHypnosisView
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.logoImage = [UIImage imageNamed:@"苹果.png"];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CGPoint center;
    center.x = (self.bounds.origin.x + self.bounds.size.width) / 2.0;
    center.y = (self.bounds.origin.y + self.bounds.size.height) / 2.0;
    
    float maxRadius = hypot(self.bounds.size.width, self.bounds.size.height) / 2.0;
    // 绘制圆环
    UIBezierPath *path = [[UIBezierPath alloc]init];
    for (float radius = maxRadius; radius>0; radius -= 20) {
        [path moveToPoint:CGPointMake(center.x + radius, center.y)];
        [path addArcWithCenter:center radius:radius startAngle:0 endAngle:M_PI * 2.0 clockwise:YES];
    }
    
    path.lineWidth = 10;
    [[UIColor lightGrayColor]setStroke];
    [path stroke];
    
    // 绘制渐变三角
    UIBezierPath *trianglePath = [[UIBezierPath alloc]init];
    CGPoint p0 = CGPointMake(center.x - 100, center.y + 100);
    CGPoint p1 = CGPointMake(center.x + 100, center.y + 100);
    CGPoint p2 = CGPointMake(center.x, center.y - 100);
    [trianglePath moveToPoint:p0];
    [trianglePath addLineToPoint:p1];
    [trianglePath addLineToPoint:p2];
    [trianglePath closePath];
//    [trianglePath addLineToPoint:p0];
    [trianglePath stroke];
    
    // 绘制三角形的阴影
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    [trianglePath addClip];
    CGFloat locations[2] = {0.0, 1.0};
    CGFloat components[8] = {1.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0};
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);
    CGPoint startPoint = CGPointMake(center.x, center.y - 100);
    CGPoint endPoint = CGPointMake(center.x, center.y + 100);
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    CGContextRestoreGState(currentContext);
    
    // 绘制logo
    CGRect rectLogo = self.bounds;
    rectLogo.origin.x = center.x - 50;
    rectLogo.origin.y = center.y - 60;
    rectLogo.size.width = 100;
    rectLogo.size.height = 120;
    currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    CGContextSetShadow(currentContext, CGSizeMake(4, 7), 3); // 设置阴影
    [self.logoImage drawInRect:rectLogo];
    CGContextRestoreGState(currentContext);
}
@end
