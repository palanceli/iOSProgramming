//
//  Sec1901BNRItemStore.m
//  iOSProgramming
//
//  Created by palance on 15/9/26.
//  Copyright © 2015年 binglen. All rights reserved.
//

#import "Sec1901BNRItemStore.h"
#import "Sec1901BNRItem.h"
#import "Sec1901BNRImageStore.h"
@import CoreData;

@interface Sec1901BNRItemStore()
@property (nonatomic) NSMutableArray *privateItems;
@property (nonatomic, strong) NSMutableArray *allAssetTypes;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *model;
@end

@implementation Sec1901BNRItemStore

#pragma mark - 存取函数
-(NSString *)itemArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:@"Sec1901.db"];
}

-(BOOL)saveChanges
{
//    NSString *path = [self itemArchivePath];
//    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
    NSError *error;
    BOOL successful = [self.context save:&error];
    if (!successful) {
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }
    return successful;
}

-(void)loadAllItems
{
    if (!self.privateItems) {
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        NSEntityDescription *e = [NSEntityDescription entityForName:@"Sec1901BNRItem" inManagedObjectContext:self.context];
        request.entity = e;
        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"orderingValue" ascending:YES];
        request.sortDescriptors = @[sd];
        
        NSError *error;
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed" format:@"reasong: %@", [error localizedDescription]];
        }
        self.privateItems = [[NSMutableArray alloc]initWithArray:result];
    }
}

#pragma mark - 创建和初始化
+(instancetype)sharedStore
{
    static Sec1901BNRItemStore *sharedStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{sharedStore = [[self alloc]initPrivate];});
    
    //    if (sharedStore == nil) {
    //        sharedStore = [[self alloc]initPrivate];
    //    }
    return sharedStore;
}

-(instancetype)initPrivate
{
    self = [super init];
    if (self) {
//        //        self.privateItems = [[NSMutableArray alloc]init];
//        NSString *path = [self itemArchivePath];
//        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
//        // 如果之前没有保存过privateItems，就创建一个新的
//        if (!_privateItems) {
//            _privateItems = [[NSMutableArray alloc]init];
//        }
        // 读取xcdatamodeld
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:_model];
        
        // 设置SQLite文件路径
        NSString *path = [self itemArchivePath];
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        
        NSError *error = nil;
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            @throw [NSException exceptionWithName:@"OpenFailure" reason:[error localizedDescription] userInfo:nil];
        }
        // 创建NSManagedObjectContext对象
        _context = [[NSManagedObjectContext alloc]init];
        _context.persistentStoreCoordinator = psc;
        
        [self loadAllItems];
    }
    return self;
}

-(instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [BNRItemStore sharedStore]" userInfo:nil];
    return nil;
}

-(Sec1901BNRItem *)createItem
{
    double order;
    if ([self.allItems count] == 0) {
        order = 1.0;
    }else {
        order = [[self.privateItems lastObject] orderingValue] + 1.0;
    }
    NSLog(@"Adding after %lu items, order = %.2f", (unsigned long)[self.privateItems count], order);
    
    Sec1901BNRItem *item = [NSEntityDescription insertNewObjectForEntityForName:@"Sec1901BNRItem" inManagedObjectContext:self.context];
    item.orderingValue = order;
    
    [self.privateItems addObject:item];
    return item;
}

-(void)removeItem:(Sec1901BNRItem *)item
{
    NSString *key = item.itemKey;
    [[Sec1901BNRImageStore sharedStore]deleteImageForKey:key];
    [self.context deleteObject:item];
    [self.privateItems removeObjectIdenticalTo:item];
}

-(void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    Sec1901BNRItem *item = self.privateItems[fromIndex];
    [self.privateItems removeObjectAtIndex:fromIndex];
    
    [self.privateItems insertObject:item atIndex:toIndex];
    
    // 为移动的Sec1901BNRItem对象计算新的orderValue
    double lowerBound = 0.0;
    if (toIndex > 0) {
        lowerBound = [self.privateItems[(toIndex - 1)] orderingValue];
    }else{
        lowerBound = [self.privateItems[1] orderingValue] - 2.0;
    }
    
    double upperBound = 0.0;
    
    // 在数组中，该对象之后是否有其他对象？
    if (toIndex < [self.privateItems count] - 1) {
        upperBound = [self.privateItems[toIndex + 1] orderingValue];
    }else{
        upperBound = [self.privateItems[(toIndex - 1)] orderingValue] + 2.0;
    }
    double newOrderValue = (lowerBound + upperBound) / 2.0;
    
    NSLog(@"moving to order %f", newOrderValue);
    item.orderingValue = newOrderValue;
}

-(NSArray *)allItems
{
    return self.privateItems;
}

-(NSArray *)allAssetTypes
{
    if (!_allAssetTypes) {
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        
        NSEntityDescription *e = [NSEntityDescription entityForName:@"Sec1901BNRAssetType" inManagedObjectContext:self.context];
        request.entity = e;
        
        NSError *error = nil;
        NSArray *result = [self.context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
        }
        _allAssetTypes = [result mutableCopy];
    }
    
    // 第一次运行？
    if ([_allAssetTypes count] == 0) {
        NSManagedObject *type;
        type = [NSEntityDescription insertNewObjectForEntityForName:@"Sec1901BNRAssetType" inManagedObjectContext:self.context];
        [type setValue:@"Furniture" forKey:@"label"];
        [_allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"Sec1901BNRAssetType" inManagedObjectContext:self.context];
        [type setValue:@"Jweelry" forKey:@"label"];
        [_allAssetTypes addObject:type];
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"Sec1901BNRAssetType" inManagedObjectContext:self.context];
        [type setValue:@"Electronics" forKey:@"label"];
        [_allAssetTypes addObject:type];
    }
    return _allAssetTypes;
}

@end
