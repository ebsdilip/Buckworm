//
//  AddCardURLParser.h
//  buckworm
//
//  Created by TechSunRise on 6/19/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VITJSONParser.h"

@protocol AddCardURLParserDelegate;
@interface AddCardURLParser : VITJSONParser
{
    __unsafe_unretained id <AddCardURLParserDelegate>callBack;
}

@property(nonatomic,assign)__unsafe_unretained id <AddCardURLParserDelegate>callBack;


- (void)startParsing;

@end


@protocol AddCardURLParserDelegate <NSObject>

@optional
- (void)AddCardURLParserFinished:(NSDictionary *)dictData;
@optional
- (void)errorInParseing:(NSError *)error;

@end