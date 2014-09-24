//
//  GeoCodeFromAddressParser.h
//  buckworm
//
//  Created by Developer on 8/13/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "VITJSONParser.h"

@protocol GeoCodeFromAddressParserDelegate;
@interface GeoCodeFromAddressParser : VITJSONParser
{
    NSString *strAddress;
    __unsafe_unretained id <GeoCodeFromAddressParserDelegate>callBack;
}

@property(nonatomic) NSString *strAddress;
@property(nonatomic, assign) __unsafe_unretained id <GeoCodeFromAddressParserDelegate>callBack;

- (void)startParsing;

@end


@protocol GeoCodeFromAddressParserDelegate <NSObject>

@optional
- (void)errorInParseing:(NSError *)error;
@optional
- (void)GeoCodeFromAddressParserFinished:(NSDictionary *)dictGeoCode;

@end