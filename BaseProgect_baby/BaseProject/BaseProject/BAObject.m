//
//  BAObject.m
//  BaseProject
//
//  Created by 任前辈 on 15-5-21.
//  Copyright (c) 2015年 Renqianbei. All rights reserved.
//

#import "BAObject.h"
#import "BACoreData.h"
#import <Mantle/Mantle.h>
#import "NSObject+BAExtensions.h"
@implementation BAObject

-(NSString *)keyID{
    return nil;
}


//从数据库获取对应类的数组

+ (NSArray *)searchforKey:(NSString *)key Value:(id)object{
    
    NSArray * manageObjects = nil;
    if (key) {
        manageObjects = [[BACoreData coreData]  findObject:[NSString stringWithFormat:@"%@Entity",NSStringFromClass([self class])] Key:key Value:object];
    }
    else{
        manageObjects = [[BACoreData coreData] findObject:[NSString stringWithFormat:@"%@Entity",NSStringFromClass([self class])] withPredicate:nil];
    }
    
    return  [self changeToModel:manageObjects];

}


+ (NSArray *)searchforPredicate:(NSPredicate *)predicate{
    
    NSArray *  manageObjects = [[BACoreData coreData] findObject:[NSString stringWithFormat:@"%@Entity",NSStringFromClass([self class])] withPredicate:predicate];
    
    return  [self changeToModel:manageObjects];

}

//只有设置了 modelkey 才会被保存
- (void)save{
    
    [[BACoreData coreData] saveItemWithDictionary:[self toDictionary] entityName:[NSString stringWithFormat:@"%@Entity",NSStringFromClass([self class])] keyID:[self keyID]];

}

- (void)deleteself{
    if (self.keyID) {
        [self delete_key:self.keyID value:[self valueForKey:self.keyID]];
    }
    
}

- (void)delete_key:(NSString*)key value:(NSString*)value{
    
   NSArray *ary = [[BACoreData coreData] findObject:[NSString stringWithFormat:@"%@Entity",NSStringFromClass([self class])] Key:key Value:value];
   
    if (ary && ([ary count] > 0))
    {
        for (NSManagedObject* obj in ary)
        {
            [[BACoreData coreData] deleteObject:obj];
        }
        
        [[BACoreData coreData] save];
    }

}

/**
 *  删除内容根据predicate
 *
 *  @param predicate 条件
 */
+(void)deleteforPredicate:(NSPredicate *)predicate{
    
   NSArray *ary = [[BACoreData coreData] findObject:[NSString stringWithFormat:@"%@Entity",NSStringFromClass([self class])] withPredicate:predicate];
   
    if (ary && ([ary count] > 0))
    {
        for (NSManagedObject* obj in ary)
        {
            [[BACoreData coreData] deleteObject:obj];
        }
        
        [[BACoreData coreData] save];
    }

}



+(int)localNums:(NSPredicate*)predicate{
    
    int rtv = 0;
    NSArray* ary = [[BACoreData coreData] fetch:[NSString stringWithFormat:@"%@Entity",NSStringFromClass([self class])] sort:nil predicate:predicate fetchResultType:NSCountResultType];
    
    if (ary && ([ary count] > 0))
    {
        NSNumber* num = [ary objectAtIndex:0];
        if ([num isKindOfClass:[NSNumber class]])
        {
            rtv = [num intValue];
        }
    }
    return rtv;

}



#pragma mark---private



+(NSArray *)changeToModel:(NSArray *)ary{
    
    if (ary && ([ary count] > 0))
    {
        NSMutableArray *chatArray = [NSMutableArray array];
        for (NSDictionary* dic in ary)
        {
            id  mm  = [[self alloc] init];
            [mm fromDictionary:dic];
            [chatArray addObject:mm];
        }
        
        return chatArray;
    }
    return [NSArray array];}




//-(NSString*)get_property_class_name:(objc_property_t)property
//{
//    NSString *propertyInfo = [[NSString alloc] initWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
//    
//    NSString *stringBetweenBrackets = nil;
//    NSScanner *scanner = [NSScanner scannerWithString:propertyInfo];
//    [scanner scanUpToString:@"T@\"" intoString:nil];
//    [scanner scanString:@"T@\"" intoString:nil];
//    [scanner scanUpToString:@"\"" intoString:&stringBetweenBrackets];
//    //NSLog(@"%@",stringBetweenBrackets);
//    
//    [propertyInfo release];
//    
//    return stringBetweenBrackets;
//}


@end
