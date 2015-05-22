//
//  BACoreData.h
//  BaseProject
//
//  Created by 任前辈 on 15-5-21.
//  Copyright (c) 2015年 Renqianbei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface BACoreData : NSObject

+(BACoreData*)coreData;

-(NSArray*)fetch:(NSString *)entityName
            sort:(NSArray *)sortDescriptors
       predicate:(NSPredicate*)predicate
 fetchResultType:(NSFetchRequestResultType)fetchResultType;

-(NSArray*)findObject:(NSString *)entityName Key:(NSString*)key Value:(id)value;


-(NSArray*)findObject:(NSString *)entityName withPredicate:(NSPredicate*)predicate;


-(void)saveItemWithDictionary:(NSDictionary*)dic entityName:(NSString *)entityName keyID:(NSString*)keyID;

-(void)deleteObject:(NSManagedObject*)obj;
-(void)deleteAllObjects:(NSString*)entityName;

-(void)deleteManagedObjects:(NSArray *)objects;

-(void)save;
@end
