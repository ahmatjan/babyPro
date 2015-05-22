//
//  BABAccount.h
//  BaseProject
//
//  Created by 任前辈 on 15-5-22.
//  Copyright (c) 2015年 Renqianbei. All rights reserved.
//

#import "BAObject.h"
@class BABUser;
@interface BABAccount : BAObject

typedef enum : NSUInteger {
    GHIssueStateOpen,
    GHIssueStateClosed
} GHIssueState;

@property (nonatomic, copy) NSString *accountID;
@property (nonatomic, copy) NSString *accessToken;//psw
@property (nonatomic, assign) GHIssueState state;
@property (nonatomic, strong) BABUser *profile;
@property (nonatomic, strong) NSArray *sources;
@end
