//
//  BW_SignUp_BL.h
//  buckworm
//
//  Created by TechSunRise on 6/28/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BW_Base_BL.h"
#import "SignUpParser.h"

@protocol BW_SignUp_BL_Delegate;
@interface BW_SignUp_BL : BW_Base_BL <SignUpParserDelegate>
{
    __unsafe_unretained id <BW_SignUp_BL_Delegate>callBack;
}

@property(nonatomic,assign)__unsafe_unretained id <BW_SignUp_BL_Delegate>callBack;

- (void)signUpUser:(NSString *)strSignUp;

@end

@protocol BW_SignUp_BL_Delegate <NSObject>

@optional
- (void)errorInParseing:(NSError *)error;
@optional
- (void)SignUpParserFinished:(NSDictionary *)dictOffers;

@end

