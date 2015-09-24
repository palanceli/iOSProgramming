//
//  Sec1101BNRImageStore.m
//  iOSProgramming
//
//  Created by palance on 15/9/4.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import "Sec1101BNRImageStore.h"
@interface Sec1101BNRImageStore()
@property (nonatomic, strong)NSMutableDictionary *dictionary;
@end

@implementation Sec1101BNRImageStore
+(instancetype)sharedStore
{
    static Sec1101BNRImageStore *sharedStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedStore = [[self alloc]initPrivate];});
//    if (!sharedStore) {
//        sharedStore = [[Sec1101BNRImageStore alloc]initPrivate];
//    }
    return sharedStore;
}

-(instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc]init];
    }
    return self;
}

-(instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [BNRImageStore sharedStore]" userInfo:nil];
    return nil;
}

-(void)setImage:(UIImage *)image forKey:(NSString *)key
{
    self.dictionary[key] = image;
}

-(UIImage*)imageForKey:(NSString *)key
{
    return self.dictionary[key];
}

-(void)deleteImageForKey:(NSString *)key
{
    if (!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
}
@end
