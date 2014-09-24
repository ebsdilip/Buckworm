//
//  BW_SurveyBox_BL.m
//  buckworm
//
//  Created by Developer on 8/16/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_SurveyBox_BL.h"

@implementation BW_SurveyBox_BL

@synthesize callBack;

- (void)setSelectedSurvey:(NSString *)strText forOffer:(NSString *)strCID
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool {
            SurvetBoxParser *parser = [[SurvetBoxParser alloc] init];
            parser.callBack = self;
            parser.strText = strText;
            parser.strCampaignUUID = strCID;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}


- (void)survetBoxParserFinished:(NSDictionary *)json
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(survetBoxParserFinished:)])
    {
        [(id)[self callBack] survetBoxParserFinished:json];
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
