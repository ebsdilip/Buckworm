//
//  DigitalOperationParser.h
//  buckworm
//
//  Created by Developer on 8/11/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "VITJSONParser.h"

@protocol DigitalOperationParserDelegate;
@interface DigitalOperationParser : VITJSONParser
{
    NSString *strCampaignID;
    NSString *strOprationType;
    NSString *strLinkID;
}
@property(nonatomic) NSString *strCampaignID;
@property(nonatomic) NSString *strOprationType;
@property(nonatomic) NSString *strLinkID;

@property(nonatomic,assign)__unsafe_unretained id <DigitalOperationParserDelegate>callBack;

- (void)startParsing;

@end

@protocol DigitalOperationParserDelegate <NSObject>

@optional
- (void)errorInParseing:(NSError *)error;
@optional
- (void)linkungParserFinished:(NSDictionary *)dictOffers;
@optional
- (void)unlinkingParserFinished:(NSDictionary *)dictOffers;
@optional
- (void)markingAsRedeemedParserFinished:(NSDictionary *)dictOffers;
@optional
- (void)markingAsLockedParserFinished:(NSDictionary *)dictOffers;
@end