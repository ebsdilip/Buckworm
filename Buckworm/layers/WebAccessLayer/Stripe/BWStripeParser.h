//
//  BWStripeParser.h
//  Buckworm
//
//  Created by iLabours on 9/15/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "VITJSONParser.h"

@protocol BWStripeParserDelegate;
@interface BWStripeParser : VITJSONParser
{
    NSString *strStripeToken;
    NSString *strAmount;
    NSString *strCampaign_uuid;
}
@property(nonatomic) NSString *strDescription;
@property(nonatomic) NSString *strAction;
@property(nonatomic) NSString *strOrderNumber;
@property(nonatomic) NSString *strStripeToken;
@property(nonatomic) NSString *strAmount;
@property(nonatomic) NSString *strCampaign_uuid;

@property(nonatomic,assign)__unsafe_unretained id <BWStripeParserDelegate>callBack;

- (void)startParsing;

@end

@protocol BWStripeParserDelegate <NSObject>

@optional
- (void)paymentParserFinished:(NSDictionary *)dictData;
@optional
- (void)refundParserFinished:(NSDictionary *)dictData;
@optional
- (void)errorInParseing:(NSError *)error;

@end