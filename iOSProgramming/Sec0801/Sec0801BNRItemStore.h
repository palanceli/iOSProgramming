//
//  Sec0801BNRItemStore.h
//  iOSProgramming
//
//  Created by palance on 15/9/3.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Sec0801BNRItem;

@interface Sec0801BNRItemStore : NSObject
+(instancetype)sharedStore;
-(Sec0801BNRItem *)createItem;
-(NSArray*)allItems;
@end
