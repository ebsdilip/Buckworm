//
//  BWDigitalCouponFeedbackView.h
//  buckworm
//
//  Created by Developer on 8/14/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BW_Feedback_BL.h"

@class BW_DigitalCouponDownloaded_ViewController;
@interface BWDigitalCouponFeedbackView : UIView <UITextFieldDelegate, UITextViewDelegate, BW_Feedback_BL_Delegate>
{
    BW_DigitalCouponDownloaded_ViewController *callBack;
    BW_Feedback_BL *objFeedbackBL;
    
    int rating;

    UIView *viewBox;
    
    UIImageView *imgStar1;
    UIImageView *imgStar2;
    UIImageView *imgStar3;
    UIImageView *imgStar4;
    UIImageView *imgStar5;
    
    UITextField *txtFieldDolar;
    UITextView *txtViewComment;
}

@property(nonatomic) NSString *strMerchantID;

@property(nonatomic)BW_DigitalCouponDownloaded_ViewController *callBack;
@end
