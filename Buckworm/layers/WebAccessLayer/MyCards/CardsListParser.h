//
//  CardsListParser.h
//  buckworm
//
//  Created by TechSunRise on 6/28/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VITJSONParser.h"

@protocol CardsListParserDelegate;
@interface CardsListParser : VITJSONParser
{
    __unsafe_unretained id <CardsListParserDelegate>callBack;
}

@property(nonatomic,assign)__unsafe_unretained id <CardsListParserDelegate>callBack;


- (void)startParsing;

@end


@protocol CardsListParserDelegate <NSObject>

@optional
- (void)CardsListParserFinished:(NSDictionary *)dictData;
@optional
- (void)errorInParseing:(NSError *)error;

@end