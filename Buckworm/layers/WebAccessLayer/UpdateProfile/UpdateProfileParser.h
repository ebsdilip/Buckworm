//
//  UpdateProfileParser.h
//  buckworm
//
//  Created by TechSunRise on 6/27/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VITJSONParser.h"

@protocol UpdateProfileParserDelegate;
@interface UpdateProfileParser : VITJSONParser
{
    NSString *strUpdate;
    __unsafe_unretained id <UpdateProfileParserDelegate>callBack;
}

@property(nonatomic) NSString *strUpdate;
@property(nonatomic,assign)__unsafe_unretained id <UpdateProfileParserDelegate>callBack;

- (void)startParsing;

@end


@protocol UpdateProfileParserDelegate <NSObject>

@optional
- (void)UpdateProfileParserFinished:(NSDictionary *)dictData;
@optional
- (void)errorInParseing:(NSError *)error;

@end