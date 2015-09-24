//
//  Sec0901BNRItemStore.h
//  iOSProgramming
//
//  Created by palance on 15/9/3.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Sec0901BNRItem;

@interface Sec0901BNRItemStore : NSObject
+(instancetype)sharedStore;
-(Sec0901BNRItem *)createItem;
-(void)removeItem:(Sec0901BNRItem*)item;
-(void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
-(NSArray*)allItems;


@end
