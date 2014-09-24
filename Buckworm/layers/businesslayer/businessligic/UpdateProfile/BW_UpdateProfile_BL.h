//
//  BW_UpdateProfile_BL.h
//  buckworm
//
//  Created by TechSunRise on 6/27/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BW_Base_BL.h"
#import "UpdateProfileParser.h"
#import "SchoolsByZipCodeParser.h"
#import "ZipCodeValidatorParser.h"
#import "UsernameValidatorParser.h"

@protocol BW_UpdateProfile_BL_Delegate;
@interface BW_UpdateProfile_BL : BW_Base_BL <UpdateProfileParserDelegate, ZipCodeValidatorParserDelegate, SchoolsByZipCodeParserDelegate, UsernameValidatorParserDelegate>
{

}
@property(nonatomic,assign)__unsafe_unretained id <BW_UpdateProfile_BL_Delegate>callBack;

- (void)updateUser:(NSString *)strUpdate;

- (void)checkUsernameExist:(NSString *)strUsername;
- (void)getSchoolsOfZipCode:(NSString *)strZipCode;
- (void)checkZipCode:(NSString *)strZipCode;

@end

@protocol BW_UpdateProfile_BL_Delegate <NSObject>

@optional
- (void)errorInParseing:(NSError *)error;
@optional
- (void)UpdateProfileParserFinished:(NSDictionary *)dictOffers;
@optional
- (void)SchoolsByZipCodeParserFinished:(NSDictionary *)dictData;
@optional
- (void)ZipCodeValidatorParserFinished:(NSDictionary *)dictData;
@optional
- (void)UsernameValidatorParserFinished:(NSDictionary *)dictData;

@end