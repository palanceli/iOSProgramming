//
//  Sec1901BNRImageTransformer.m
//  iOSProgramming
//
//  Created by palance on 15/9/30.
//  Copyright © 2015年 binglen. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Sec1901BNRImageTransformer.h"

@implementation Sec1901BNRImageTransformer
+(Class)transformedValueClass
{
    return [NSData class];
}

-(id)transformedValue:(id)value
{
    if (!value) {
        return nil;
    }
    if ([value isKindOfClass:[NSData class]]) {
        return value;
    }
    return UIImagePNGRepresentation(value);
}

-(id)reverseTransformedValue:(id)value
{
    return [UIImage imageWithData:value];
}
@end
