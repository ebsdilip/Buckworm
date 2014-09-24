//
//  NetworkRegisterParser.h
//  buckworm
//
//  Created by Developer on 7/17/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VITJSONParser.h"

@protocol NetworkRegisterParserDelegate;
@interface NetworkRegisterParser : VITJSONParser
{

}
@property(nonatomic, assign) __unsafe_unretained id <NetworkRegisterParserDelegate> callBack;

- (void)startParsing;

@end

@protocol NetworkRegisterParserDelegate <NSObject>

@optional
- (void)NetworkRegisterParserFinished:(NSDictionary *)dictData;
@optional
- (void)errorInParseing:(NSError *)error;

@end