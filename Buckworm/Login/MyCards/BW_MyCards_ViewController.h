//
//  BW_MyCards_ViewController.h
//  Buckworm
//
//  Created by Developer on 6/10/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BW_Base_ViewController.h"
#import "BW_MyCards_BL.h"
#import "BW_Login_BL.h"

@interface BW_MyCards_ViewController : BW_Base_ViewController <UITableViewDataSource, UITableViewDelegate, BW_MyCards_BL_Delegate, BW_Login_BL_Delegate>
{
    BW_MyCards_BL *objCardBL;
    BW_Login_BL *objLoginBL;
    
    UITableView *tblCards;
    UILabel *lblMessageOfferNotAvailable;
    NSMutableArray *arrCards;
    NSInteger intTag;
    UIWebView *webView;

    NSString *strSelectedCard;
}

@property(nonatomic) UIViewController *callbackToHome;
@property(nonatomic) NSInteger intTag;

@end
