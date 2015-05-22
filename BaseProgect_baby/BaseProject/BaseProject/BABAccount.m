//
//  BABAccount.m
//  BaseProject
//
//  Created by 任前辈 on 15-5-22.
//  Copyright (c) 2015年 Renqianbei. All rights reserved.
//

#import "BABAccount.h"
#import "BABUser.h"
#import "BABMsgSrcs.h"
@implementation BABAccount

-(NSArray *)ignoreProperties{
    return @[@"profile",@"sources"];
}


//
//
//
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"profile" : @"profile",
             @"sources" : @"msgSrcs",
             };
}

//ModelTransformer(profile, [MTLJSONAdapter dictionaryTransformerWithModelClass:[BABUser class]]);
//
//ModelTransformer(sources, [MTLJSONAdapter arrayTransformerWithModelClass:[BABMsgSrcs class]]);
//
//
////ModelTransformer(state, ([NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{@"open" :@(GHIssueStateOpen),
////                                                                                        @"closed":@(GHIssueStateClosed)}]));
//
//+(NSValueTransformer *)stateJSONTransformer{
//    
////    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{@"open" :@(GHIssueStateOpen),
////                                                                           @"closed":@(GHIssueStateClosed)}];
//    
//    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
//        if ([value isEqualToString:@"open"]) {
//            return @(GHIssueStateOpen);
//        }else{
//            return @(GHIssueStateClosed);
//        }
//
//    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
//        if ([value integerValue]==GHIssueStateOpen) {
//            return @"open";
//        }else{
//            return @"closed";
//        }
//
//    }];
//    
//}
@end
