//
//  NSObject+BAExtensions.h
//  BaseProject
//
//  Created by 任前辈 on 15-5-21.
//  Copyright (c) 2015年 Renqianbei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (BAExtensions)
//主要用来存库  有过滤字段方法
-(NSDictionary *)toDictionary;

//包括其所有父类的属性
-(NSDictionary *)toAllDictionary ;

//主要用来存库  有过滤字段方法
-(id)fromDictionary:(NSDictionary*)dic;


//忽视的字段的方法  需要子类 自己实现
-(NSArray *)ignoreProperties;




//主要用来解析    没有忽视字段
-(id)analysisfromDictionary:(NSDictionary*)dicRoot;

-(NSDictionary *)analysisToDictionary;

@end
