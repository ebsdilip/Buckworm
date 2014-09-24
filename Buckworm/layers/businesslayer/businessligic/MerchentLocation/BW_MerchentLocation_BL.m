//
//  BW_MerchentLocation_BL.m
//  buckworm
//
//  Created by TechSunRise on 8/5/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_MerchentLocation_BL.h"

@implementation BW_MerchentLocation_BL

@synthesize callBack;

- (void)getMerchantsOfLat:(NSString *)strLat andLong:(NSString *)strLong
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            MerchentLocationParesr *parser = [[MerchentLocationParesr alloc] init];
            parser.strLatitude = strLat;
            parser.strLongitude = strLong;
            parser.callBack = self;
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

- (void)MerchentLocationParserFinished:(NSDictionary *)dictOffers
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(MerchentLocationParserFinished:)])
	{
		[(id)[self callBack] MerchentLocationParserFinished:dictOffers];
	}
}

- (void)getMerchantsDetails:(NSString *)strMerchentID
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            MerchentDetailParser *parser = [[MerchentDetailParser alloc] init];
            parser.strMerchentID = strMerchentID;
            parser.callBack = self;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
    
}

- (void)MerchentDetailParserFinished:(NSDictionary *)dictOffers
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(MerchentDetailParserFinished:)])
	{
		[(id)[self callBack] MerchentDetailParserFinished:dictOffers];
	}
}

@end
