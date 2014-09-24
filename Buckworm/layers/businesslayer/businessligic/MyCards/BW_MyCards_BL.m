//
//  BW_MyCards_BL.m
//  buckworm
//
//  Created by TechSunRise on 6/19/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_MyCards_BL.h"

@implementation BW_MyCards_BL

#pragma mark - AddCard
- (void)getAddCardURL
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            AddCardURLParser *parser = [[AddCardURLParser alloc] init];
            parser.callBack = self;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}

- (void)AddCardURLParserFinished:(NSDictionary *)dictData
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(AddCardURLParserFinished:)])
	{
		[(id)[self callBack] AddCardURLParserFinished:[dictData objectForKey:@"url"]];
	}
}

- (void)errorInParseing:(NSError *)error
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(errorInParseing:)])
	{
		[(id)[self callBack] errorInParseing:error];
    }
}

#pragma mark - 
- (void)getCards
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            CardsListParser *parser = [[CardsListParser alloc] init];
            parser.callBack = self;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}

- (void)CardsListParserFinished:(NSDictionary *)dictData
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(CardsListParserFinished:)])
	{
		[(id)[self callBack] CardsListParserFinished:dictData];
	}
}
@end
