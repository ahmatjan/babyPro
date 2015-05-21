//
//  BACoreData.m
//  BaseProject
//
//  Created by 任前辈 on 15-5-21.
//  Copyright (c) 2015年 Renqianbei. All rights reserved.
//
//

#define SQLITE_DB_NAME   @"bacoreDataDB.sqlite"

#import "BACoreData.h"
#import <CoreData/CoreData.h>

@interface BACoreData()
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end


@implementation BACoreData

+(BACoreData*)coreData{
    
  static  BACoreData * shareCoreData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareCoreData = [[BACoreData alloc] init];
        
    });
    
    return shareCoreData;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        
        [self initCoreData];
        
    }
    return self;
}

-(void)saveItemWithDictionary:(NSDictionary*)dic entityName:(NSString *)entityName keyID:(NSString*)keyID
{
    NSArray *arr = nil;
    if (keyID) {
        NSString* strID = [dic objectForKey:keyID];
        if (strID)
        {
            arr = [self findObject:entityName Key:keyID Value:strID];
        }
    }
    
    
    NSManagedObject* obj;
    if (arr && ([arr count] > 0))
    {
        obj = [arr objectAtIndex:0];
    }
    else
    {
        obj = [self insertNewObject:entityName];
    }
    
    if (obj)
    {
        NSEnumerator *enumerator = [dic keyEnumerator];
        id key;
        while ((key = [enumerator nextObject]))
        {
            id value = [dic objectForKey:key];
            if(value)
            {
                [obj setValue:value forKey:key];
            }
        }
        
        [self save];
    }
    
}


-(NSManagedObject*)insertNewObject:(NSString*)entityName
{
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.context];
}


-(NSArray*)findObject:(NSString *)entityName withPredicate:(NSPredicate*)predicate
{
    return [self fetch:entityName
               sortKey:nil
             ascending:NO
             predicate:predicate];
}


-(NSArray*)findObject:(NSString *)entityName Key:(NSString*)key Value:(id)value
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:
                              @"%K == %@",key,value];
    
    return [self fetch:entityName
               sortKey:nil
             ascending:NO
             predicate:predicate];
    
}

-(NSArray*)fetch:(NSString *)entityName
         sortKey:(NSString *)key
       ascending:(BOOL)asc
       predicate:(NSPredicate*)predicate
{
    
    
    // Init a fetch request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = nil;
    if (key)
    {
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:asc selector:nil];
        NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
        [fetchRequest setSortDescriptors:descriptors];
    }
    
    if (predicate)
    {
        fetchRequest.predicate = predicate;
    }
    NSError *error;
    NSArray *objects = [[self _manageObjectcontext] executeFetchRequest:fetchRequest error:&error];

    
    
    return objects ;
}

-(void)deleteManagedObjects:(NSArray *)objects
{
    if (objects && [objects count]>0)
    {
        for (NSManagedObject *oneLine in objects)
        {
            [[self _manageObjectcontext] deleteObject:oneLine];
        }
    }
    [self save];
}

-(void)deleteAllObjects:(NSString*)entityName
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entityDescription = [NSEntityDescription entityForName:entityName
                                                          inManagedObjectContext:self.context];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *objects = [[self _manageObjectcontext] executeFetchRequest:request error:&error];
    
    if (objects)
    {
        for (NSManagedObject *oneLine in objects)
        {
            [[self _manageObjectcontext] deleteObject:oneLine];
        }
    }
    else
        NSLog(@"error");
    
    
    [self save];
}


#pragma mark---privatemethod

-(void)initCoreData{
    
    NSString * dirPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/DataBase"];
//    NSString * dirPath11 =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] ;
    
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    BOOL exists = [fm fileExistsAtPath:dirPath isDirectory:&isDirectory];
    if (!exists)
    {
        [fm createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString * storePath = [dirPath stringByAppendingPathComponent:SQLITE_DB_NAME];
    
    bool bInitDB = false;
    // set up the backing store
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // If the expected store doesn't exist, copy the default store.
    bInitDB = [fileManager fileExistsAtPath:storePath];
    
    NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
    
    NSDictionary *options=[NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption,
                           [NSNumber numberWithBool:YES],NSInferMappingModelAutomaticallyOption,
                           nil];
    NSError *error = nil;

    NSPersistentStore * returnRes = [[self _persistentStoreCoordinator] addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error];
    
    if (returnRes) {
        [[self context] setPersistentStoreCoordinator:[self _persistentStoreCoordinator]];
        
        if (!bInitDB) {
            [self save];
        }
    }
    
}

-(void)save
{
    NSError *error;
    if (![[self _manageObjectcontext] save:&error])
        return;
    //      bafLog("error");
}

-(NSManagedObjectContext *)_manageObjectcontext{
    
    if (self.context == nil) {
        self.context = [[NSManagedObjectContext alloc] init];
    }
    return self.context;
}



-(NSManagedObjectModel*)_managedObjectModel{
    
    if (self.managedObjectModel == nil) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
        self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }

    
    return self.managedObjectModel;
}


-(NSPersistentStoreCoordinator *)_persistentStoreCoordinator{
    
    if (self.persistentStoreCoordinator == nil) {
        self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self _managedObjectModel]];
        
    }
    
    
    return self.persistentStoreCoordinator;
}
@end
