//
//  BW_SignUp_BL.m
//  buckworm
//
//  Created by TechSunRise on 6/28/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_SignUp_BL.h"

@implementation BW_SignUp_BL

@synthesize callBack;

- (void)signUpUser:(NSString *)strSignUp
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            SignUpParser *parser = [[SignUpParser alloc] init];
            parser.callBack = self;
            parser.strPostString = strSignUp;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}

- (void)SignUpParserFinished:(NSDictionary *)dictData
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(SignUpParserFinished:)])
	{
		[(id)[self callBack] SignUpParserFinished:dictData];
	}
}

- (void)errorInParseing:(NSError *)error
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(errorInParseing:)])
	{
		[(id)[self callBack] errorInParseing:error];
    }
}

@end

