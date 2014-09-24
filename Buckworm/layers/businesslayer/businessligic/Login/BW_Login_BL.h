//
//  BW_Login_BL.h
//  buckworm
//
//  Created by TechSunRise on 6/18/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BW_Base_BL.h"

#import "LoginParser.h"
#import "BW_Login_BO.h"

#import "ForgotPasswordParser.h"
#import "NetworkRegisterParser.h"

@protocol BW_Login_BL_Delegate;
@interface BW_Login_BL : BW_Base_BL <LoginParserDelegate, ForgotPasswordParseDelegate, NetworkRegisterParserDelegate>
{
    
    __unsafe_unretained id <BW_Login_BL_Delegate>callBack;

}

@property(nonatomic,assign)__unsafe_unretained id <BW_Login_BL_Delegate>callBack;

- (void)getLogin:(NSString *)strUsername andPassword:(NSString *)strPassword;
- (void)forgotPasswordUser:(NSString *)strUsername;

- (void)registerWithNetworks;

@end

@protocol BW_Login_BL_Delegate <NSObject>

@optional
- (void)errorInParseing:(NSError *)error;
@optional
- (void)LoginParserFinished:(NSDictionary *)dictProfile;
@optional
- (void)ForgotPasswordParserFinished:(NSDictionary *)dictData;

@end