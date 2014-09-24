//
//  BWCateoryOfferBL.m
//  Buckworm
//
//  Created by iLabours on 8/29/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BWCateoryOfferBL.h"

@implementation BWCateoryOfferBL


- (void)getOfferOfCategory:(NSString *)strCat andType:(NSString *)strType
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            CategoryOfferParser *parser = [[CategoryOfferParser alloc] init];
            parser.callBack = self;
            parser.strOfferCategory = strCat;
            parser.strOfferType = strType;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}

- (void)categoryOfferParserFinished:(NSDictionary *)dictOffers
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(categoryOfferParserFinished:)])
	{
		[(id)[self callBack] categoryOfferParserFinished:dictOffers];
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
