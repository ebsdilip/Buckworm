//
//  CategoryOfferParser.h
//  Buckworm
//
//  Created by iLabours on 8/29/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "VITJSONParser.h"

@protocol CategoryOfferParserDelegate;
@interface CategoryOfferParser : VITJSONParser
{
    __unsafe_unretained id <CategoryOfferParserDelegate>callBack;
    
}

@property(nonatomic) NSString *strOfferCategory;
@property(nonatomic) NSString *strOfferType;
@property(nonatomic, assign)     __unsafe_unretained id <CategoryOfferParserDelegate>callBack;

- (void)startParsing;

@end

@protocol CategoryOfferParserDelegate <NSObject>

@optional
- (void)categoryOfferParserFinished:(NSDictionary *)dictData;
@optional
- (void)errorInParseing:(NSError *)error;

@end