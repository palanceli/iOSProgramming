//
//  Sec0202NBRContainer.m
//  iOSProgramming
//
//  Created by palance on 15/8/30.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0202BNRContainer.h"

@interface Sec0202BNRContainer()
{
    NSMutableArray *_subitems;
}
@end

@implementation Sec0202BNRContainer
#pragma mark - 工厂方法
+(instancetype)randomContainerWithChild:(int)count
{
    NSString *itemName = [NSString stringWithFormat:@"%c%c%c", 'A' + arc4random() % 26, 'A' + arc4random() % 26, 'A' + arc4random() % 26];
    NSString *serialName = [NSString stringWithFormat:@"%c%c%c", 'A' + arc4random() % 26, '0' + arc4random() % 10, '0' + arc4random() % 10];
    int valueInDollars = arc4random() % 100;
    Sec0202BNRContainer *container = [[Sec0202BNRContainer alloc]initWithItemName:itemName serialNumber:serialName valueInDollars:valueInDollars];
    for (int i=0; i<count; i++) {
        [container AddItem:[Sec0202BNRItem randomItem]];
    }
    return container;
}
#pragma mark - 初始化函数
-(instancetype)initWithItemName:(NSString *)itemName serialNumber:(NSString *)serialNumber valueInDollars:(int)valueInDollars
{
    self = [super initWithItemName:itemName serialNumber:serialNumber valueInDollars:valueInDollars];
    if (self) {
        _subitems = [[NSMutableArray alloc]init];
    }
    return self;
}

-(instancetype)init
{
    return [self initWithItemName:@"BNRContainer" serialNumber:@"BNRContainer" valueInDollars:0];
}
#pragma mark - getter/setter函数
-(NSMutableArray*)subitems
{
    return _subitems;
}

-(int)valueInDollars
{
    int v = super.valueInDollars;
    for (Sec0202BNRItem* item in self.subitems) {
        v += item.valueInDollars;
    }
    return v;
}

#pragma mark -
-(void)AddItem:(Sec0202BNRItem *)item
{
    [self.subitems addObject:item];
}

-(NSString*)description
{
    NSString* descriptionString = [self descriptionWithPreString:@""];
    NSLog(@"%@", descriptionString);
    return descriptionString;
}

-(NSString*)descriptionWithPreString:(NSString *)preString
{
    NSString* descriptionString = [NSString stringWithFormat:@"%@%@, $%d, total:$%d", preString, super.itemName, super.valueInDollars, self.valueInDollars];
    preString = [NSString stringWithFormat:@"\t%@", preString];
    for (Sec0202BNRItem *item in self.subitems) {
        descriptionString = [NSString stringWithFormat:@"%@\n%@", descriptionString, [item descriptionWithPreString:preString]];
    }
    return descriptionString;
}
@end
