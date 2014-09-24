//
//  BW_Stripe_BL.m
//  Buckworm
//
//  Created by iLabours on 9/16/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_Stripe_BL.h"

@implementation BW_Stripe_BL

@synthesize callBack;
@synthesize strAction;

- (void)makePaymentFor:(NSString *)strUUID andAmount:(NSString *)strAmount andToken:(NSString *)strToken
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            BWStripeParser *parser = [[BWStripeParser alloc] init];
            parser.callBack = self;
            parser.strAction = self.strAction;
            parser.strAmount = strAmount;
            parser.strCampaign_uuid = strUUID;
            parser.strStripeToken = strToken;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];

}

- (void)refundPaymentFor:(NSString *)strOrderNumber andDescription:(NSString *)strDescription
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            BWStripeParser *parser = [[BWStripeParser alloc] init];
            parser.callBack = self;
            parser.strDescription = strDescription;
            parser.strOrderNumber = strOrderNumber;
            parser.strAction = strAction;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
    
}

- (void)paymentParserFinished:(NSDictionary *)dictData
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(paymentParserFinished:)])
    {
        [(id)[self callBack] paymentParserFinished:dictData];
    }
}

- (void)refundParserFinished:(NSDictionary *)dictData
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(refundParserFinished:)])
    {
        [(id)[self callBack] refundParserFinished:dictData];
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
