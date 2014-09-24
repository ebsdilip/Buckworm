//
//  SignUpParser.h
//  buckworm
//
//  Created by TechSunRise on 6/28/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VITJSONParser.h"

@protocol SignUpParserDelegate;
@interface SignUpParser : VITJSONParser
{
    NSString *strPostString;
    
    __unsafe_unretained id <SignUpParserDelegate>callBack;
}

@property(nonatomic, retain) NSString *strPostString;

@property(nonatomic,assign)__unsafe_unretained id <SignUpParserDelegate>callBack;

- (void)startParsing;

@end

@protocol SignUpParserDelegate <NSObject>

@optional
- (void)SignUpParserFinished:(NSDictionary *)dictData;
@optional
- (void)errorInParseing:(NSError *)error;

@end