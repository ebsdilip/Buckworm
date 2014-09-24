//
//  BWCateoryOfferBL.h
//  Buckworm
//
//  Created by iLabours on 8/29/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_Base_BL.h"
#import "CategoryOfferParser.h"

@protocol BWCateoryOfferBL_Delegate;
@interface BWCateoryOfferBL : BW_Base_BL <CategoryOfferParserDelegate>
{

}
@property(nonatomic,assign)__unsafe_unretained id <BWCateoryOfferBL_Delegate>callBack;

- (void)getOfferOfCategory:(NSString *)strCat andType:(NSString *)strType;

@end

@protocol BWCateoryOfferBL_Delegate <NSObject>

@optional
- (void)categoryOfferParserFinished:(NSDictionary *)dictData;
@optional
- (void)errorInParseing:(NSError *)error;

@end