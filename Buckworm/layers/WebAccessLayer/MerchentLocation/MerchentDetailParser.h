//
//  MerchentDetailParser.h
//  buckworm
//
//  Created by TechSunRise on 8/6/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "VITJSONParser.h"

@protocol MerchentDetailParserDelegate;
@interface MerchentDetailParser : VITJSONParser
{
    NSString *strMerchentID;
    __unsafe_unretained id <MerchentDetailParserDelegate>callBack;
}

@property(nonatomic) NSString *strMerchentID;
@property(nonatomic, assign) __unsafe_unretained id <MerchentDetailParserDelegate>callBack;

- (void)startParsing;

@end


@protocol MerchentDetailParserDelegate <NSObject>

@optional
- (void)errorInParseing:(NSError *)error;
@optional
- (void)MerchentDetailParserFinished:(NSDictionary *)dictOffers;

@end