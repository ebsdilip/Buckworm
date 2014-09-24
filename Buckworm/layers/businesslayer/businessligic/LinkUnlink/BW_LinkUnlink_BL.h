//
//  BW_LinkUnlink_BL.h
//  buckworm
//
//  Created by TechSunRise on 6/28/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BW_Base_BL.h"

#import "LinkUnlinkParser.h"

@protocol BW_LinkUnlink_BL_Delegate;
@interface BW_LinkUnlink_BL : BW_Base_BL <LinkUnlinkParserDelegate>
{
    
}
@property(nonatomic,assign)__unsafe_unretained id <BW_LinkUnlink_BL_Delegate>callBack;

- (void)linkOffer:(NSString *)strOfferID andAccountToken:(NSString *)strAccountToken;
- (void)unlinkOffer:(NSString *)strOfferID andAccountToken:(NSString *)strAccountToken;

@end

@protocol BW_LinkUnlink_BL_Delegate <NSObject>

@optional
- (void)errorInParseing:(NSError *)error;
@optional
- (void)LinkParserFinished:(NSDictionary *)dictData;
@optional
- (void)UnlinkParserFinished:(NSDictionary *)dictData;

@end