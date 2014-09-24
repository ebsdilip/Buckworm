//
//  BW_SurveyBox_BL.h
//  buckworm
//
//  Created by Developer on 8/16/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_Base_BL.h"
#import "SurvetBoxParser.h"

@protocol BW_SurveyBox_BL_Delegate;
@interface BW_SurveyBox_BL : BW_Base_BL <survetBoxParserDelegate>
{
    
}

@property(nonatomic,assign)__unsafe_unretained id <BW_SurveyBox_BL_Delegate>callBack;

- (void)setSelectedSurvey:(NSString *)strText forOffer:(NSString *)strCID;

@end


@protocol BW_SurveyBox_BL_Delegate <NSObject>

@optional
- (void)errorInParseing:(NSError *)error;
@optional
- (void)survetBoxParserFinished:(NSDictionary *)dictOffers;

@end