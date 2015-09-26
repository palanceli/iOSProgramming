//
//  Sec1901BNRItemCell.m
//  iOSProgramming
//
//  Created by palance on 15/9/26.
//  Copyright © 2015年 binglen. All rights reserved.
//

#import "Sec1901BNRItemCell.h"

@implementation Sec1901BNRItemCell
- (IBAction)showImage:(id)sender {
    // 调用Block对象之前要检查Block对象是否存在
    if (self.actionBlock) {
        self.actionBlock();
    }
}

@end
