//
//  Sec1301BNRLine.m
//  iOSProgramming
//
//  Created by palance on 15/9/8.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec1301BNRLine.h"

@implementation Sec1301BNRLine

-(instancetype)init
{
    self = [super init];
    if (self) {
        _lastEnd = [[NSDate alloc]init];
        _speed = 0;
    }
    return self;
}

-(void)setEnd:(CGPoint)end
{
    NSDate *now = [[NSDate alloc]init];
    self.speed = hypot((end.x - self.end.x), (end.y - self.end.y)) / [now timeIntervalSinceDate:self.lastEnd];
    NSLog(@"%f", self.speed);
    _end = end;
    _lastEnd = now;
}
@end
