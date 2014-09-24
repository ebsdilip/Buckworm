//
//  SurvetBoxParser.h
//  buckworm
//
//  Created by Developer on 8/16/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "VITJSONParser.h"

@protocol survetBoxParserDelegate;
@interface SurvetBoxParser : VITJSONParser
{
    NSString *strCampaignUUID;
    NSString *strText;
}

@property(nonatomic)    NSString *strCampaignUUID;
@property(nonatomic)    NSString *strText;

@property(nonatomic,assign)__unsafe_unretained id <survetBoxParserDelegate>callBack;

- (void)startParsing;

@end


@protocol survetBoxParserDelegate <NSObject>

@optional
- (void)errorInParseing:(NSError *)error;
@optional
- (void)survetBoxParserFinished:(NSDictionary *)dictOffers;

@end