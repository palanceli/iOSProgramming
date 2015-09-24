//
//  Sec0901BNRItemStore.m
//  iOSProgramming
//
//  Created by palance on 15/9/3.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0901BNRItemStore.h"
#import "Sec0901BNRItem.h"

@interface Sec0901BNRItemStore()
@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation Sec0901BNRItemStore
#pragma mark - 创建和初始化
+(instancetype)sharedStore
{
    static Sec0901BNRItemStore *sharedStore = nil;
    if (sharedStore == nil) {
        sharedStore = [[self alloc]initPrivate];
    }
    return sharedStore;
}

-(instancetype)initPrivate
{
    self = [super init];
    if (self) {
        self.privateItems = [[NSMutableArray alloc]init];
    }
    return self;
}

-(instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [BNRItemStore sharedStore]" userInfo:nil];
    return nil;
}

-(Sec0901BNRItem *)createItem
{
    Sec0901BNRItem *item = [Sec0901BNRItem randomItem];
    [self.privateItems addObject:item];
    return item;
}

-(void)removeItem:(Sec0901BNRItem *)item
{
    [self.privateItems removeObjectIdenticalTo:item];
}

-(void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    Sec0901BNRItem *item = self.privateItems[fromIndex];
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    [self.privateItems insertObject:item atIndex:toIndex];
}

-(NSArray *)allItems
{
    return self.privateItems;
}


@end
