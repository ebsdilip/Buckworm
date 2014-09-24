//
//  ZipCodeValidatorParser.h
//  buckworm
//
//  Created by TechSunRise on 7/11/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VITJSONParser.h"

@protocol ZipCodeValidatorParserDelegate;
@interface ZipCodeValidatorParser : VITJSONParser
{
    NSString *strZipCode;
}

@property(nonatomic) NSString *strZipCode;
@property(nonatomic, assign) __unsafe_unretained id <ZipCodeValidatorParserDelegate>callBack;

- (void)startParsing;

@end

@protocol ZipCodeValidatorParserDelegate <NSObject>

@optional
- (void)ZipCodeValidatorParserFinished:(NSDictionary *)dictData;
@optional
- (void)errorInParseing:(NSError *)error;


@end