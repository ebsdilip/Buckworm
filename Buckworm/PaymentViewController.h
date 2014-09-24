//
//  ViewController.h
//  PTKPayment Example
//
//  Created by Alex MacCaw on 1/21/13.
//  Copyright (c) 2013 Stripe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTKView.h"
#import "BW_Base_ViewController.h"
#import "BW_Stripe_BL.h"

@class BWPurchaseOrderrDetailsViewController;
@interface PaymentViewController : BW_Base_ViewController <PTKViewDelegate, BW_Stripe_BL_Delegate>
{
    BW_Stripe_BL *objStripeBL;
    UIButton *btnSave;
}

@property(nonatomic) BWPurchaseOrderrDetailsViewController *objPurchaseOrderVC;
@property(nonatomic) NSString *strAmount;
@property(nonatomic) NSString *strCampaign_uuid;

@end
