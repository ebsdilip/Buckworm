//
//  BW_MerchentLocation_BL.h
//  buckworm
//
//  Created by TechSunRise on 8/5/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_Base_BL.h"
#import "MerchentLocationParesr.h"
#import "MerchentDetailParser.h"

@protocol BW_MerchentLocation_BL_Delegate;
@interface BW_MerchentLocation_BL : BW_Base_BL <MerchentLocationParesrDelegate, MerchentDetailParserDelegate>
{
    __unsafe_unretained id <BW_MerchentLocation_BL_Delegate>callBack;

}

@property(nonatomic, assign) __unsafe_unretained id <BW_MerchentLocation_BL_Delegate>callBack;

- (void)getMerchantsOfLat:(NSString *)strLat andLong:(NSString *)strLong;
- (void)getMerchantsDetails:(NSString *)strMerchentID;

@end

@protocol BW_MerchentLocation_BL_Delegate <NSObject>

@optional
- (void)errorInParseing:(NSError *)error;
@optional
- (void)MerchentLocationParserFinished:(NSDictionary *)dictOffers;
@optional
- (void)MerchentDetailParserFinished:(NSDictionary *)dictOffers;

@end