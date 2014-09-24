//
//  WishwornOperationParser.h
//  buckworm
//
//  Created by Developer on 7/19/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VITJSONParser.h"

@protocol WishwornOperationParserDelegate;
@interface WishwornOperationParser : VITJSONParser
{
    NSString *strOperation;
    NSString *strOfferID;
    NSString *strMerchantID;
    NSString *strWish;
    NSString *strCampaignuuID;
    NSString *strAccountToken;
    __unsafe_unretained id <WishwornOperationParserDelegate>callBack;
}

@property(nonatomic) NSString *strOperation;
@property(nonatomic) NSString *strOfferID;
@property(nonatomic) NSString *strMerchantID;
@property(nonatomic) NSString *strWish;
@property(nonatomic) NSString *strCampaignuuID;
@property(nonatomic) NSString *strAccountToken;

@property(nonatomic,assign)__unsafe_unretained id <WishwornOperationParserDelegate>callBack;

- (void)startParsing;

@end

@protocol WishwornOperationParserDelegate <NSObject>

@optional
- (void)errorInParseing:(NSError *)error;
@optional
- (void)wishwormOperationsParserFinished:(NSDictionary *)dictOffers;

@end