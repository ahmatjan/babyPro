//
//  NSObject+BAExtensions.m
//  BaseProject
//
//  Created by 任前辈 on 15-5-21.
//  Copyright (c) 2015年 Renqianbei. All rights reserved.
//

#import "NSObject+BAExtensions.h"
#import <objc/runtime.h>

@implementation  NSObject (BAExtensions)
-(NSArray *)ignoreProperties{
    
    return nil;
    
}



-(NSString*)get_property_class_name:(objc_property_t)property
{
    NSString *propertyInfo = [[NSString alloc] initWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
    
    NSString *stringBetweenBrackets = nil;
    NSScanner *scanner = [NSScanner scannerWithString:propertyInfo];
    [scanner scanUpToString:@"T@\"" intoString:nil];
    [scanner scanString:@"T@\"" intoString:nil];
    [scanner scanUpToString:@"\"" intoString:&stringBetweenBrackets];
    //NSLog(@"%@",stringBetweenBrackets);
    
    
    return stringBetweenBrackets;
}


-(NSDictionary *)analysisToDictionary{
    
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    [self setproperti:properties andcount:outCount andDic:props andIgnore:NO];
    free(properties);
    return props;
    
    
}



//不包括其父类的属性
-(NSDictionary *)toDictionary
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    [self setproperti:properties andcount:outCount andDic:props andIgnore:YES];
    free(properties);
    return props;
}




//包括其所有父类的属性
-(NSDictionary *)toAllDictionary
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount;
    
    Class cla = [self class];
    
    do {
        objc_property_t *properties = class_copyPropertyList(cla, &outCount);
        
        [self setproperti:properties andcount:outCount andDic:props andIgnore:YES];
        
        free(properties);
        
        cla = [cla superclass];//便利所有父类的属性 直到nsobject
        
    } while (![NSStringFromClass(cla) isEqualToString:NSStringFromClass([NSObject class])]);
    
    
    return props;
}


-(void)setproperti:(objc_property_t * )properties andcount:(unsigned int)outCount andDic:(NSMutableDictionary *)props andIgnore:(BOOL)ignore
{
    
    for (int i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        if (ignore) {
            if ([[self ignoreProperties] containsObject:propertyName]) {
                continue; //字典转换 忽视属性
            }
        }
        
        if (![propertyName hasPrefix:@"__"])
        {
            id propertyValue = [self valueForKey:(NSString *)propertyName];
            if (propertyValue)
            {
                if ([propertyValue isKindOfClass:[NSString class]])
                {
                    [props setObject:propertyValue forKey:propertyName];
                }
                else if ([propertyValue isKindOfClass:[NSNumber class]])
                {
                    [props setObject:propertyValue forKey:propertyName];
                }
                else if ([propertyValue isKindOfClass:[NSDate class]])
                {
                    [props setObject:propertyValue forKey:propertyName];
                }
                else
                {
                    
                }
                
            }
            
        }
        
    }
    
}
















//主要用来解析
-(id)analysisfromDictionary:(NSDictionary*)dicRoot{
    
    return  [self modelWithDic:dicRoot andIgnore:NO];
    
}

//主要用来存库 加了可忽视字段方法
-(id)fromDictionary:(NSDictionary*)dicRoot{
    
    return  [self modelWithDic:dicRoot andIgnore:YES];
}


-(id)modelWithDic:(NSDictionary *)dicRoot andIgnore:(BOOL)ignore{
    
    {
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList([self class], &outCount);
        
        for (i = 0; i < outCount; i++)
        {
            objc_property_t property = properties[i];
            NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            NSString *propertyClassName = [self get_property_class_name:property];
            
            if (ignore) {
                if ([[self ignoreProperties] containsObject:propertyName]) {
                    continue; //字典转换 忽视属性
                }
            }
            //NSLog(@"-->%@",propertyClassName);
            if (![propertyName hasPrefix:@"__"])
            {
                id propertyValue = [dicRoot valueForKey:propertyName];
                if (propertyValue == nil){
                    if ([propertyName isEqualToString:@"uid"])
                    {
                        propertyValue = [dicRoot valueForKey:@"id"];
                    }else if ([propertyName isEqualToString:@"user_id"]){
                        propertyValue = [dicRoot valueForKey:@"id"];
                    }
                    
                }
                if (propertyValue){
                    if ([propertyValue isKindOfClass:[NSDictionary class]])
                    {
                        if ([propertyClassName hasPrefix:@"Dictionary_"])
                        {
                            NSString* dicItemClassName = [propertyClassName substringFromIndex:[@"Dictionary_" length]];
                            NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
                            
                            NSArray* allkeys = [propertyValue allKeys];
                            for (NSString* key  in allkeys)
                            {
                                id value = [propertyValue objectForKey:key];
                                
                                if ([value isKindOfClass:[NSDictionary class]])
                                {
                                    Class cls = NSClassFromString(dicItemClassName);
                                    if (cls)
                                    {
                                        NSObject* obj = (NSObject*)[[cls alloc] init];
                                        [obj fromDictionary:value];
                                        [dic setObject:obj forKey:key];
                                    }
                                }
                                else
                                {
                                    [dic setObject:value forKey:key];
                                }
                                
                            }
                            
                            [self setValue:dic forKey:propertyName];
                            
                            
                        }
                        else
                        {
                            Class propertyClass = NSClassFromString(propertyClassName);
                            if (propertyClass)
                            {
                                
                                NSObject* obj = (NSObject*)[[propertyClass alloc] init];
                                
                                if ([obj isKindOfClass:[NSDictionary class]]) {
                                    [self setValue:propertyValue forKey:propertyName];
                                } else {
                                    [obj fromDictionary:propertyValue];
                                    [self setValue:obj forKey:propertyName];
                                }
                            }
                            
                        }
                        
                    }
                    else if ([propertyValue isKindOfClass:[NSArray class]])
                    {
                        if ([propertyClassName hasPrefix:@"Array_"])
                        {
                            NSString* dicItemClassName;
                            
                            dicItemClassName = [propertyClassName substringFromIndex:[@"Array_" length]];
                            
                            NSMutableArray* ary = [[NSMutableArray alloc] init];
                            
                            for (id value in propertyValue)
                            {
                                
                                if ([value isKindOfClass:[NSDictionary class]])
                                {
                                    Class cls = NSClassFromString(dicItemClassName);
                                    if (cls)
                                    {
                                        NSObject* obj = (NSObject*)[[cls alloc] init];
                                        [obj fromDictionary:value];
                                        [ary addObject:obj];
                                    }
                                }
                                else
                                {
                                    [ary addObject:value];
                                }
                            }
                            
                            [self setValue:ary forKey:propertyName];
                            
                        }
                        else
                        {
                            if ([propertyClassName isEqualToString:@"NSArray"] || [propertyClassName isEqualToString:@"NSMutableArray"])
                            {
                                NSMutableArray* ary = [[NSMutableArray alloc] initWithArray:propertyValue];
                                [self setValue:ary forKey:propertyName];
                            }
                            else
                            {
                                NSLog(@"error:-------------------->propertyName:%@ type is not Array",propertyName);
                            }
                        }
                        
                    }
                    else if ([propertyValue isKindOfClass:[NSString class]])
                    {
                        if ([propertyClassName isEqualToString:@"NSString"])
                        {
                            [self setValue:propertyValue forKey:propertyName];
                        }
                        else
                        {
                            NSLog(@"error:-------------------->propertyName:%@ type is not String",propertyName);
                        }
                    }
                    else if ([propertyValue isKindOfClass:[NSNumber class]])
                    {
                        if ([propertyClassName isEqualToString:@"NSNumber"])
                        {
                            [self setValue:propertyValue forKey:propertyName];
                        }
                        else
                        {
                            //如果是number转换成NSString
                            if ([propertyClassName isEqualToString:@"NSString"])
                            {
                                [self setValue:[(NSNumber *)propertyValue stringValue] forKey:propertyName];
                            }
                            NSLog(@"error:-------------------->propertyName:%@ type is not Number",propertyName);
                        }
                    }
                    else if ([propertyValue isKindOfClass:[NSDate class]])
                    {
                        if ([propertyClassName isEqualToString:@"NSDate"])
                        {
                            [self setValue:propertyValue forKey:propertyName];
                        }
                        else
                        {
                            NSLog(@"error:-------------------->propertyName:%@ type is not NSDate",propertyName);
                        }
                    }
                }
            }
        }
        
        free(properties);
        
        return self;
    }
    
}


@end
