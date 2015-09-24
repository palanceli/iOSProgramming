//
//  Sec0202NBRContainer.h
//  iOSProgramming
//
//  Created by palance on 15/8/30.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sec0202BNRItem.h"

@interface Sec0202BNRContainer : Sec0202BNRItem
+(instancetype)randomContainerWithChild:(int)count;
-(instancetype)init;
-(instancetype)initWithItemName:(NSString *)itemName serialNumber:(NSString *)serialNumber valueInDollars:(int)valueInDollars;
-(NSString*)description;
-(void)AddItem:(Sec0202BNRItem*)item;
@end
