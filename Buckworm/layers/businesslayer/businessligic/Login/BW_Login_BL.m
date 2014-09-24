//
//  BW_Login_BL.m
//  buckworm
//
//  Created by TechSunRise on 6/18/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_Login_BL.h"

@implementation BW_Login_BL

@synthesize callBack;

- (void)getLogin:(NSString *)strUsername andPassword:(NSString *)strPassword
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool {
            
            LoginParser *parser = [[LoginParser alloc] init];
            parser.callBack = self;
            parser.strUserName = strUsername;
            parser.strPassword = strPassword;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}

- (void)LoginParserFinished:(NSDictionary *)dictUser
{
    NSDictionary *dictProfile = [dictUser objectForKey:@"user"];
    NSLog(@"dictProfile = %@", dictProfile);
    if(dictProfile!=nil)
    {
        if(appDelegate.objUserLogedIn==nil)
            appDelegate.objUserLogedIn = [[BW_Login_BO alloc] init];
        
        appDelegate.objUserLogedIn.strAccessToken = [[dictProfile objectForKey:@"api_token"] isKindOfClass:[NSString class]]?[dictProfile objectForKey:@"api_token"]:@"";
        appDelegate.objUserLogedIn.isActivated = (BOOL)[dictProfile objectForKey:@"activated"];//[ isEqualToString:@"1"]?YES:NO;
        appDelegate.objUserLogedIn.strAPIToken = [[dictProfile objectForKey:@"api_token"] isKindOfClass:[NSString class]]?[dictProfile objectForKey:@"api_token"]:@"";
        appDelegate.objUserLogedIn.intCashedPoints = [(NSString *)[dictProfile objectForKey:@"cashed_points"] integerValue];
        appDelegate.objUserLogedIn.strConsumerToken = [[dictProfile objectForKey:@"consumer_token"] isKindOfClass:[NSString class]]?[dictProfile objectForKey:@"consumer_token"]:@"";
        NSString *strDOB = [dictProfile objectForKey:@"dob"];
        if([strDOB isKindOfClass:[NSString class]])
            appDelegate.objUserLogedIn.strDOB = [dictProfile objectForKey:@"dob"];
        else
            appDelegate.objUserLogedIn.strDOB = @"";
        appDelegate.objUserLogedIn.intEarnedPoints = [[dictProfile objectForKey:@"earned_points"] integerValue];
        appDelegate.objUserLogedIn.strEmail = [[dictProfile objectForKey:@"email"] isKindOfClass:[NSString class]]?[dictProfile objectForKey:@"email"]:@"";

        NSString *strFirstName = [dictProfile objectForKey:@"first"];
        if([strFirstName isKindOfClass:[NSString class]])
            appDelegate.objUserLogedIn.strFirstname = strFirstName;
        else
            appDelegate.objUserLogedIn.strFirstname = @"";

        appDelegate.objUserLogedIn.strID = [dictProfile objectForKey:@"id"];
        appDelegate.objUserLogedIn.isCardAdded = [[dictProfile objectForKey:@"is_card_added"] isEqualToString:@"1"]?YES:NO;
        
        appDelegate.objUserLogedIn.strSchoolID = [[dictProfile objectForKey:@"schoolID"] isKindOfClass:[NSString class]]?[dictProfile objectForKey:@"schoolID"]:@"";
        
        appDelegate.objUserLogedIn.strUserType = [[dictProfile objectForKey:@"user_type"] isKindOfClass:[NSString class]]?[dictProfile objectForKey:@"user_type"]:@"";
        appDelegate.objUserLogedIn.strUsername = [[dictProfile objectForKey:@"username"] isKindOfClass:[NSString class]]?[dictProfile objectForKey:@"username"]:@"";
        appDelegate.objUserLogedIn.strVerificationCode = [[dictProfile objectForKey:@"verification_code"] isKindOfClass:[NSString class]]?[dictProfile objectForKey:@"verification_code"]:@"";

        NSString *strZip = [dictProfile objectForKey:@"zipcode"];
        if([strZip isKindOfClass:[NSString class]])
            appDelegate.objUserLogedIn.intZipCode = [strZip integerValue];
        
        appDelegate.objUserLogedIn.strAPIToken = [appDelegate.objUserLogedIn.strAPIToken stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        appDelegate.objUserLogedIn.strAccessToken = [appDelegate.objUserLogedIn.strAccessToken stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    else
        appDelegate.objUserLogedIn = nil;
    
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(LoginParserFinished:)])
	{
		[(id)[self callBack] LoginParserFinished:dictUser];
	}
}

#pragma mark - Forgot Password

- (void)forgotPasswordUser:(NSString *)strUsername
{
    ForgotPasswordParser *parser = [[ForgotPasswordParser alloc] init];
    parser.callBack = self;
    parser.strUsername = strUsername;
    [parser startParsing];
    parser = nil;
}

- (void)ForgotPasswordParserFinished:(NSDictionary *)dictData
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(ForgotPasswordParserFinished:)])
	{
		[(id)[self callBack] ForgotPasswordParserFinished:dictData];
	}
}
#pragma mark - Login with Networks
- (void)registerWithNetworks
{
    NetworkRegisterParser *parser = [[NetworkRegisterParser alloc] init];
    parser.callBack = self;
    [parser startParsing];
    parser = nil;
}
- (void)NetworkRegisterParserFinished:(NSDictionary *)dictData
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(NetworkRegisterParserFinished:)])
	{
		[(id)[self callBack] NetworkRegisterParserFinished:dictData];
	}
}
- (void)errorInParseing:(NSError *)error
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(errorInParseing:)])
	{
		[(id)[self callBack] errorInParseing:error];
	}
}

- (void)convertDataIntoObject:(NSDictionary *)dictUser
{
    //appDelegate.objUserLogedIn
    
}

@end
