//
//  BW_DigitalCouponDownloaded_ViewController.h
//  buckworm
//
//  Created by Developer on 8/11/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_Base_ViewController.h"
#import "BW_DigitalOperation_BL.h"
#import "BWDigitalCouponFeedbackView.h"

@interface BW_DigitalCouponDownloaded_ViewController : BW_Base_ViewController <BW_DigitalOperation_BL_Delegate, UIAlertViewDelegate>
{
    BWDigitalCouponFeedbackView *viewFeedback;
    NSDictionary *dictCoupon;
    UIScrollView *scrlView;
    NSURL *urlSelected;

    BW_DigitalOperation_BL *objDigitalOpBL;

    UILabel *lblTimer;
    NSTimer *timerCoupon;
    int seconds;
    BOOL isExiting;
    BOOL isFromViewDidLoad;
    UIView *customAlertBG;
}

@property(nonatomic) UIImage *imgOffer;
@property(nonatomic) NSString *strImagePath;
@property(nonatomic) NSDictionary *dictCoupon;
@property(nonatomic) NSInteger intCategory;

@end
