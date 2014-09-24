//
//  MerchantDetailPaser.h
//  buckworm
//
//  Created by Developer on 8/21/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "VITJSONParser.h"

@protocol MerchantDetailPaserDelegate;
@interface MerchantDetailPaser : VITJSONParser
{
    NSString *strMerchantID;
}

@property(nonatomic) NSString *strMerchantID;

@property(nonatomic,assign)__unsafe_unretained id <MerchantDetailPaserDelegate>callBack;

- (void)startParsing;

@end

@protocol MerchantDetailPaserDelegate <NSObject>

@optional
- (void)merchantDetailPaserFinished:(NSDictionary *)dictOffers;
@optional
- (void)errorInParseing:(NSError *)error;

@end