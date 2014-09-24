//
//  BW_MyCards_BL.h
//  buckworm
//
//  Created by TechSunRise on 6/19/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BW_Base_BL.h"

#import "AddCardURLParser.h"
#import "CardsListParser.h"

@protocol BW_MyCards_BL_Delegate;
@interface BW_MyCards_BL : BW_Base_BL <AddCardURLParserDelegate, CardsListParserDelegate>
{

}

@property(nonatomic,assign)__unsafe_unretained id <BW_MyCards_BL_Delegate>callBack;

- (void)getAddCardURL;
- (void)getCards;

@end

@protocol BW_MyCards_BL_Delegate <NSObject>

@optional
- (void)errorInParseing:(NSError *)error;
@optional
- (void)AddCardURLParserFinished:(NSString *)strAddCardURL;
@optional
- (void)CardsListParserFinished:(NSDictionary *)dictData;

@end