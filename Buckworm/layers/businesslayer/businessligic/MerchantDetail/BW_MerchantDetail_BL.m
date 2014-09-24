//
//  BW_MerchantDetail_BL.m
//  buckworm
//
//  Created by Developer on 8/21/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_MerchantDetail_BL.h"

@implementation BW_MerchantDetail_BL

@synthesize callBack;

- (void)getDetailsOfMerchant:(NSString *)strMerchantID
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            MerchantDetailPaser *parser = [[MerchantDetailPaser alloc] init];
            parser.callBack = self;
            parser.strMerchantID = strMerchantID;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];

}

- (void)merchantDetailPaserFinished:(NSDictionary *)dictOffers
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(merchantDetailPaserFinished:)])
	{
		[(id)[self callBack] merchantDetailPaserFinished:dictOffers];
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
