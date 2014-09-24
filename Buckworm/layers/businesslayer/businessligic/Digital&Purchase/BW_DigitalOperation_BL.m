//
//  BW_DigitalOperation_BL.m
//  buckworm
//
//  Created by Developer on 8/11/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_DigitalOperation_BL.h"

@implementation BW_DigitalOperation_BL

@synthesize callBack;

//http://buckworm.com/laravel/index.php/api/v1/linkoffer
- (void)linkOffer:(NSString *)strCampaignUUID
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            DigitalOperationParser *parser = [[DigitalOperationParser alloc] init];
            parser.callBack = self;
            parser.strOprationType = @"linkoffer";
            parser.strCampaignID = strCampaignUUID;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}
- (void)linkungParserFinished:(NSDictionary *)json
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(linkungParserFinished:)])
    {
        [(id)[self callBack] linkungParserFinished:json];
    }
}

//http://buckworm.com/laravel/index.php/api/v1/deleteoffers
- (void)unlinkOffer:(NSString *)strCampaignID
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            DigitalOperationParser *parser = [[DigitalOperationParser alloc] init];
            parser.callBack = self;
            parser.strOprationType = @"deleteoffers";
            parser.strCampaignID = strCampaignID;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}

- (void)unlinkingParserFinished:(NSDictionary *)json
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(unlinkingParserFinished:)])
    {
        [(id)[self callBack] unlinkingParserFinished:json];
    }
}


- (void)markAsRedeemedOffer:(NSString *)strCampaignUUID andLinkID:(NSString *)strLinkID;
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            DigitalOperationParser *parser = [[DigitalOperationParser alloc] init];
            parser.callBack = self;
            parser.strOprationType = @"redeem";
            parser.strCampaignID = strCampaignUUID;
            parser.strLinkID = strLinkID;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}
- (void)markingAsRedeemedParserFinished:(NSDictionary *)json
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(markingAsRedeemedParserFinished:)])
    {
        [(id)[self callBack] markingAsRedeemedParserFinished:json];
    }
}

- (void)markAsLockedOffer:(NSString *)strCampaignUUID andLinkID:(NSString *)strLinkID;
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            DigitalOperationParser *parser = [[DigitalOperationParser alloc] init];
            parser.callBack = self;
            parser.strOprationType = @"lockoffer";
            parser.strCampaignID = strCampaignUUID;
            parser.strLinkID = strLinkID;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}
- (void)markingAsLockedParserFinished:(NSDictionary *)json
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(markingAsLockedParserFinished:)])
    {
        [(id)[self callBack] markingAsLockedParserFinished:json];
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
