//
//  Sec1001BNRItem.m
//  iOSProgramming
//
//  Created by palance on 15/9/4.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec1001BNRItem.h"

@implementation Sec1001BNRItem

#pragma mark - 工厂函数
+(instancetype)randomItem
{
    NSString *itemName = [NSString stringWithFormat:@"%c%c%c", 'A' + arc4random() % 26, 'A' + arc4random() % 26, 'A' + arc4random() % 26];
    NSString *serialName = [NSString stringWithFormat:@"%c%c%c", 'A' + arc4random() % 26, '0' + arc4random() % 10, '0' + arc4random() % 10];
    int valueInDollars = arc4random() % 100;
    Sec1001BNRItem *item = [[Sec1001BNRItem alloc]initWithItemName:itemName serialNumber:serialName valueInDollars:valueInDollars];
    return item;
}

#pragma mark - 初始化函数
-(instancetype)initWithItemName:(NSString *)itemName serialNumber:(NSString *)serialNumber valueInDollars:(int)valueInDollars
{
    self = [super init];
    if (self) {
        _itemName = itemName;
        _serialNumber = serialNumber;
        _valueInDollars = valueInDollars;
        _dateCreated = [[NSDate alloc]init];
    }
    return self;
}

-(instancetype)init
{
    return [self initWithItemName:@"Item" serialNumber:@"Item" valueInDollars:0];
}


#pragma mark - utilities
-(NSString*)description
{
    NSDateFormatter *dsFormatter = [[NSDateFormatter alloc]init];
    [dsFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTimeString = [dsFormatter stringFromDate:self.dateCreated];
    
    NSString *descriptionString = [[NSString alloc]initWithFormat:@"%@ (%@):$%d, recorded on %@", self.itemName, self.serialNumber, self.valueInDollars, dateTimeString];
    return descriptionString;
}

@end
