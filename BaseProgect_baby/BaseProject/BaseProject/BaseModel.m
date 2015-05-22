//
//  BaseModel.m
//  BaseProject
//
//  Created by 任前辈 on 15-5-22.
//  Copyright (c) 2015年 Renqianbei. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel


+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{};
}

- (NSString *)modelName{
    return @"";
}

- (NSDictionary *)jsonDictionary{
    
    return [MTLJSONAdapter JSONDictionaryFromModel:self error:nil];
}

@end
