//
//  BWMyCouponsViewController.h
//  Buckworm
//
//  Created by iLabours on 8/30/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollViewInView.h"
#import "BW_DigitalAndPurchaseOffer_BL.h"
#import "BW_DigitalAndPurchaseOffer_BL.h"

@interface BWMyCouponsViewController : BWBaseViewController <UITableViewDataSource, UITableViewDelegate, BW_DigitalAndPurchaseOffer_BL_Delegate, UIAlertViewDelegate>
{
    UILabel *lblMessage;
    NSMutableArray *arrOffer;
    UIScrollViewInView *scrlViewCategory;
    UIScrollView *scrlViewContent;
    BW_DigitalAndPurchaseOffer_BL *objDC_BL;

    UIView *viewSlide;
    
    UIButton *btnTab1UI;
    UIButton *btnTab2UI;
    UIButton *btnTab3UI;

    UITableView *tblCat1;
    UITableView *tblCat2;
    UITableView *tblCat3;

    UIImage *imgOffer;
    
    NSString *strImagePath;
    
    NSInteger intOffset;
    UIView *customAlertBG;
}

@end
