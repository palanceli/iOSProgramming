//
//  Sec1101BNRImageStore.h
//  iOSProgramming
//
//  Created by palance on 15/9/4.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Sec1101BNRImageStore : NSObject
+(instancetype)sharedStore;

-(void)setImage:(UIImage*)image forKey:(NSString*)key;
-(UIImage*)imageForKey:(NSString*)key;
-(void)deleteImageForKey:(NSString*)key;
@end
