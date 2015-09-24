//
//  Sec0801BNRItemStore.m
//  iOSProgramming
//
//  Created by palance on 15/9/3.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0801BNRItemStore.h"
#import "Sec0801BNRItem.h"

@interface Sec0801BNRItemStore()
@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation Sec0801BNRItemStore
#pragma mark - 创建和初始化
+(instancetype)sharedStore
{
    static Sec0801BNRItemStore *sharedStore = nil;
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

-(Sec0801BNRItem *)createItem
{
    Sec0801BNRItem *item = [Sec0801BNRItem randomItem];
    [self.privateItems addObject:item];
    return item;
}

-(NSArray *)allItems
{
    return self.privateItems;
}
@end
