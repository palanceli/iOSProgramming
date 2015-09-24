//
//  Sec0802BNRItemStore.m
//  iOSProgramming
//
//  Created by palance on 15/9/3.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0802BNRItemStore.h"
#import "Sec0802BNRItem.h"

@interface Sec0802BNRItemStore()
@property (nonatomic) NSMutableArray *privateItems;

@end


@implementation Sec0802BNRItemStore

#pragma mark - 创建和初始化
+(instancetype)sharedStore
{
    static Sec0802BNRItemStore *sharedStore = nil;
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

-(Sec0802BNRItem *)createItem
{
    Sec0802BNRItem *item = [Sec0802BNRItem randomItem];
    [self.privateItems addObject:item];
    return item;
}

-(NSArray *)allItems
{
    return self.privateItems;
}

-(NSArray*)allItemsInSection:(NSInteger)section
{
    NSPredicate *predict = nil;
    if (section == 0) {
        predict = [NSPredicate predicateWithFormat:@"valueInDollars<=50"];
    }else if(section == 1){
        predict = [NSPredicate predicateWithFormat:@"valueInDollars>50"];
    }else{
        return nil;
    }
    return [self.privateItems filteredArrayUsingPredicate:predict];
}

@end
