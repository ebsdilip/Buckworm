//
//  DigitalAndPurchaseOfferParser.h
//  buckworm
//
//  Created by Developer on 8/11/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "VITJSONParser.h"

@protocol DigitalAndPurchaseOfferParserDelegate;
@interface DigitalAndPurchaseOfferParser : VITJSONParser
{
    NSString *strCampaignID;
    NSString *strOfferType;
    NSString *strOfferSubCategory;
}
@property(nonatomic) NSString *strCampaignID;
@property(nonatomic) NSString *strOfferType;
@property(nonatomic) NSString *strOfferSubCategory;

@property(nonatomic,assign)__unsafe_unretained id <DigitalAndPurchaseOfferParserDelegate>callBack;

- (void)startParsing;

@end

@protocol DigitalAndPurchaseOfferParserDelegate <NSObject>

@optional
- (void)errorInParseing:(NSError *)error;
@optional
- (void)availableOfferParserFinished:(NSDictionary *)dictOffers;
@optional
- (void)linkedOfferParserFinished:(NSDictionary *)dictOffers;
@optional
- (void)redeemedOfferParserFinished:(NSDictionary *)dictOffers;
@optional
- (void)expiredOfferParserFinished:(NSDictionary *)dictOffers;
@end