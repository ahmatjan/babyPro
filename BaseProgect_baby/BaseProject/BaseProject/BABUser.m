//
//  BABUser.m
//  BaseProject
//
//  Created by 任前辈 on 15-5-22.
//  Copyright (c) 2015年 Renqianbei. All rights reserved.
//

#import "BABUser.h"

@implementation BABUser
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"organization" : @"company",
             @"title" : @"jobTitle",
             @"updateOn" : @"updated",
             @"avatarUpdateOn" : @"avatarUpdated",
             @"basicUpdateOn" : @"basicUpdated",
             @"avatar" : @"avatarId"
             };
}
@end
