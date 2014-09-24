//
//  BW_Share_BL.h
//  buckworm
//
//  Created by Developer on 8/11/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_Base_BL.h"
#import "ShareParser.h"

@protocol BW_Share_BL_Delegate;
@interface BW_Share_BL : BW_Base_BL <ShareParserDelegate>
{

}

@property(nonatomic,assign)__unsafe_unretained id <BW_Share_BL_Delegate> callBack;

- (void)shareOffer:(NSString *)strOfferID toEmails:(NSString *)strToEmails;


@end

@protocol BW_Share_BL_Delegate <NSObject>

@optional
- (void)errorInParseing:(NSError *)error;
@optional
- (void)ShareParserFinished:(NSDictionary *)dictOffers;

@end