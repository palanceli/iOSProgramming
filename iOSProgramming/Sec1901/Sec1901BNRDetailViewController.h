//
//  Sec1901BNRDetailViewController.h
//  iOSProgramming
//
//  Created by palance on 15/9/26.
//  Copyright © 2015年 binglen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Sec1901BNRItem;

@interface Sec1901BNRDetailViewController : UIViewController


@property (strong, nonatomic) Sec1901BNRItem *item;
@property (nonatomic, copy)void (^dismissBlock)(void);

-(instancetype)initForNewItem:(BOOL)isNew;

@end
