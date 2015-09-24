//
//  Sec1101BNRItem.h
//  iOSProgramming
//
//  Created by palance on 15/9/4.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sec1101BNRItem : NSObject <NSCoding>
@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, strong) NSDate* dateCreated;
@property (nonatomic, copy)NSString *itemKey;

+(instancetype)randomItem;

-(instancetype)init;
-(instancetype)initWithItemName:(NSString*)itemName serialNumber:(NSString*)serialNumber valueInDollars:(int)valueInDollars;

@end
