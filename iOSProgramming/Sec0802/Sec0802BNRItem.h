//
//  Sec0802BNRItem.h
//  iOSProgramming
//
//  Created by palance on 15/9/3.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sec0802BNRItem : NSObject
{
    NSString *_itemName;
    NSString *_serialNumber;
    int _valueInDollars;
    NSDate *_dateCreated;
}

+(instancetype)randomItem;

-(instancetype)init;
-(instancetype)initWithItemName:(NSString*)itemName serialNumber:(NSString*)serialNumber valueInDollars:(int)valueInDollars;


-(void)setItemName:(NSString*)itemName;
-(NSString*) itemName;

-(void)setSerialNumber:(NSString*)serialName;
-(NSString*)serialNumber;

-(void)setValueInDollars:(int)valueInDollars;
-(int)valueInDollars;

-(NSDate*)dateCreated;

-(NSString*)description;


@end
