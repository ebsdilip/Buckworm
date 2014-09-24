//
//  BW_Feedback_BL.h
//  buckworm
//
//  Created by Developer on 8/16/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_Base_BL.h"
#import "FeedbackParser.h"

@protocol BW_Feedback_BL_Delegate;
@interface BW_Feedback_BL : BW_Base_BL <FeedbackParserDelegate>
{

}

@property(nonatomic,assign)__unsafe_unretained id <BW_Feedback_BL_Delegate>callBack;

- (void)sendFeedback:(NSMutableDictionary *)dictFeedback;

@end


@protocol BW_Feedback_BL_Delegate <NSObject>

@optional
- (void)errorInParseing:(NSError *)error;
@optional
- (void)feedbackParserFinished:(NSDictionary *)json;

@end