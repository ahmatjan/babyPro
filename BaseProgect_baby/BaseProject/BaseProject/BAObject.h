//
//  BAObject.h
//  BaseProject
//
//  Created by 任前辈 on 15-5-21.
//  Copyright (c) 2015年 Renqianbei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAObject : NSObject

//可以被子类重写
-(NSString *)modelKeyID;

//从数据库获取对应类的数组

+ (NSArray *)ModelsWithKey:(NSString *)key andValue:(id)object;

+ (NSArray *)ModelsWithPredicate:(NSPredicate *)predicate;

//只有设置了 modelkey 才会被保存
- (void)save;

/**
 *  删除内容根据predicate
 *
 *  @param predicate 条件
 */
+(void)deleteModelWithPredicate:(NSPredicate *)predicate;

+(int)modelsCount:(NSPredicate*)predicate;

@end
