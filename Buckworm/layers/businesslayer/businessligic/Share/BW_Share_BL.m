//
//  BW_Share_BL.m
//  buckworm
//
//  Created by Developer on 8/11/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_Share_BL.h"

@implementation BW_Share_BL

@synthesize callBack;


- (void)shareOffer:(NSString *)strOfferID toEmails:(NSString *)strToEmails
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            ShareParser *parser = [[ShareParser alloc] init];
            parser.callBack = self;
            parser.strOfferID = strOfferID;
            parser.strToEmails = strToEmails;
            parser.strOperation = @"share";
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

- (void)ShareParserFinished:(NSDictionary *)dictOffers
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(ShareParserFinished:)])
	{
		[(id)[self callBack] ShareParserFinished:dictOffers];
	}

}

@end
