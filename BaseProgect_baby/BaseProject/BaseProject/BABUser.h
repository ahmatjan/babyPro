//
//  BABUser.h
//  BaseProject
//
//  Created by 任前辈 on 15-5-22.
//  Copyright (c) 2015年 Renqianbei. All rights reserved.
//

#import "BAObject.h"

@interface BABUser : BAObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *remarkName;
@property (nonatomic, copy) NSString *avatarPrefix;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, assign) BOOL sigAvatar;

@property (nonatomic, copy) NSString *domains;

@property (nonatomic, copy) NSString *organization;
@property (nonatomic, copy) NSString *department;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *extra; //unknow

@property (nonatomic, assign) NSTimeInterval updateOn;
@property (nonatomic, assign) NSTimeInterval avatarUpdateOn;
@property (nonatomic, assign) NSTimeInterval basicUpdateOn;
@property (nonatomic, assign) NSTimeInterval sigUpdateOn;
@end
