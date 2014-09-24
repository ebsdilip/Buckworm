//
//  SchoolsByZipCodeParser.h
//  buckworm
//
//  Created by TechSunRise on 7/11/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VITJSONParser.h"

@protocol SchoolsByZipCodeParserDelegate;
@interface SchoolsByZipCodeParser : VITJSONParser
{
    NSString *strZipCode;
}

@property(nonatomic) NSString *strZipCode;
@property(nonatomic, assign) __unsafe_unretained id <SchoolsByZipCodeParserDelegate>callBack;

- (void)startParsing;

@end

@protocol SchoolsByZipCodeParserDelegate <NSObject>

@optional
- (void)SchoolsByZipCodeParserFinished:(NSDictionary *)dictData;
@optional
- (void)errorInParseing:(NSError *)error;

@end