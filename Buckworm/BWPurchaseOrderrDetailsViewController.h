//
//  BWPurchaseOrderrDetailsViewController.h
//  Buckworm
//
//  Created by iLabours on 9/12/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BW_Base_ViewController.h"
#import "Stripe.h"
#import "BW_Stripe_BL.h"

@interface BWPurchaseOrderrDetailsViewController : BW_Base_ViewController <UITableViewDataSource, UITableViewDelegate, BW_Stripe_BL_Delegate>
{
    BW_Stripe_BL *objStripeBL;
    UIImageView *imgViewOffer;
    UIImageView *imgViewOfferShadow;
    UITableView *tblOrder;
    UIButton *btnBuy;
    
    UIImageView *imgViewCardType;
    NSString *strCouponCode;
}
@property(nonatomic) NSDictionary *dictOffer;
@property(nonatomic) UITableView *tblOrder;

@property(nonatomic) UIButton *btnBuy;
@property(nonatomic) STPCard *card;
@property(nonatomic) NSString *strTitle;
@property(nonatomic) NSString *strPurchasePrice;
@property(nonatomic) NSString *strPrice;
@property(nonatomic) NSString *strCampaign_uuid;

@property(nonatomic) UIImage *imageOffer;

// STRIPE
@property (strong, nonatomic) IBOutlet UITableView* tableView;
@property (strong, nonatomic) IBOutlet UIView* buttonView;
@property (strong, nonatomic) IBOutlet UIButton* completeButton;

@property (strong, nonatomic) UITextField* nameTextField;
@property (strong, nonatomic) UITextField* emailTextField;
@property (strong, nonatomic) UITextField* expirationDateTextField;
@property (strong, nonatomic) UITextField* cardNumber;
@property (strong, nonatomic) UITextField* CVCNumber;

@property (strong, nonatomic) NSArray* monthArray;
@property (strong, nonatomic) NSNumber* selectedMonth;
@property (strong, nonatomic) NSNumber* selectedYear;
@property (strong, nonatomic) UIPickerView *expirationDatePicker;

//@property (strong, nonatomic) AFJSONRequestOperation* httpOperation;


@end
