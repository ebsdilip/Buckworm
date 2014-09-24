//
//  BW_WishwormOperations_BL.m
//  buckworm
//
//  Created by Developer on 7/19/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_WishwormOperations_BL.h"

@implementation BW_WishwormOperations_BL

@synthesize callBack;

#pragma mark - Download
- (void)makeDownload:(NSString *)strOfferID andCampaignuuid:(NSString *)strCampaignuuID
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            WishwornOperationParser *parser = [[WishwornOperationParser alloc] init];
            parser.callBack = self;
            parser.strOfferID = strOfferID;
            parser.strCampaignuuID = strCampaignuuID;
            parser.strOperation = @"download";
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}
- (void)makeDownload:(NSString *)strOfferID andCampaignuuid:(NSString *)strCampaignuuID andAccountToken:(NSString *)strAccountToken
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            WishwornOperationParser *parser = [[WishwornOperationParser alloc] init];
            parser.callBack = self;
            parser.strOfferID = strOfferID;
            parser.strCampaignuuID = strCampaignuuID;
            parser.strAccountToken = strAccountToken;
            parser.strOperation = @"download";
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];

}

- (void)selectAnOption:(NSString *)strOptionID
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            WishwornOperationParser *parser = [[WishwornOperationParser alloc] init];
            parser.callBack = self;
            parser.strOfferID = strOptionID;
            parser.strOperation = @"option";
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}

#pragma mark - Make a Wish
- (void)makeAWish:(NSString *)strWish toMerchant:(NSString *)strMerchantID
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            WishwornOperationParser *parser = [[WishwornOperationParser alloc] init];
            parser.callBack = self;
            parser.strWish = strWish;
            parser.strMerchantID = strMerchantID;
            parser.strOperation = @"makeawish";
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}

- (void)wishwormOperationsParserFinished:(NSDictionary *)dictOffers
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(wishwormOperationsParserFinished:)])
	{
		[(id)[self callBack] wishwormOperationsParserFinished:dictOffers];
	}

}

#pragma mark - Lock
- (void)lockOffer:(NSString *)strOfferID
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            WishwornOperationParser *parser = [[WishwornOperationParser alloc] init];
            parser.callBack = self;
            parser.strOfferID = strOfferID;
            parser.strOperation = @"lock";
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}

- (void)errorInParseing:(NSError *)error
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(errorInParseing:)])
	{
		[(id)[self callBack] errorInParseing:error];
	}
}



@end