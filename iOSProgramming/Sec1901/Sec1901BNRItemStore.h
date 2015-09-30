//
//  Sec1901BNRItemStore.h
//  iOSProgramming
//
//  Created by palance on 15/9/26.
//  Copyright © 2015年 binglen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Sec1901BNRItem;

@interface Sec1901BNRItemStore : NSObject

+(instancetype)sharedStore;
-(Sec1901BNRItem *)createItem;
-(void)removeItem:(Sec1901BNRItem*)item;
-(void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
-(NSArray*)allItems;
-(BOOL)saveChanges;
-(NSArray *)allAssetTypes;

@end
