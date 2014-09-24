//
//  LinkUnlinkParser.h
//  buckworm
//
//  Created by TechSunRise on 6/28/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VITJSONParser.h"

@protocol LinkUnlinkParserDelegate;
@interface LinkUnlinkParser : VITJSONParser
{
    NSString *strMethod;
    NSString *strOfferID;
    NSString *strAccount;
    
    __unsafe_unretained id <LinkUnlinkParserDelegate>callBack;
}

@property(nonatomic) NSString *strMethod;
@property(nonatomic) NSString *strOfferID;
@property(nonatomic) NSString *strAccount;

@property(nonatomic,assign)__unsafe_unretained id <LinkUnlinkParserDelegate>callBack;

- (void)startParsing;

@end


@protocol LinkUnlinkParserDelegate <NSObject>

@optional
- (void)LinkParserFinished:(NSDictionary *)dictData;
@optional
- (void)UnlinkParserFinished:(NSDictionary *)dictData;
@optional
- (void)errorInParseing:(NSError *)error;

@end