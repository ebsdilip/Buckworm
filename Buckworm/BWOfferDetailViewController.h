//
//  BWOfferDetailViewController.h
//  Buckworm
//
//  Created by iLabours on 8/28/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BW_MerchantDetail_BL.h"
#import "GeoCodeFromAddressParser.h"
#import "BW_DigitalOperation_BL.h"
#import "BW_SurveyBox_BL.h"
#import <MessageUI/MessageUI.h>
#import "BW_LinkUnlink_BL.h"
#import "BW_Login_BL.h"
#import "BWStripeParser.h"
#import "BW_Stripe_BL.h"

@interface BWOfferDetailViewController : BWBaseViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, BW_MerchantDetail_BL_Delegate, GeoCodeFromAddressParserDelegate, BW_DigitalOperation_BL_Delegate, BW_SurveyBox_BL_Delegate, BW_LinkUnlink_BL_Delegate, BW_Login_BL_Delegate, BWStripeParserDelegate, BW_Stripe_BL_Delegate>
{
    BW_Stripe_BL *objStripeBL;
    NSInteger intType;
    NSInteger intStatus;
    
    MKMapView *_mapView;
    NSDictionary *dictMerchant;
    
    BW_MerchantDetail_BL *objMerchantDetailBL;
    BW_DigitalOperation_BL *objLinkUnlinkBL;
    BW_SurveyBox_BL *objSurveyBox_BL;
    
    UILabel *lblHeaderTitle;

    UIScrollView *scrlViewBG;
    UIImageView *imgViewOffer;
    UIImageView *imgViewOfferShadow;
    
    UILabel *lblTitle;
    
    UILabel *lblDownloadedTitle;
    UILabel *lblDownloadedValue;

    UILabel *lblTermsAndConditionTitle;
    UILabel *lblTermsAndConditionValue;

    UILabel *lblDescriptionTitle;
    UILabel *lblDescriptionValue;
    

    UILabel *lblMerchantTitle;
    UIButton *btnMap;
    UIButton *btnRootMap;
    UILabel *lblRootMapAddress;
    UIButton *btnCall;
    UILabel *lblPhoneNumber;
    UIButton *btnBuy;
    
    NSDictionary *dictLocation;
    
    UIView *viewShareOption;
    
    //    Card Rebate
    BW_LinkUnlink_BL *objLinkUnlinkCardRebateBL;
    UIWebView *webViewTC;
    BW_Login_BL *objLoginBL;

    //Purchase
    UIButton *btnCancelOrder;
    NSString *strDescCancel;
    NSArray *arrCancel;
    UIView *viewCancelPopUp;
}
@property(nonatomic) NSInteger intType;
@property(nonatomic) NSInteger intStatus;
@property(nonatomic) NSDictionary *dictOffer;
@property(nonatomic) NSDictionary *dictLocation;
@property(nonatomic) UIImage *imageOffer;
@property(nonatomic) NSString *strImagePath;
// Card Rebate
@property(nonatomic) NSString *strAccountToken;
@property(nonatomic) NSString *strLinkOferID;

@end
