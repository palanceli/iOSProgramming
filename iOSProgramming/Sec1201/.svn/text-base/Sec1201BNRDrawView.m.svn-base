//
//  Sec1201BNRDrawView.m
//  iOSProgramming
//
//  Created by palance on 15/9/6.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec1201BNRDrawView.h"
#import "Sec1201BNRLine.h"

@interface Sec1201BNRDrawView()
@property (nonatomic, strong) NSMutableDictionary *linesInProgress;
@property (nonatomic, strong) NSMutableArray *finishedLines;
@property (nonatomic, strong) NSMutableSet *pressedTouches;
@end

@implementation Sec1201BNRDrawView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.linesInProgress = [[NSMutableDictionary alloc]init];
        self.finishedLines = [[NSMutableArray alloc]init];
        self.pressedTouches = [[NSMutableSet alloc]init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
    }
    return self;
}

-(void)strokeLine:(Sec1201BNRLine*)line
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    if (line.end.x > line.begin.x) {
        if (line.end.y > line.begin.y) {
            [[UIColor redColor]set];
        }else{
            [[UIColor yellowColor]set];
        }
    }else{
        if (line.end.y > line.begin.y) {
            [[UIColor blueColor]set];
        }else{
            [[UIColor greenColor]set];
        }
    }
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}

-(void)drawRect:(CGRect)rect
{
	if (self.pressedTouches.count == 2) {
        NSArray *allTouches = self.pressedTouches.allObjects;
        UITouch *t1 = allTouches[0];
        UITouch *t2 = allTouches[1];
        CGPoint p1 = [t1 locationInView:self];
        CGPoint p2 = [t2 locationInView:self];
        CGPoint center = CGPointMake((p1.x + p2.x) / 2.0, (p1.y + p2.y) / 2.0);
        float radius = hypot((p1.x - p2.x), (p1.y - p2.y)) / 2.0;
		UIBezierPath *path = [[UIBezierPath alloc]init];
		[path addArcWithCenter:center radius:radius startAngle:0 endAngle:M_PI * 2.0 clockwise:YES];
		path.lineWidth = 10;
		[[UIColor redColor]set];
		[path stroke];
	}else{
		for (NSValue *key in self.linesInProgress) {
			[self strokeLine:self.linesInProgress[key]];
		}
    }
    for (Sec1201BNRLine *line in self.finishedLines) {
        [self strokeLine:line];
    }
}

#pragma mark - 响应触摸消息
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"touchesBegan touches.count=%lu", (unsigned long)touches.count);
    for (UITouch *t in touches) {
        [self.pressedTouches addObject:t];
    }
    
    for (UITouch *t in touches) {
        CGPoint location = [t locationInView:self];
        
        Sec1201BNRLine *line = [[Sec1201BNRLine alloc]init];
        line.begin = location;
        line.end = location;
        
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = line;
    }
	
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"touchesMoved touches.count=%lu", touches.count);
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        Sec1201BNRLine *line = self.linesInProgress[key];
        line.end = [t locationInView:self];
    }
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"touchesEnded");
    NSInteger count = self.pressedTouches.count;
    
    for (UITouch *t in touches) {
        [self.pressedTouches removeObject:t];
    }
    
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        if (count != 2) {
            Sec1201BNRLine *line = self.linesInProgress[key];
            [self.finishedLines addObject:line];
        }
        [self.linesInProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        [self.linesInProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}
@end
