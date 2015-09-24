//
//  Sec0602BNRHypnosisView.m
//  iOSProgramming
//
//  Created by palance on 15/9/3.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0602BNRHypnosisView.h"
@interface Sec0602BNRHypnosisView()
@property (nonatomic, strong) UIColor *circleColor;
@end

@implementation Sec0602BNRHypnosisView
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.circleColor = [UIColor redColor];
    }
    return self;
}

-(void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}

- (IBAction)segmentedViewChanged:(id)sender
{
    UISegmentedControl * segmentedControl = sender;
    if(segmentedControl.selectedSegmentIndex == 0){
        self.circleColor = [UIColor redColor];
    }else if(segmentedControl.selectedSegmentIndex == 1){
        self.circleColor = [UIColor greenColor];
    }else if(segmentedControl.selectedSegmentIndex == 2){
        self.circleColor = [UIColor blueColor];
    }
}

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
@end
