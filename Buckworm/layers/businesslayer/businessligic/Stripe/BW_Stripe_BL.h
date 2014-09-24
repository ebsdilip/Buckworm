//
//  BW_Stripe_BL.h
//  Buckworm
//
//  Created by iLabours on 9/16/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_Base_BL.h"
#import "BWStripeParser.h"

@protocol BW_Stripe_BL_Delegate;
@interface BW_Stripe_BL : BW_Base_BL <BWStripeParserDelegate>
{
    NSString *strAction;
}

@property(nonatomic) NSString *strAction;
@property(nonatomic,assign)__unsafe_unretained id <BW_Stripe_BL_Delegate>callBack;

- (void)makePaymentFor:(NSString *)strUUID andAmount:(NSString *)strAmount andToken:(NSString *)strToken;
- (void)refundPaymentFor:(NSString *)strOrderNumber andDescription:(NSString *)strDescription;


@end

@protocol BW_Stripe_BL_Delegate <NSObject>

@optional
- (void)paymentParserFinished:(NSDictionary *)dictData;
@optional
- (void)refundParserFinished:(NSDictionary *)dictData;
@optional
- (void)errorInParseing:(NSError *)error;

@end