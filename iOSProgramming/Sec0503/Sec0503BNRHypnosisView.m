//
//  Sec0503BNRHypnosisView.m
//  iOSProgramming
//
//  Created by palance on 15/9/1.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0503BNRHypnosisView.h"

@interface Sec0503BNRHypnosisView()
@property (strong, nonatomic)UIColor *circleColor;
@end

@implementation Sec0503BNRHypnosisView

#pragma mark - 初始化
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.circleColor = [UIColor lightGrayColor];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - 绘制
-(void)drawRect:(CGRect)rect
{
    CGPoint center;
    center.x = (self.bounds.origin.x + self.bounds.size.width) / 2.0;
    center.y = (self.bounds.origin.y + self.bounds.size.height) / 2.0;
    
    float maxRadius = hypot(self.bounds.size.width, self.bounds.size.height) / 2.0;
    
    UIBezierPath *path = [[UIBezierPath alloc]init];
    for (int radius=maxRadius; radius>0; radius-=20) {
        [path moveToPoint:CGPointMake(center.x + radius, center.y)];
        [path addArcWithCenter:center radius:radius startAngle:0 endAngle:M_PI * 2.0 clockwise:YES];
    }
    
    [self.circleColor setStroke];
    path.lineWidth = 10;
    [path stroke];
}

#pragma mark - 响应触摸消息
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.circleColor = randomColor;
}

-(void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}

@end
