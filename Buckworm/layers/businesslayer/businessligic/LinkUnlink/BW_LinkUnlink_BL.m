//
//  BW_LinkUnlink_BL.m
//  buckworm
//
//  Created by TechSunRise on 6/28/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_LinkUnlink_BL.h"

@implementation BW_LinkUnlink_BL

- (void)linkOffer:(NSString *)strOfferID andAccountToken:(NSString *)strAccountToken
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            LinkUnlinkParser *parser = [[LinkUnlinkParser alloc] init];
            parser.callBack = self;
            parser.strOfferID = strOfferID;
            parser.strMethod = @"link";            
            parser.strAccount = strAccountToken;//@"0000673578337801131125586546757609224193482059";
//            parser.strAccount = appDelegate.objUserLogedIn.strAPIToken;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}

- (void)unlinkOffer:(NSString *)strOfferID andAccountToken:(NSString *)strAccountToken
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            LinkUnlinkParser *parser = [[LinkUnlinkParser alloc] init];
            parser.callBack = self;
            parser.strOfferID = strOfferID;
            parser.strMethod = @"unlink";
            parser.strAccount = strAccountToken;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}

- (void)LinkParserFinished:(NSDictionary *)dictData
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(LinkParserFinished:)])
	{
		[(id)[self callBack] LinkParserFinished:dictData];
	}
}

- (void)UnlinkParserFinished:(NSDictionary *)dictData
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(UnlinkParserFinished:)])
	{
		[(id)[self callBack] UnlinkParserFinished:dictData];
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
