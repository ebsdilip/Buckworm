//
//  ShareParser.h
//  buckworm
//
//  Created by Developer on 8/11/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "VITJSONParser.h"

@protocol ShareParserDelegate;
@interface ShareParser : VITJSONParser
{

}

@property(nonatomic) NSString *strOperation;
@property(nonatomic) NSString *strShareID;
@property(nonatomic) NSString *strOfferID;
@property(nonatomic) NSString *strToEmails;

@property(nonatomic,assign)__unsafe_unretained id <ShareParserDelegate>callBack;

- (void)startParsing;

@end

@protocol ShareParserDelegate <NSObject>

@optional
- (void)errorInParseing:(NSError *)error;
@optional
- (void)ShareParserFinished:(NSDictionary *)dictOffers;

@end