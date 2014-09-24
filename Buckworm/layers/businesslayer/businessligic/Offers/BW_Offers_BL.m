//
//  BW_Offers_BL.m
//  buckworm
//
//  Created by TechSunRise on 6/24/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_Offers_BL.h"

@implementation BW_Offers_BL

@synthesize callBack;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)getTeaserOffers
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            OfferParser *parser = [[OfferParser alloc] init];
            parser.callBack = self;
            [parser startParsingForTeaserOffers];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}
- (void)getOffersDemoRedeem
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            OfferParser *parser = [[OfferParser alloc] init];
            parser.callBack = self;
            [parser startParsingDemoRedeem];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}

- (void)getOffers:(NSString *)strOfferType
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            OfferParser *parser = [[OfferParser alloc] init];
            parser.callBack = self;
            parser.strOfferType = strOfferType;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}

- (void)OfferParserFinished:(NSDictionary *)dictOffers
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(OfferParserFinished:)])
	{
		[(id)[self callBack] OfferParserFinished:dictOffers];
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
    else
    {
        [DSBezelActivityView removeViewAnimated:YES];
    }
}

#pragma mark - Coming Soon Offers

- (void)getOffersForAnonymousUser:(NSString *)strOfferType
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            ComingSoonParser *parser = [[ComingSoonParser alloc] init];
            parser.callBack = self;
            parser.strOfferType = strOfferType;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}

- (void)ComingSoonParserFinished:(NSDictionary *)dictOffers
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(ComingSoonParserFinished:)])
	{
		[(id)[self callBack] ComingSoonParserFinished:dictOffers];
	}
    else
    {
        [DSBezelActivityView removeViewAnimated:YES];
    }
}

#pragma mark - Local Offers
- (void)getLocalOffersForPostBody:(NSString *)strPostBody
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            ComingSoonParser *parser = [[ComingSoonParser alloc] init];
            parser.callBack = self;
            parser.strPostBody = strPostBody;
            [parser startParsingOfLocalOffer];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}

- (void)localOfferParserFinished:(NSDictionary *)dictOffers
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(localOfferParserFinished:)])
	{
		[(id)[self callBack] localOfferParserFinished:dictOffers];
	}
    else
    {
        [DSBezelActivityView removeViewAnimated:YES];
    }
}

@end
