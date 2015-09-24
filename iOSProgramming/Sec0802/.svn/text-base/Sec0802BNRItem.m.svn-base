//
//  Sec0802BNRItem.m
//  iOSProgramming
//
//  Created by palance on 15/9/3.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec0802BNRItem.h"

@implementation Sec0802BNRItem

#pragma mark - 工厂函数
+(instancetype)randomItem
{
    NSString *itemName = [NSString stringWithFormat:@"%c%c%c", 'A' + arc4random() % 26, 'A' + arc4random() % 26, 'A' + arc4random() % 26];
    NSString *serialName = [NSString stringWithFormat:@"%c%c%c", 'A' + arc4random() % 26, '0' + arc4random() % 10, '0' + arc4random() % 10];
    int valueInDollars = arc4random() % 100;
    Sec0802BNRItem *item = [[Sec0802BNRItem alloc]initWithItemName:itemName serialNumber:serialName valueInDollars:valueInDollars];
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

#pragma mark - 存取函数
-(void)setItemName:(NSString *)itemName
{
    _itemName = itemName;
}

-(NSString*)itemName
{
    return _itemName;
}

-(void)setSerialNumber:(NSString *)serialName
{
    _serialNumber = serialName;
}
-(NSString*)serialNumber
{
    return _serialNumber;
}

-(void)setValueInDollars:(int)valueInDollars
{
    _valueInDollars = valueInDollars;
}
-(int)valueInDollars
{
    return _valueInDollars;
}

-(NSDate*)dateCreated
{
    return _dateCreated;
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
