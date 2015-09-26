//
//  Sec1901BNRItem.h
//  iOSProgramming
//
//  Created by palance on 15/9/26.
//  Copyright © 2015年 binglen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Sec1901BNRItem : NSObject <NSCoding>
@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, strong) NSDate* dateCreated;
@property (nonatomic, copy)NSString *itemKey;
@property (nonatomic, strong) UIImage *thumbnail;

+(instancetype)randomItem;

-(instancetype)init;
-(instancetype)initWithItemName:(NSString*)itemName serialNumber:(NSString*)serialNumber valueInDollars:(int)valueInDollars;

-(void)setThumbnailFromImage:(UIImage *)image;
@end
