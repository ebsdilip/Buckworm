//
//  ComingSoonParser.h
//  buckworm
//
//  Created by Developer on 8/1/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "VITJSONParser.h"

@protocol ComingSoonParserDelegate;
@interface ComingSoonParser : VITJSONParser
{
    __unsafe_unretained id <ComingSoonParserDelegate>callBack;

    BOOL isComingSoon;
}

@property(nonatomic) NSString *strOfferType;
@property(nonatomic) NSString *strPostBody;
@property(nonatomic, assign)     __unsafe_unretained id <ComingSoonParserDelegate>callBack;

- (void)startParsing;
- (void)startParsingOfLocalOffer;

@end

@protocol ComingSoonParserDelegate <NSObject>

@optional
- (void)ComingSoonParserFinished:(NSDictionary *)dictData;
@optional
- (void)localOfferParserFinished:(NSDictionary *)dictData;
@optional
- (void)errorInParseing:(NSError *)error;


@end