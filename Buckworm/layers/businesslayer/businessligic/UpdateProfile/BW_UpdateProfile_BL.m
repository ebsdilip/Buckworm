//
//  BW_UpdateProfile_BL.m
//  buckworm
//
//  Created by TechSunRise on 6/27/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_UpdateProfile_BL.h"

@implementation BW_UpdateProfile_BL

@synthesize callBack;

#pragma mark- Update User
- (void)updateUser:(NSString *)strUpdate
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            UpdateProfileParser *parser = [[UpdateProfileParser alloc] init];
            parser.callBack = self;
            parser.strUpdate = strUpdate;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}

- (void)UpdateProfileParserFinished:(NSDictionary *)dictOffers
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(UpdateProfileParserFinished:)])
	{
		[(id)[self callBack] UpdateProfileParserFinished:dictOffers];
	}
}

- (void)filterOffers
{
    
}
- (void)errorInParseing:(NSError *)error
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(errorInParseing:)])
	{
		[(id)[self callBack] errorInParseing:error];
    }
}

#pragma mark- ZipCode Validator

- (void)checkZipCode:(NSString *)strZipCode
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            ZipCodeValidatorParser *parser = [[ZipCodeValidatorParser alloc] init];
            parser.callBack = self;
            parser.strZipCode = strZipCode;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}

- (void)ZipCodeValidatorParserFinished:(NSDictionary *)dictData
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(ZipCodeValidatorParserFinished:)])
    {
        [(id)[self callBack] ZipCodeValidatorParserFinished:dictData];
    }
}

#pragma mark- Schools by ZipCode
- (void)getSchoolsOfZipCode:(NSString *)strZipCode
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            SchoolsByZipCodeParser *parser = [[SchoolsByZipCodeParser alloc] init];
            parser.callBack = self;
            parser.strZipCode = strZipCode;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}

- (void)SchoolsByZipCodeParserFinished:(NSDictionary *)dictData
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(SchoolsByZipCodeParserFinished:)])
    {
        [(id)[self callBack] SchoolsByZipCodeParserFinished:dictData];
    }
}

- (void)checkUsernameExist:(NSString *)strUsername
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            UsernameValidatorParser *parser = [[UsernameValidatorParser alloc] init];
            parser.callBack = self;
            parser.strUsername = strUsername;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];

}
- (void)UsernameValidatorParserFinished:(NSDictionary *)dictData
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(UsernameValidatorParserFinished:)])
    {
        [(id)[self callBack] UsernameValidatorParserFinished:dictData];
    }
}
@end
