//
//  BW_DigitalAndPurchaseOffer_BL.h
//  buckworm
//
//  Created by Developer on 8/11/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_Base_BL.h"
#import "DigitalAndPurchaseOfferParser.h"

@protocol BW_DigitalAndPurchaseOffer_BL_Delegate;
@interface BW_DigitalAndPurchaseOffer_BL : BW_Base_BL <DigitalAndPurchaseOfferParserDelegate>
{
    
}

@property(nonatomic,assign)__unsafe_unretained id <BW_DigitalAndPurchaseOffer_BL_Delegate> callBack;

- (void)getAvailableOffer:(NSString *)strOfferType;
- (void)getLinkedOffer:(NSString *)strOfferType;
- (void)getRedeemedOffer:(NSString *)strOfferType;
- (void)getExpiredOffer:(NSString *)strOfferType;

@end

@protocol BW_DigitalAndPurchaseOffer_BL_Delegate <NSObject>

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