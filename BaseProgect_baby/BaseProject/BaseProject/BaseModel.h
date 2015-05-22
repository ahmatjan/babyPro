//
//  BaseModel.h
//  BaseProject
//
//  Created by 任前辈 on 15-5-22.
//  Copyright (c) 2015年 Renqianbei. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>

#define ModelTransformer(prop,transformer) + (NSValueTransformer *)prop##JSONTransformer{return transformer;}


@interface BaseModel : MTLModel<
MTLJSONSerializing>

- (NSDictionary *)jsonDictionary;

@end
