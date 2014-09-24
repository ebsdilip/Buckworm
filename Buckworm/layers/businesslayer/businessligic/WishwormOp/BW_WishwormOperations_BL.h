//
//  BW_WishwormOperations_BL.h
//  buckworm
//
//  Created by Developer on 7/19/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BW_Base_BL.h"
#import "WishwornOperationParser.h"

@protocol BW_WishwormOperations_BL_Delegate;
@interface BW_WishwormOperations_BL : BW_Base_BL <WishwornOperationParserDelegate>
{

}

@property(nonatomic,assign)__unsafe_unretained id <BW_WishwormOperations_BL_Delegate> callBack;

- (void)makeDownload:(NSString *)strOfferID andCampaignuuid:(NSString *)strCampaignuuID;
- (void)makeDownload:(NSString *)strOfferID andCampaignuuid:(NSString *)strCampaignuuID andAccountToken:(NSString *)strAccountToken;
- (void)selectAnOption:(NSString *)strOptionID;
- (void)makeAWish:(NSString *)strWish toMerchant:(NSString *)strMerchantID;
- (void)lockOffer:(NSString *)strOfferID;

@end

@protocol BW_WishwormOperations_BL_Delegate <NSObject>

@optional
- (void)errorInParseing:(NSError *)error;
@optional
- (void)wishwormOperationsParserFinished:(NSDictionary *)dictOffers;

@end