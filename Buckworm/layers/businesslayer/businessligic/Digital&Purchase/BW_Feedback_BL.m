//
//  BW_Feedback_BL.m
//  buckworm
//
//  Created by Developer on 8/16/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_Feedback_BL.h"

@implementation BW_Feedback_BL

@synthesize callBack;

- (void)sendFeedback:(NSMutableDictionary *)dictFeedback
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool {
            FeedbackParser *parser = [[FeedbackParser alloc] init];
            parser.callBack = self;
            parser.strAmount = [dictFeedback objectForKey:@"Ammount"];
            parser.strCampaignUUID = [dictFeedback objectForKey:@"ID"];
            parser.strComment = [dictFeedback objectForKey:@"Comment"];
            parser.strRating = [dictFeedback objectForKey:@"Rating"];
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailable];
}

- (void)feedbackParserFinished:(NSDictionary *)json
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(feedbackParserFinished:)])
    {
        [(id)[self callBack] feedbackParserFinished:json];
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
