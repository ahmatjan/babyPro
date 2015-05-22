//
//  BAObject.h
//  BaseProject
//
//  Created by 任前辈 on 15-5-21.
//  Copyright (c) 2015年 Renqianbei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "BaseModel.h"
@interface BAObject : BaseModel


//存取数据库唯一标识，根据需要子类确定
-(NSString *)keyID;

//从数据库获取对应类的数组

+ (NSArray *)searchforKey:(NSString *)key Value:(id)object;

+ (NSArray *)searchforPredicate:(NSPredicate *)predicate;

//只有设置了 modelkey 才会被保存
- (void)save;

- (void)deleteself;
- (void)delete_key:(NSString*)key value:(NSString*)value;

/**
 *  删除内容根据predicate
 *
 *  @param predicate 条件
 */
+(void)deleteforPredicate:(NSPredicate *)predicate;

+(int)localNums:(NSPredicate*)predicate;

@end
