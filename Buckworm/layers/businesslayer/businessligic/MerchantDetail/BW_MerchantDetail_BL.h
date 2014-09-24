//
//  BW_MerchantDetail_BL.h
//  buckworm
//
//  Created by Developer on 8/21/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_Base_BL.h"
#import "MerchantDetailPaser.h"

@protocol BW_MerchantDetail_BL_Delegate;
@interface BW_MerchantDetail_BL : BW_Base_BL <MerchantDetailPaserDelegate>
{

}

@property(nonatomic,assign)__unsafe_unretained id <BW_MerchantDetail_BL_Delegate>callBack;

- (void)getDetailsOfMerchant:(NSString *)strMerchantID;

@end

@protocol BW_MerchantDetail_BL_Delegate <NSObject>

@optional
- (void)merchantDetailPaserFinished:(NSDictionary *)dictOffers;
@optional
- (void)errorInParseing:(NSError *)error;

@end