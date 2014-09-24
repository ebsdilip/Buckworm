//
//  BWCardInfoViewController.h
//  Buckworm
//
//  Created by iLabours on 9/17/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BW_Base_ViewController.h"
#import "Stripe.h"
#import "PTKView.h"

@interface BWCardInfoViewController : BW_Base_ViewController <UITableViewDataSource, UITableViewDelegate, PTKViewDelegate>
{
    STPCard *card;
    PTKView *paymentView;
    UITableView *tblPayment;
    
    UIButton *btnDelete;
    UIButton *btnEdit;

    UIView *viewAccount;
    UIButton *btnConfirm;
    
    UITextField *txtFieldCardHolder;
    UITextField *txtFieldCardNumber;
    UITextField *txtFieldCardExpiryDate;
    UITextField *txtFieldCardCVC;

}

@property(nonatomic) PTKView *paymentView;
@property(nonatomic) STPCard *card;

@end
