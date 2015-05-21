//
//  AppMacro.h

//  app相关的宏定义

#ifndef Baby_AppMacro_h
#define Baby_AppMacro_h

#define ApplicationDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]

#define BHCHANNEL [[[NSBundle mainBundle] infoDictionary] objectForKey:@"BHCHANNEL"]

//友盟渠道号
#define U_MENG_APP_CHANEL_ID BHCHANNEL

//appID
#define APP_ID @"DB8A58A6D0DCEBF4"



#endif
