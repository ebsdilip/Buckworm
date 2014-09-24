//
//  ForgotPasswordParser.h
//  buckworm
//
//  Created by Developer on 7/15/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VITJSONParser.h"

@protocol ForgotPasswordParseDelegate;
@interface ForgotPasswordParser : VITJSONParser
{
    NSString *strUsername;
}

@property(nonatomic) NSString *strUsername;
@property(nonatomic, assign) __unsafe_unretained id <ForgotPasswordParseDelegate>callBack;

- (void)startParsing;

@end

@protocol ForgotPasswordParseDelegate <NSObject>

@optional
- (void)ForgotPasswordParserFinished:(NSDictionary *)dictData;
@optional
- (void)errorInParseing:(NSError *)error;

@end