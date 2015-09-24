//
//  Sec1001BNRItemStore.h
//  iOSProgramming
//
//  Created by palance on 15/9/4.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Sec1001BNRItem;

@interface Sec1001BNRItemStore : NSObject

+(instancetype)sharedStore;
-(Sec1001BNRItem *)createItem;
-(void)removeItem:(Sec1001BNRItem*)item;
-(void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
-(NSArray*)allItems;

@end
