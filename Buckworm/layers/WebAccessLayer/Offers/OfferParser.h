//
//  OfferParser.h
//  buckworm
//
//  Created by TechSunRise on 6/24/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VITJSONParser.h"

@protocol OfferParserDelegate;
@interface OfferParser : VITJSONParser
{
    NSString *strOfferType;
    __unsafe_unretained id <OfferParserDelegate>callBack;
}

@property(nonatomic) NSString *strOfferType;
@property(nonatomic,assign)__unsafe_unretained id <OfferParserDelegate>callBack;

- (void)startParsingDemoRedeem;
- (void)startParsing;
- (void)startParsingForTeaserOffers;

@end

@protocol OfferParserDelegate <NSObject>

@optional
- (void)OfferParserFinished:(NSDictionary *)dictData;
@optional
- (void)errorInParseing:(NSError *)error;

@end