//
//  FeedbackParser.h
//  buckworm
//
//  Created by Developer on 8/16/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "VITJSONParser.h"

@protocol FeedbackParserDelegate;
@interface FeedbackParser : VITJSONParser
{
    NSString *strComment;
    NSString *strRating;
    NSString *strAmount;
    NSString *strCampaignUUID;
}

@property(nonatomic) NSString *strComment;
@property(nonatomic) NSString *strRating;
@property(nonatomic) NSString *strAmount;
@property(nonatomic) NSString *strCampaignUUID;
@property(nonatomic,assign)__unsafe_unretained id <FeedbackParserDelegate>callBack;

- (void)startParsing;

@end


@protocol FeedbackParserDelegate <NSObject>

@optional
- (void)errorInParseing:(NSError *)error;
@optional
- (void)feedbackParserFinished:(NSDictionary *)dictOffers;

@end