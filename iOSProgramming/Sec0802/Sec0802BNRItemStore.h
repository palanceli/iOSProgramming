//
//  Sec0802BNRItemStore.h
//  iOSProgramming
//
//  Created by palance on 15/9/3.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Sec0802BNRItem;
@interface Sec0802BNRItemStore : NSObject

+(instancetype)sharedStore;
-(Sec0802BNRItem *)createItem;
-(NSArray*)allItems;
-(NSArray*)allItemsInSection:(NSInteger)section;

@end
