//
//  Sec1101BNRItem.m
//  iOSProgramming
//
//  Created by palance on 15/9/4.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec1101BNRItem.h"

@implementation Sec1101BNRItem

#pragma mark - 存取函数
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.itemName forKey:@"itemName"];
    [aCoder encodeObject:self.serialNumber forKey:@"serialNumber"];
    [aCoder encodeObject:self.dateCreated forKey:@"dateCreated"];
    [aCoder encodeObject:self.itemKey forKey:@"itemKey"];
    [aCoder encodeInt:self.valueInDollars forKey:@"valueInDollars"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _itemName = [aDecoder decodeObjectForKey:@"itemName"];
        _serialNumber = [aDecoder decodeObjectForKey:@"serialNumber"];
        _dateCreated = [aDecoder decodeObjectForKey:@"dateCreated"];
        _itemKey = [aDecoder decodeObjectForKey:@"itemKey"];
        _valueInDollars = [aDecoder decodeIntForKey:@"valueInDollars"];
    }
    return self;
}
#pragma mark - 工厂函数
+(instancetype)randomItem
{
    NSString *itemName = [NSString stringWithFormat:@"%c%c%c", 'A' + arc4random() % 26, 'A' + arc4random() % 26, 'A' + arc4random() % 26];
    NSString *serialName = [NSString stringWithFormat:@"%c%c%c", 'A' + arc4random() % 26, '0' + arc4random() % 10, '0' + arc4random() % 10];
    int valueInDollars = arc4random() % 100;
    Sec1101BNRItem *item = [[Sec1101BNRItem alloc]initWithItemName:itemName serialNumber:serialName valueInDollars:valueInDollars];
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
        
        NSUUID *uuid = [[NSUUID alloc]init];
        NSString *key = [uuid UUIDString];
        _itemKey = key;
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
