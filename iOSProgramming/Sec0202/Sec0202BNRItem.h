//
//  BNRItem.h
//  iOSProgramming
//
//  Created by palance on 15/8/30.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sec0202BNRItem : NSObject
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
-(NSString*)descriptionWithPreString:(NSString*)preString;

@end
