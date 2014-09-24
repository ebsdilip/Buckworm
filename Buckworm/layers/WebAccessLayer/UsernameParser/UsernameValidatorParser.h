//
//  UsernameValidatorParser.h
//  buckworm
//
//  Created by TechSunRise on 7/12/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VITJSONParser.h"

@protocol UsernameValidatorParserDelegate;
@interface UsernameValidatorParser : VITJSONParser
{
    NSString *strUsername;
}

@property(nonatomic) NSString *strUsername;
@property(nonatomic, assign) __unsafe_unretained id <UsernameValidatorParserDelegate>callBack;

- (void)startParsing;

@end

@protocol UsernameValidatorParserDelegate <NSObject>

@optional
- (void)UsernameValidatorParserFinished:(NSDictionary *)dictData;
@optional
- (void)errorInParseing:(NSError *)error;

@end