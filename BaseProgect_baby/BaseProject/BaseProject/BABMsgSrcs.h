//
//  BABMsgSrcs.h
//  BaseProject
//
//  Created by 任前辈 on 15-5-22.
//  Copyright (c) 2015年 Renqianbei. All rights reserved.
//

#import "BAObject.h"

typedef NSString * YOCMessageSourceType;

@interface BABMsgSrcs : BAObject

@property (nonatomic, copy) NSString *sourceID;
@property (nonatomic, copy) YOCMessageSourceType type;

@property (nonatomic, copy) NSString *authName;
@property (nonatomic, copy) NSString *authId;
@property (nonatomic, copy) NSString *authPwd;

@property (nonatomic, assign) NSTimeInterval  configurationUpdateOn;
@property (nonatomic, assign) BOOL            shouldPush;
@property (nonatomic, assign) BOOL            isPublic;
//@property (nonatomic, strong) YOCSourceEndpoint *lineIn;
//@property (nonatomic, strong) YOCSourceEndpoint *lineOut;
@end
