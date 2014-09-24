//
//  BWPurchasedCouponViewController.h
//  Buckworm
//
//  Created by iLabours on 9/19/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BW_Base_ViewController.h"
#import "BW_DigitalOperation_BL.h"

@interface BWPurchasedCouponViewController : BW_Base_ViewController <BW_DigitalOperation_BL_Delegate>
{
    BW_DigitalOperation_BL *objDigitalOpBL;
    UILabel *lblTitle;
    UIView *viewDetailBG;
    UILabel *lblOfferTitle;
    UILabel *lblMerchant;
    UIButton *btnMarkRedeem;
    UILabel *lblCoupon;
    UILabel *lblCouponCode;
    UILabel *lblCustomer;
    UILabel *lblCustomerName;
    
    UIImageView *imgViewRedeemed;
    UILabel *lblRedeemedOn;
}

@property(nonatomic) NSMutableDictionary *dictOffer;

@end
