//
//  BW_DigitalAndPurchaseOffer_BL.m
//  buckworm
//
//  Created by Developer on 8/11/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_DigitalAndPurchaseOffer_BL.h"

@implementation BW_DigitalAndPurchaseOffer_BL

@synthesize callBack;

#pragma mark - Available
- (void)getAvailableOffer:(NSString *)strOfferType
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            DigitalAndPurchaseOfferParser *parser = [[DigitalAndPurchaseOfferParser alloc] init];
            parser.callBack = self;
            parser.strOfferSubCategory = @"unlinkoffers";
            parser.strOfferType = strOfferType;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}

- (void)availableOfferParserFinished:(NSDictionary *)dictOffers
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(availableOfferParserFinished:)])
	{
		[(id)[self callBack] availableOfferParserFinished:dictOffers];
	}
}

#pragma mark - Linked
- (void)getLinkedOffer:(NSString *)strOfferType
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            DigitalAndPurchaseOfferParser *parser = [[DigitalAndPurchaseOfferParser alloc] init];
            parser.callBack = self;
//            parser.strOfferSubCategory = @"linkoffers";
            parser.strOfferSubCategory = @"linked";
            parser.strOfferType = strOfferType;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}
- (void)linkedOfferParserFinished:(NSDictionary *)dictOffers
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(linkedOfferParserFinished:)])
	{
		[(id)[self callBack] linkedOfferParserFinished:dictOffers];
	}
}


#pragma mark - Redeemed
- (void)getRedeemedOffer:(NSString *)strOfferType
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            DigitalAndPurchaseOfferParser *parser = [[DigitalAndPurchaseOfferParser alloc] init];
            parser.callBack = self;
//            parser.strOfferSubCategory = @"reedemedoffers";
            parser.strOfferSubCategory = @"redeemed";
            parser.strOfferType = strOfferType;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}

- (void)redeemedOfferParserFinished:(NSDictionary *)dictOffers
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(redeemedOfferParserFinished:)])
	{
		[(id)[self callBack] redeemedOfferParserFinished:dictOffers];
	}
}

#pragma mark - Expired
- (void)getExpiredOffer:(NSString *)strOfferType
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            DigitalAndPurchaseOfferParser *parser = [[DigitalAndPurchaseOfferParser alloc] init];
            parser.callBack = self;
//            parser.strOfferSubCategory = @"expiredoffers";
            parser.strOfferSubCategory = @"expired";
            parser.strOfferType = strOfferType;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}

- (void)expiredOfferParserFinished:(NSDictionary *)dictOffers
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(expiredOfferParserFinished:)])
	{
		[(id)[self callBack] expiredOfferParserFinished:dictOffers];
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
