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
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(clearCache:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

-(void)clearCache:(NSNotification *)note
{
    NSLog(@"flushing %lu images out of the cache", (unsigned long)[self.dictionary count]);
    [self.dictionary removeAllObjects];
}

-(instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [BNRImageStore sharedStore]" userInfo:nil];
    return nil;
}

-(NSString*)imagePathForKey:(NSString*)key
{
	NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDirectory = [documentDirectories firstObject];
	return [documentDirectory stringByAppendingPathComponent:key];
}

-(void)setImage:(UIImage *)image forKey:(NSString *)key
{
    self.dictionary[key] = image;
	
	// 获取保存图片的路径
	NSString *imagePath = [self imagePathForKey:key];
	
	// 从图片提取JPEG格式的数据
	NSData *data = UIImageJPEGRepresentation(image, 0.5);
	
	// 将JPEG个数的数据写入文件
	[data writeToFile:imagePath atomically:YES];
}

-(UIImage*)imageForKey:(NSString *)key
{
    UIImage *result = self.dictionary[key];
	if (!result) {
		NSString *imagePath = [self imagePathForKey:key];
		result = [UIImage imageWithContentsOfFile:imagePath];
		
		if (result) {
			self.dictionary[key] = result;
		}else{
			NSLog(@"Error: unable to find %@", imagePath);
		}
	}
	return result;
}

-(void)deleteImageForKey:(NSString *)key
{
    if (!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
	NSString *imagePath = [self imagePathForKey:key];
	[[NSFileManager defaultManager]removeItemAtPath:imagePath error:nil];
}
@end
