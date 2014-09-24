//
//  BW_DigitalOperation_BL.h
//  buckworm
//
//  Created by Developer on 8/11/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_Base_BL.h"
#import "DigitalOperationParser.h"

@protocol BW_DigitalOperation_BL_Delegate;
@interface BW_DigitalOperation_BL : BW_Base_BL <DigitalOperationParserDelegate>
{
    
}

@property(nonatomic,assign)__unsafe_unretained id <BW_DigitalOperation_BL_Delegate> callBack;

- (void)linkOffer:(NSString *)strCampaignUUID;
- (void)unlinkOffer:(NSString *)strOfferType;
- (void)markAsRedeemedOffer:(NSString *)strCampaignUUID andLinkID:(NSString *)strLinkID;;
- (void)markAsLockedOffer:(NSString *)strCampaignUUID andLinkID:(NSString *)strLinkID;

@end

@protocol BW_DigitalOperation_BL_Delegate <NSObject>

@optional
- (void)errorInParseing:(NSError *)error;
@optional
- (void)linkungParserFinished:(NSDictionary *)dictOffers;
@optional
- (void)unlinkingParserFinished:(NSDictionary *)dictOffers;
@optional
- (void)markingAsRedeemedParserFinished:(NSDictionary *)dictOffers;
@optional
- (void)markingAsLockedParserFinished:(NSDictionary *)dictData;

@end