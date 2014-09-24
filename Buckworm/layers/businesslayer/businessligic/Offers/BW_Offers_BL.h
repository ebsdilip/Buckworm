//
//  BW_Offers_BL.h
//  buckworm
//
//  Created by TechSunRise on 6/24/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BW_Base_BL.h"
#import "OfferParser.h"
#import "ComingSoonParser.h"

@protocol BW_Offers_BL_Delegate;
@interface BW_Offers_BL : BW_Base_BL <OfferParserDelegate, ComingSoonParserDelegate>
{

}

@property(nonatomic,assign)__unsafe_unretained id <BW_Offers_BL_Delegate>callBack;

- (void)getOffersDemoRedeem;
- (void)getOffers:(NSString *)strOfferType;
- (void)getTeaserOffers;
- (void)getOffersForAnonymousUser:(NSString *)strOfferType;

- (void)getLocalOffersForPostBody:(NSString *)strPostBody;

//- (void)getLocalOffersForAnonymousUser:(NSString *)strOfferType;

@end

@protocol BW_Offers_BL_Delegate <NSObject>

@optional
- (void)errorInParseing:(NSError *)error;
@optional
- (void)OfferParserFinished:(NSDictionary *)dictOffers;
@optional
- (void)ComingSoonParserFinished:(NSDictionary *)dictData;
@optional
- (void)localOfferParserFinished:(NSDictionary *)dictOffers;

@end