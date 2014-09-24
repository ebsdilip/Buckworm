//
//  BWViewController.h
//  Buckworm
//
//  Created by Developer on 8/27/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollViewInView.h"
#import "BWCateoryOfferBL.h"

@class BW_Login_ViewController;
@interface BWViewController : BWBaseViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, BWCateoryOfferBL_Delegate, UIPickerViewDelegate, UIPickerViewDataSource>
{
    BW_Login_ViewController *objLoginVC;
    BWCateoryOfferBL *objCatBL;
    NSString *strImagePath;
    int intOffset;
    
    UIScrollViewInView *scrlViewCategory;
    UIScrollView *scrlViewContent;

    UIView *viewSlide;
    
    UIButton *btnTab1UI;
    UIButton *btnTab2UI;
    UIButton *btnTab3UI;
    UIButton *btnTab4UI;
    UIButton *btnTab5UI;
    UIButton *btnTab6UI;
    UIButton *btnTab7UI;
    
    UITableView *tblCat1;
    UITableView *tblCat2;
    UITableView *tblCat3;
    UITableView *tblCat4;
    UITableView *tblCat5;
    UITableView *tblCat6;
    UITableView *tblCat7;
    
    NSMutableArray *arrOffers;
    NSMutableArray *arrOffersBackUp;
    
    UIView *viewPanel;
    
    NSMutableArray *arrSorted;
    NSMutableDictionary *dictSorted;
    NSMutableArray *arrComingSoon;
    NSMutableDictionary *dictCatOffers;
    NSString *strCatID;
    //WISHWORM
    UIPickerView *pickerOffer;
    UIButton *btnPicketDone;
    BOOL isSingle;
}

@end
