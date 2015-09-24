//
//  Sec1101BNRItemStore.h
//  iOSProgramming
//
//  Created by palance on 15/9/4.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Sec1101BNRItem;

@interface Sec1101BNRItemStore : NSObject

+(instancetype)sharedStore;
-(Sec1101BNRItem *)createItem;
-(void)removeItem:(Sec1101BNRItem*)item;
-(void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
-(NSArray*)allItems;
-(BOOL)saveChanges;

@end
