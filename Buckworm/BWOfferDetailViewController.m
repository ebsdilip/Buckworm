//
//  BWOfferDetailViewController.m
//  Buckworm
//
//  Created by iLabours on 8/28/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BWOfferDetailViewController.h"
#import "BW_MerchantPage_ViewController.h"
#import "BWMapAddressViewController.h"
#import "TechSunRiseMKAnnotation.h"
#import "BW_Login_ViewController.h"
#import <Social/Social.h>

#import "BW_AddCard_ViewController.h"
#import "BW_MyCards_ViewController.h"
#import "BWPurchaseOrderrDetailsViewController.h"
#import "BWPurchasedCouponViewController.h"

@interface BWOfferDetailViewController ()

@end

@implementation BWOfferDetailViewController

@synthesize intType;
@synthesize intStatus;
@synthesize dictOffer;
@synthesize dictLocation;
@synthesize imageOffer;
@synthesize strImagePath;
@synthesize strAccountToken;
@synthesize strLinkOferID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        objLinkUnlinkBL = [[BW_DigitalOperation_BL alloc] init];
        objLinkUnlinkBL.callBack = self;
        
        objSurveyBox_BL = [[BW_SurveyBox_BL alloc] init];
        objSurveyBox_BL.callBack = self;

        objMerchantDetailBL = [[BW_MerchantDetail_BL alloc] init];
        objMerchantDetailBL.callBack = self;
        
        // Card Rebate
        objLinkUnlinkCardRebateBL = [[BW_LinkUnlink_BL alloc] init];
        objLinkUnlinkCardRebateBL.callBack = self;

        // PURCHASE
        objStripeBL = [[BW_Stripe_BL alloc] init];
        objStripeBL.callBack = self;

        objLoginBL = [[BW_Login_BL alloc] init];
        objLoginBL.callBack = self;

        arrCancel = [[NSArray alloc] initWithObjects:@"Decided it wasn’t for me", @"I misunderstood the terms of this deal", @"Oops, wrong credit card", @"Oops, wrong quantity", @"Other", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self screenDesigning];
}

- (void)viewDidAppear:(BOOL)animated
{
//    if(dictMerchant==nil && intStatus==tagLinked)
//        [self getMerchanetDetails];
}

- (void)screenDesigning
{
    dictMerchant = [dictOffer objectForKey:@"merchant"];

    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    viewHeader.backgroundColor = colorGreen;
    [self.view addSubview:viewHeader];
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 22, 40, 40)];
    btnBack.backgroundColor = [UIColor clearColor];
    [btnBack setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon-arrow" ofType:@"png"]] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    btnBack = nil;

    lblHeaderTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 200, 40)];
    lblHeaderTitle.textAlignment = NSTextAlignmentCenter;
    lblHeaderTitle.text = [[[dictMerchant objectForKey:@"business_name"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] stringByConvertingHTMLToPlainText];
    lblHeaderTitle.font = [UIFont boldSystemFontOfSize:16.0];
    lblHeaderTitle.numberOfLines = 2;
    lblHeaderTitle.textColor = [UIColor whiteColor];
    lblHeaderTitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblHeaderTitle];

    scrlViewBG = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, 320, IS_IPHONE_5?500:420)];
    scrlViewBG.backgroundColor = colorTableBG;
    [self.view addSubview:scrlViewBG];

    float yRef = 0.0;
    imgViewOffer = [[UIImageView alloc] init];
    imgViewOffer.image = imageOffer;
    imgViewOffer.frame = CGRectMake(0, yRef, 320, 180);
    imgViewOffer.backgroundColor = [UIColor clearColor];
    imgViewOffer.layer.borderWidth = 1.0;
    imgViewOffer.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [scrlViewBG addSubview:imgViewOffer];

    imgViewOfferShadow = [[UIImageView alloc] init];
    imgViewOfferShadow.frame = CGRectMake(0, yRef, 320, 180);
    imgViewOfferShadow.backgroundColor = [UIColor clearColor];
    imgViewOfferShadow.layer.borderWidth = 1.0;
    imgViewOfferShadow.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"black" ofType:@"png"]];
    imgViewOfferShadow.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [scrlViewBG addSubview:imgViewOfferShadow];

    yRef += imgViewOfferShadow.frame.size.height;
    
    NSString *strTitle = [[[self.dictOffer objectForKey:@"offer_title"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] stringByConvertingHTMLToPlainText];
    
    CGSize size = [strTitle sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    UIView *viewTitle = [[UIView alloc] initWithFrame:CGRectMake(0, yRef, 320, size.height+30)];
    viewTitle.backgroundColor = [UIColor whiteColor];
    viewTitle.layer.shadowColor = [UIColor grayColor].CGColor;
    viewTitle.layer.masksToBounds = NO;
    viewTitle.layer.shadowOffset = CGSizeMake(-0, 1);
    viewTitle.layer.shadowRadius = 1;
    viewTitle.layer.shadowOpacity = 1.0;
    [scrlViewBG addSubview:viewTitle];

    lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, yRef+5, 300, size.height)];
    lblTitle.font = [UIFont systemFontOfSize:16.0];
    lblTitle.numberOfLines = 2;
    lblTitle.text = strTitle;
    lblTitle.textColor = [UIColor darkGrayColor];
    lblTitle.backgroundColor = [UIColor clearColor];
    [scrlViewBG addSubview:lblTitle];

    yRef += lblTitle.frame.size.height+5;
    
    lblDownloadedTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, yRef, 80, 20)];
    lblDownloadedTitle.text = @"Downloaded";
    lblDownloadedTitle.font = [UIFont systemFontOfSize:12.0];
    lblDownloadedTitle.textColor = [UIColor grayColor];
    lblDownloadedTitle.backgroundColor = [UIColor clearColor];
    [scrlViewBG addSubview:lblDownloadedTitle];
    
    lblDownloadedValue = [[UILabel alloc] initWithFrame:CGRectMake(90, yRef, 60, 20)];
    lblDownloadedValue.font = [UIFont systemFontOfSize:12.0];
    lblDownloadedValue.textColor = [UIColor blackColor];
    lblDownloadedValue.text = [dictOffer objectForKey:@"downloads"];
    lblDownloadedValue.backgroundColor = [UIColor clearColor];
    [scrlViewBG addSubview:lblDownloadedValue];

    yRef += lblDownloadedValue.frame.size.height+20;

    NSString *strDescription = [[[self.dictOffer objectForKey:@"offer_description"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] stringByConvertingHTMLToPlainText];

    size = [strDescription sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];

    viewTitle = [[UIView alloc] initWithFrame:CGRectMake(0, yRef, 320, 30+size.height+15)];
    viewTitle.backgroundColor = [UIColor whiteColor];
    viewTitle.layer.shadowColor = [UIColor grayColor].CGColor;
    viewTitle.layer.masksToBounds = NO;
    viewTitle.layer.shadowOffset = CGSizeMake(-0, 1);
    viewTitle.layer.shadowRadius = 1;
    viewTitle.layer.shadowOpacity = 1.0;
    [scrlViewBG addSubview:viewTitle];

    lblDescriptionTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, yRef, 300, 28)];
    lblDescriptionTitle.text = @"Description";
    lblDescriptionTitle.font = [UIFont systemFontOfSize:16.0];
    lblDescriptionTitle.textColor = [UIColor blackColor];
    lblDescriptionTitle.backgroundColor = [UIColor clearColor];
    [scrlViewBG addSubview:lblDescriptionTitle];
    
    UIImageView *imgViewSep = [[UIImageView alloc] initWithFrame:CGRectMake(0, yRef+28, 320, 2)];
    imgViewSep.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cellSeperator" ofType:@"png"]];
    [scrlViewBG addSubview:imgViewSep];
    
    lblDescriptionValue = [[UILabel alloc] initWithFrame:CGRectMake(10, yRef+35, 300, size.height)];
    lblDescriptionValue.text = strDescription;
    lblDescriptionValue.font = [UIFont systemFontOfSize:14.0];
    lblDescriptionValue.textColor = [UIColor darkGrayColor];
    lblDescriptionValue.numberOfLines = 0;
    lblDescriptionValue.backgroundColor = [UIColor clearColor];
    [scrlViewBG addSubview:lblDescriptionValue];
    
    yRef += viewTitle.frame.size.height+5;

    lblMerchantTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, yRef, 300, 30)];
    lblMerchantTitle.font = [UIFont systemFontOfSize:14.0];
    lblMerchantTitle.textColor = [UIColor blackColor];
    lblMerchantTitle.backgroundColor = [UIColor clearColor];
    [scrlViewBG addSubview:lblMerchantTitle];

    yRef += lblMerchantTitle.frame.size.height+5;

    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, yRef, 320, 161)];
    _mapView.showsUserLocation = YES;// YES if want to show current location on map
    //	[_mapView setDelegate:self];
	[scrlViewBG addSubview:_mapView];
    [_mapView setZoomEnabled:YES];
	[_mapView setScrollEnabled:YES];

    btnMap = [[UIButton alloc] initWithFrame:CGRectMake(0, yRef, 320, 161)];
    btnMap.backgroundColor = [UIColor clearColor];
    [btnMap addTarget:self action:@selector(mapClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrlViewBG addSubview:btnMap];
    
    yRef += btnMap.frame.size.height;
    
    btnRootMap = [[UIButton alloc] initWithFrame:CGRectMake(0, yRef, 320, 57)];
    btnRootMap.titleLabel.font = [UIFont systemFontOfSize:12];
    btnRootMap.titleLabel.numberOfLines = 3;
    [btnRootMap setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btnRootMap setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"rootMapButton" ofType:@"png"]] forState:UIControlStateNormal];
    [btnRootMap addTarget:self action:@selector(rootMapClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrlViewBG addSubview:btnRootMap];

    lblRootMapAddress = [[UILabel alloc] initWithFrame:CGRectMake(35, yRef, 275, 57)];
    lblRootMapAddress.font = [UIFont systemFontOfSize:14];
    lblRootMapAddress.backgroundColor = [UIColor clearColor];
    lblRootMapAddress.numberOfLines = 3;
    lblRootMapAddress.textColor = [UIColor grayColor];
    [scrlViewBG addSubview:lblRootMapAddress];

    yRef += btnRootMap.frame.size.height;

    //
    NSString *strPhone = [NSString stringWithFormat:@"%@", [dictMerchant objectForKey:@"phone_no"]?[dictMerchant objectForKey:@"phone_no"]:@""];
    NSString *strWeb = [dictMerchant objectForKey:@"website"];
    
    float fAdd = 20;
    if(strPhone && [strPhone length]>0)
    {
        btnCall = [[UIButton alloc] initWithFrame:CGRectMake(0, yRef, 160, 46)];
        [btnCall setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btnCall.titleLabel.font = [UIFont systemFontOfSize:14];
        [btnCall setTitle:strPhone forState:UIControlStateNormal];
        [btnCall setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"callButton" ofType:@"png"]] forState:UIControlStateNormal];
        [btnCall addTarget:self action:@selector(callClicked:) forControlEvents:UIControlEventTouchUpInside];
        [scrlViewBG addSubview:btnCall];
        
        lblPhoneNumber = [[UILabel alloc] initWithFrame:CGRectMake(35, yRef, 115, 46)];
        lblPhoneNumber.font = [UIFont systemFontOfSize:14];
        lblPhoneNumber.text = strPhone;
        lblPhoneNumber.backgroundColor = [UIColor clearColor];
        lblPhoneNumber.textColor = [UIColor grayColor];
        [scrlViewBG addSubview:lblPhoneNumber];
        fAdd = 66;
    }
    if(strWeb && [strWeb length]>0)
    {
        UIButton *btnWebsite = [[UIButton alloc] initWithFrame:CGRectMake(160, yRef, 160, 46)];
        [btnWebsite setTitle:[dictOffer objectForKey:@"merchant_id"] forState:UIControlStateNormal];
        [btnWebsite setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"websiteButton" ofType:@"png"]] forState:UIControlStateNormal];
        [btnWebsite addTarget:self action:@selector(websiteClicked:) forControlEvents:UIControlEventTouchUpInside];
        [scrlViewBG addSubview:btnWebsite];
//        yRef += btnWebsite.frame.size.height+20;
        if(fAdd == 20)
            fAdd = 66;
        btnWebsite = nil;
    }

    yRef += fAdd;
    //Terms And Condition
    NSString *strTAndC = [[dictOffer objectForKey:@"offer_term_and_condition"] stringByConvertingHTMLToPlainText];
    
    size = [strTAndC sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];

    viewTitle = [[UIView alloc] initWithFrame:CGRectMake(0, yRef, 320, 50+size.height)];
    viewTitle.backgroundColor = [UIColor whiteColor];
    viewTitle.layer.shadowColor = [UIColor grayColor].CGColor;
    viewTitle.layer.masksToBounds = NO;
    viewTitle.layer.shadowOffset = CGSizeMake(-0, 1);
    viewTitle.layer.shadowRadius = 1;
    viewTitle.layer.shadowOpacity = 1.0;
    [scrlViewBG addSubview:viewTitle];

    lblTermsAndConditionTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, yRef, 300, 30)];
    lblTermsAndConditionTitle.text = @"Terms and Conditions";
    lblTermsAndConditionTitle.font = [UIFont systemFontOfSize:16.0];
    lblTermsAndConditionTitle.textColor = [UIColor blackColor];
    lblTermsAndConditionTitle.backgroundColor = [UIColor clearColor];
    [scrlViewBG addSubview:lblTermsAndConditionTitle];

    yRef += lblTermsAndConditionTitle.frame.size.height;

    UIImageView *imgViewMerchantDetails = [[UIImageView alloc] initWithFrame:CGRectMake(0, yRef, 320, 2)];
    imgViewMerchantDetails.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cellSeperator" ofType:@"png"]];
    [scrlViewBG addSubview:imgViewMerchantDetails];

    lblTermsAndConditionValue = [[UILabel alloc] initWithFrame:CGRectMake(10, yRef+4, 300, size.height)];
    lblTermsAndConditionValue.font = [UIFont systemFontOfSize:14.0];
    lblTermsAndConditionValue.textColor = [UIColor darkGrayColor];
    lblTermsAndConditionValue.numberOfLines = 0;
    lblTermsAndConditionValue.backgroundColor = [UIColor clearColor];
    [scrlViewBG addSubview:lblTermsAndConditionValue];
    lblTermsAndConditionValue.text = strTAndC;

    yRef += viewTitle.frame.size.height+50;
    
    scrlViewBG.contentSize = CGSizeMake(320, yRef);
    
    if(intStatus!=tagLinked && intStatus!=tagRedeemed && intStatus!=tagExpired)
    {
        UIImageView *imgViewBuyButton = [[UIImageView alloc] initWithFrame:CGRectMake(0, IS_IPHONE_5?518:430, 320, 50)];
        imgViewBuyButton.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"black-bg" ofType:@"png"]];
        [self.view addSubview:imgViewBuyButton];
        
        btnBuy = [[UIButton alloc] initWithFrame:CGRectMake(50, IS_IPHONE_5?523:435, 220, 40)];
        [btnBuy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btnBuy.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        [btnBuy setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"done" ofType:@"png"]] forState:UIControlStateNormal];
        [self.view addSubview:btnBuy];

        NSString *strOfferType = [dictOffer objectForKey:@"offer_master_type"]?[dictOffer objectForKey:@"offer_master_type"]:@"";
        if([[strOfferType lowercaseString] isEqualToString:@"digital"])
        {
            [btnBuy setTitle:@"Choose Offer" forState:UIControlStateNormal];
            [btnBuy addTarget:self action:@selector(chooseOffer) forControlEvents:UIControlEventTouchUpInside];
        }
        else if([[strOfferType lowercaseString] isEqualToString:@"card rebate"])
        {
            self.strLinkOferID = [dictOffer objectForKey:@"link_id"]?[dictOffer objectForKey:@"link_id"]:@"";

            if(self.strLinkOferID && [self.strLinkOferID length]>0)
            {
                [btnBuy setTitle:@"Unlink This Offer" forState:UIControlStateNormal];
                [btnBuy addTarget:self action:@selector(unlinkThisOffer) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                [btnBuy setTitle:@"Link This Offer" forState:UIControlStateNormal];
                [btnBuy addTarget:self action:@selector(linkOffer) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        else if([[strOfferType lowercaseString] isEqualToString:@"purchase"])
        {
            self.strLinkOferID = [dictOffer objectForKey:@"link_id"]?[dictOffer objectForKey:@"link_id"]:@"";

            if(self.strLinkOferID && [self.strLinkOferID length]>0)
            {
                [btnBuy setTitle:@"View Coupon" forState:UIControlStateNormal];
                [btnBuy addTarget:self action:@selector(viewVoucher) forControlEvents:UIControlEventTouchUpInside];

                btnCancelOrder = [[UIButton alloc] initWithFrame:CGRectMake(10, yRef-60, 300, 52)];
                [btnCancelOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btnCancelOrder.titleLabel.font = [UIFont boldSystemFontOfSize:24];
                [btnCancelOrder setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"btnCancelOrder" ofType:@"png"]] forState:UIControlStateNormal];
                [scrlViewBG addSubview:btnCancelOrder];
                [btnCancelOrder setTitle:@"Cancel Order" forState:UIControlStateNormal];
                [btnCancelOrder addTarget:self action:@selector(cancelOrderClicked) forControlEvents:UIControlEventTouchUpInside];
                scrlViewBG.contentSize = CGSizeMake(320, yRef+60);
            }
            else
            {
                [btnBuy setTitle:@"Buy" forState:UIControlStateNormal];
                [btnBuy addTarget:self action:@selector(buyOffer) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        else if([[strOfferType lowercaseString] isEqualToString:@"comingsoon"])
        {
            [btnBuy removeFromSuperview];
            [imgViewBuyButton removeFromSuperview];
        }
        else if([[strOfferType lowercaseString] isEqualToString:@"wishworm"])
        {
            [btnBuy removeFromSuperview];
            [imgViewBuyButton removeFromSuperview];
        }
    }
    
    if(appDelegate.objUserLogedIn)
    {
        UIButton *btnShare = [[UIButton alloc] initWithFrame:CGRectMake(280, 26, 32, 32)];
        btnShare.backgroundColor = [UIColor clearColor];
        btnShare.tag = 100;
        [btnShare setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"share" ofType:@"png"]] forState:UIControlStateNormal];
        [btnShare addTarget:self action:@selector(shareClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnShare];
        btnShare = nil;
        
        viewShareOption = [[UIView alloc] initWithFrame:CGRectMake(0, 600, 320, 400)];
        viewShareOption.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
        [self.view addSubview:viewShareOption];
        
        NSArray *arrTemp = [[NSArray alloc] initWithObjects:@"emailButton", @"messageButton", @"facebookButton", @"tweetButton", @"cancelButton", nil];
        for (int i=0; i<[arrTemp count]; i++)
        {
            NSString *strImageName = [arrTemp objectAtIndex:i];
            UIButton *btnShare = [[UIButton alloc] initWithFrame:CGRectMake(10, 10+(i*50), 300, 45)];
            btnShare.tag = 101+i;
            btnShare.backgroundColor = [UIColor clearColor];
            [btnShare setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:strImageName ofType:@"png"]] forState:UIControlStateNormal];
            [btnShare addTarget:self action:@selector(shareClicked:) forControlEvents:UIControlEventTouchUpInside];
            [viewShareOption addSubview:btnShare];
            btnShare = nil;
        }
        
    }

    [self setParameter];
}
- (void)buyOffer
{
    if(appDelegate.objUserLogedIn == nil)
    {
        BW_Login_ViewController *objLoginVC = [[BW_Login_ViewController alloc] init];
        objLoginVC.callBack = self;
        [self presentViewController:objLoginVC animated:YES completion:nil];
    }
    else
    {
        btnBuy.enabled = NO;
        BWPurchaseOrderrDetailsViewController *objVC = [[BWPurchaseOrderrDetailsViewController alloc] init];
        objVC.dictOffer = dictOffer;
        objVC.strTitle = lblTitle.text;
        objVC.strPrice = [dictOffer objectForKey:@"original_price"];
        objVC.strPurchasePrice = [dictOffer objectForKey:@"purchase_price"];
        objVC.strCampaign_uuid = [dictOffer objectForKey:@"campaign_uuid"];
        objVC.imageOffer = imageOffer;
        [self.navigationController pushViewController:objVC animated:YES];
        objVC = nil;
    }
}
- (void)viewVoucher
{
    BWPurchasedCouponViewController *objVC = [[BWPurchasedCouponViewController alloc] init];
    objVC.dictOffer = [[NSMutableDictionary alloc] initWithDictionary:dictOffer];
    [self.navigationController pushViewController:objVC animated:YES];
    objVC = nil;
}

- (void)cancelOrderClicked
{
    if(viewCancelPopUp==nil)
    {
    viewCancelPopUp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
    viewCancelPopUp.backgroundColor = colorTableBG;
    [self.view addSubview:viewCancelPopUp];
    
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    viewHeader.backgroundColor = colorGreen;
    [viewCancelPopUp addSubview:viewHeader];
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 22, 40, 40)];
    btnBack.backgroundColor = [UIColor clearColor];
    [btnBack setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon-arrow" ofType:@"png"]] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(closeCancel) forControlEvents:UIControlEventTouchUpInside];
    [viewCancelPopUp addSubview:btnBack];
    btnBack = nil;
    
    UILabel *lblBarTitle =[[UILabel alloc] initWithFrame:CGRectMake(60, 27, 200, 30)];
    lblBarTitle.font = [UIFont boldSystemFontOfSize:18.0];
    lblBarTitle.textAlignment = NSTextAlignmentCenter;
    lblBarTitle.adjustsFontSizeToFitWidth = YES;
    lblBarTitle.backgroundColor = [UIColor clearColor];
    lblBarTitle.textColor = [UIColor whiteColor];
    lblBarTitle.text = @"Cancel Order";
    [viewCancelPopUp addSubview:lblBarTitle];

    UITableView *tblCancel = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, 500) style:UITableViewStylePlain];
    tblCancel.delegate = self;
    tblCancel.dataSource = self;
    tblCancel.backgroundColor = colorTableBG;
    [viewCancelPopUp addSubview:tblCancel];
    }
}
- (void)closeCancel
{
    [viewCancelPopUp removeFromSuperview];
}
- (void)refundOffer
{
    [DSBezelActivityView newActivityViewForView:self.view
                                      withLabel:@"Canceling order..."];
    
    NSArray *arrTemp = [dictOffer objectForKey:@"purchase_details"];
    NSString *strOfferLinkID = [dictOffer objectForKey:@"link_id"];
    NSString *strOrderNumber;
    for (int i=0; i<[arrTemp count]; i++)
    {
        NSDictionary *dictTemp = [arrTemp objectAtIndex:i];
        NSString *strLinkID = [dictTemp objectForKey:@"link_id"];
        if([strOfferLinkID isEqualToString:strLinkID])
        {
            strOrderNumber = [dictTemp objectForKey:@"orderno"];
        }
    }
    objStripeBL.strAction =@"refund";
    [objStripeBL refundPaymentFor:strOrderNumber andDescription:strDescCancel];
}
- (void)refundParserFinished:(NSDictionary *)dictData
{
    btnBuy.enabled = NO;
    btnCancelOrder.enabled = NO;
    [DSBezelActivityView removeViewAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)chooseOffer
{
    if(appDelegate.objUserLogedIn == nil)
    {
        BW_Login_ViewController *objLoginVC = [[BW_Login_ViewController alloc] init];
        objLoginVC.callBack = self;
        [self presentViewController:objLoginVC animated:YES completion:nil];
    }
    else
        [self linkThisOffer];
}
- (void)linkOffer
{
    if(appDelegate.objUserLogedIn == nil)
    {
        BW_Login_ViewController *objLoginVC = [[BW_Login_ViewController alloc] init];
        objLoginVC.callBack = self;
        [self presentViewController:objLoginVC animated:YES completion:nil];
    }
    else
        [self linkThisOfferCardRebate];
}

- (void)setParameter
{
    // Merchant Details
    lblHeaderTitle.text = [[[dictMerchant objectForKey:@"name"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] uppercaseString];
    lblMerchantTitle.text = [[[dictMerchant objectForKey:@"name"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] uppercaseString];
    if(dictLocation)
    {
        [btnRootMap setTitle:[NSString stringWithFormat:@"%@", [dictLocation objectForKey:@"location"]?[dictLocation objectForKey:@"location"]:@""] forState:UIControlStateNormal];
        lblRootMapAddress.text = [NSString stringWithFormat:@"%@", [dictLocation objectForKey:@"location"]?[dictLocation objectForKey:@"location"]:@""];
        lblHeaderTitle.text = [[[self.dictLocation objectForKey:@"name"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] uppercaseString];
        lblMerchantTitle.text = [[[self.dictLocation objectForKey:@"name"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] uppercaseString];
    }
    else
    {
        NSArray *arrTemp = [dictOffer objectForKey:@"location"];
        if([arrTemp count]>0)
        {
            NSDictionary *dictLoc = [arrTemp objectAtIndex:0];
            [btnRootMap setTitle:[NSString stringWithFormat:@"%@", [dictLoc objectForKey:@"location"]?[dictLoc objectForKey:@"location"]:@""] forState:UIControlStateNormal];
            lblRootMapAddress.text = [NSString stringWithFormat:@"%@", [dictLoc objectForKey:@"location"]?[dictLoc objectForKey:@"location"]:@""];
        }
    }
    [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Loading..."];
    [self getGeoOf:[btnRootMap titleForState:UIControlStateNormal]];

}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)mapClicked:(UIButton *)sender
{
    BWMapAddressViewController *objVC = [[BWMapAddressViewController alloc] init];
    objVC.dictLocation = dictLocation;
    objVC.strTitle = [[dictMerchant objectForKey:@"name"]?[[dictMerchant objectForKey:@"name"] uppercaseString]:@"" stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    [self.navigationController pushViewController:objVC animated:YES];
    objVC = nil;
}
- (void)rootMapClicked:(UIButton *)sender
{
    //Get the current title of the sender to identify the pin selected
    [self drowAPathToMerchant];
}

- (void)callClicked:(UIButton *)sender
{
    NSString *titleOfButton = [[[[[sender titleForState:UIControlStateNormal] stringByReplacingOccurrencesOfString:@"(" withString:@""] stringByReplacingOccurrencesOfString:@")" withString:@""] stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@", titleOfButton]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl])
    {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    }
    else
    {
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
        calert = nil;
    }
}
- (void)websiteClicked:(UIButton *)sender
{
    BW_MerchantPage_ViewController *objVC = [[BW_MerchantPage_ViewController alloc] init];
    objVC.strWebsite = [dictMerchant objectForKey:@"website"];
    objVC.strBusinessName = [dictMerchant objectForKey:@"name"];
    [self.navigationController pushViewController:objVC animated:YES];
    objVC = nil;

}
#pragma mark - Share
- (void)shareClicked:(UIButton *)sender
{
    if(sender.tag==100 || sender.tag==105)
    {
        if(viewShareOption.frame.origin.y==600)
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.29];
            [UIView setAnimationDelegate:nil];
            viewShareOption.frame = CGRectMake(0, IS_IPHONE_5?300:220, 320, 400);
            [UIView commitAnimations];
        }
        else
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.29];
            [UIView setAnimationDelegate:nil];
            viewShareOption.frame = CGRectMake(0, 600, 320, 400);
            [UIView commitAnimations];
        }
    }
    else
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.29];
        [UIView setAnimationDelegate:nil];
        viewShareOption.frame = CGRectMake(0, 600, 320, 400);
        [UIView commitAnimations];

        if(sender.tag==101)
        {
            [self sendEmail];
        }
        else if(sender.tag==102)
        {
            [self sendMessage];
        }
        else if(sender.tag==103)
        {
            [self facebookPost];
        }
        else if(sender.tag==104)
        {
            [self twitterPost];
        }
    }
//    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Share" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Facebook" otherButtonTitles:@"Twitter", @"Email", @"Message", nil];
//    [action showFromToolbar:self.navigationController.toolbar];
//    action = nil;
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [self facebookPost];
    }
    else if(buttonIndex == 1)
    {
        [self twitterPost];
    }
    else if(buttonIndex == 2)
    {
        [self sendEmail];
    }
    else if(buttonIndex == 3)
    {
        [self sendMessage];
    }
}
- (void)facebookPost
{
    NSString *strTitle = [[self.dictOffer objectForKey:@"offer_title"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    
    NSString *messageBody = [NSString stringWithFormat:@"Hey, Checkout this offer: %@ at %@", strTitle, lblHeaderTitle.text];
    
    SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [mySLComposerSheet setTitle:[NSString stringWithFormat:@"Buckworm : %@", strTitle]];
    [mySLComposerSheet setInitialText:messageBody];
    [mySLComposerSheet addImage:imageOffer];
    [mySLComposerSheet addURL:[NSURL URLWithString:[self.dictOffer objectForKey:@"offer_page"]]];
    
    [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result)
     {
         switch (result)
         {
             case SLComposeViewControllerResultCancelled:
                 NSLog(@"Post Canceled");
                 break;
             case SLComposeViewControllerResultDone:
                 NSLog(@"Post Sucessful");
                 break;
                 
             default:
                 break;
         }
     }];
    
    [self presentViewController:mySLComposerSheet animated:YES completion:nil];
}

-(void)twitterPost
{
    NSString *strTitle = [[self.dictOffer objectForKey:@"offer_title"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    
    NSString *messageBody = [NSString stringWithFormat:@"%@ at %@", strTitle, lblHeaderTitle.text];
    
    SLComposeViewController *twitterController=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [twitterController addImage:imageOffer];
    
    SLComposeViewControllerCompletionHandler __block completionHandler=^(SLComposeViewControllerResult result){
        
        [twitterController dismissViewControllerAnimated:YES completion:nil];
        
        switch(result){
            case SLComposeViewControllerResultCancelled:
            default:
            {
                NSLog(@"Cancelled.....");
            }
                break;
            case SLComposeViewControllerResultDone:
            {
                NSLog(@"Posted....");
            }
                break;
        }};
    
    //    NSURL *imageURL1 = [NSURL URLWithString:strLargeImageURL];
    
    [twitterController setTitle:[NSString stringWithFormat:@"Buckworm : %@", strTitle]];
    [twitterController setInitialText:messageBody];
    [twitterController addImage:imageOffer];
    [twitterController addURL:[NSURL URLWithString:[self.dictOffer objectForKey:@"offer_page"]]];
    [twitterController setCompletionHandler:completionHandler];
    [self presentViewController:twitterController animated:YES completion:nil];
}
- (void)sendEmail
{
    NSString *strTitle = [[self.dictOffer objectForKey:@"offer_title"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    NSString *strDescription = [self.dictOffer objectForKey:@"offer_description"];
    NSString *strExpiryBy = [NSString stringWithFormat:@"Redeem by :%@", [appDelegate getDateFromFormat:@"yyyy-MM-dd" toFormat:dateFormatToShow withDate:[self.dictOffer objectForKey:@"redemption_end_date"]]];
    
    MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
    mailer.mailComposeDelegate = self;
    [mailer setSubject:[NSString stringWithFormat:@"Buckworm : %@", strTitle]];
    
    NSString *strImageURL = [NSString stringWithFormat:@"%@%@", strImagePath, [self.dictOffer objectForKey:@"offer_image"]];
    
    strImageURL = [strImageURL stringByReplacingOccurrencesOfString:@"\\" withString:@"%5C"];   //Replace \ by %5C
    strImageURL = [strImageURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSString *imageString = [NSString stringWithFormat:@"<img  src='%@' width='180px' height='130px'/>", strImageURL];
    
    NSString *emailBody = [NSString stringWithFormat:@"<html><head>Hey, it's %@!</head><body><p>I thought you’d be interested in this deal:<br>%@<br></p><p>%@ at %@</p> <p>Available till: %@</p><a href=\"%@\">%@</a></body></html>", appDelegate.objUserLogedIn.strFirstname, imageString, strDescription, lblHeaderTitle.text, strExpiryBy, [self.dictOffer objectForKey:@"offer_page"], [self.dictOffer objectForKey:@"offer_page"]];
    //imageString
    [mailer setMessageBody:emailBody isHTML:YES];
    [self presentViewController:mailer animated:YES completion:nil];
    mailer = nil;
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    // Remove the mail view
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendMessage
{
    NSString *strTitle = [[self.dictOffer objectForKey:@"offer_title"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    
    NSString *messageBody = [NSString stringWithFormat:@"Hey, it's %@! I thought you'd be interested in this deal: %@ at %@\n%@", appDelegate.objUserLogedIn.strFirstname, strTitle, lblHeaderTitle.text, [self.dictOffer objectForKey:@"offer_page"]];
    
    if([MFMessageComposeViewController canSendText])
    {
        MFMessageComposeViewController *messageComposer = [[MFMessageComposeViewController alloc] init];
        messageComposer.body = messageBody;
        messageComposer.messageComposeDelegate = self;
        [self presentViewController: messageComposer animated:YES completion:nil];
        messageComposer = nil;
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result)
    {
        case MessageComposeResultCancelled:
            NSLog(@"Message cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MessageComposeResultSent:
            NSLog(@"Message send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MessageComposeResultFailed:
            NSLog(@"Message failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Message not sent.");
            break;
    }
    // Remove the mail view
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - UIActionSheet
// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    
}// before animation and showing view
- (void)didPresentActionSheet:(UIActionSheet *)actionSheet
{
    
}// after animation

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    
}// before animation and hiding view
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
}

#pragma mark - Parser Merchant Details
- (void)getMerchanetDetails
{
    [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Fetching merchant details..."];
    [objMerchantDetailBL getDetailsOfMerchant:[self.dictOffer objectForKey:@"merchant_id"]];
}

- (void)merchantDetailPaserFinished:(NSDictionary *)dictData
{
    if([[dictData objectForKey:@"statusDescription"] isEqualToString:@"Success"])
    {
        dictMerchant = [dictData objectForKey:@"merchant_details"];
        lblHeaderTitle.text = [[[dictMerchant objectForKey:@"business_name"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] uppercaseString];
        lblMerchantTitle.text = [[[dictMerchant objectForKey:@"business_name"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] uppercaseString];

        NSArray *arrTemp = [dictMerchant objectForKey:@"locations"];
        if([arrTemp count]>0)
        {
            NSDictionary *dictLoc = [arrTemp objectAtIndex:0];
            [btnRootMap setTitle:[NSString stringWithFormat:@"%@", [dictLoc objectForKey:@"location"]?[dictLoc objectForKey:@"location"]:@""] forState:UIControlStateNormal];
        }
        [btnCall setTitle:[NSString stringWithFormat:@"%@", [dictMerchant objectForKey:@"phone_no"]?[dictMerchant objectForKey:@"phone_no"]:@""] forState:UIControlStateNormal];
        
        [self getGeoOf:[btnRootMap titleForState:UIControlStateNormal]];
    }
    else
    {
        [DSBezelActivityView removeViewAnimated:YES];

//        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"An eror occured. Please try again." waitUntilDone:NO];
    }
}

#pragma mark - Google API call
- (void)getGeoOf:(NSString *)strAddress
{
    if(appDelegate.isNetAvailable)
    {
        @autoreleasepool
        {
            GeoCodeFromAddressParser *parser = [[GeoCodeFromAddressParser alloc] init];
            parser.strAddress = [strAddress stringByReplacingOccurrencesOfString:@" " withString:@"+"];
            parser.callBack = self;
            [parser startParsing];
            parser = nil;
        }
    }
    else
        [self showAlertNoInternetAvailableMainThread];
}

- (void)showAlertNoInternetAvailableMainThread
{
    [DSBezelActivityView removeViewAnimated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Internet not available!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    alert = nil;
}

- (void)GeoCodeFromAddressParserFinished:(NSDictionary *)dictGeoCode
{
    [DSBezelActivityView removeViewAnimated:YES];

    if([[dictGeoCode objectForKey:@"status"] isEqualToString:@"OK"])
    {
        NSArray *arrTemp = [dictGeoCode objectForKey:@"results"];
        if([arrTemp count]>0)
        {
            NSDictionary *dictGeo = [arrTemp objectAtIndex:0];
            NSDictionary *dictCode = [dictGeo objectForKey:@"geometry"];
            dictLocation = [dictCode objectForKey:@"location"];
            [self showAnnotationOnMap];
        }
    }
    else
        [DSBezelActivityView removeViewAnimated:YES];
}
- (void)errorInParseing:(NSError *)error
{
    [DSBezelActivityView removeViewAnimated:YES];
}

- (void)showAnnotationOnMap
{
    // run the loop to get all location
    // Fetch the Latitude, Longitude, Title, SubTitle
    float Lat = [[dictLocation objectForKey:@"lat"] floatValue];
    float Long = [[dictLocation objectForKey:@"lng"] floatValue];
    //    NSString *strTitle = [dictLocation objectForKey:@"Title"];
    //    NSString *strSubTitle = [dictLocation objectForKey:@"Subtitle"];
    
    // set MKCoordinateRegion center and span
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = Lat;
    region.center.longitude = Long;
    region.span.longitudeDelta = 0.2f;
    region.span.latitudeDelta = 0.2;
    [_mapView setRegion:region animated:YES];// Set Region to the map
    
    TechSunRiseMKAnnotation *ann = [[TechSunRiseMKAnnotation alloc] init];
    //    ann.title = strTitle;
    //    ann.subtitle = strSubTitle;
    ann.coordinate = region.center;
    [_mapView addAnnotation:ann];
}

- (void)drowAPathToMerchant
{
    NSString *Title = @"Merchant Name";
    CLLocationCoordinate2D destination = CLLocationCoordinate2DMake([[dictLocation objectForKey:@"lat"] floatValue], [[dictLocation objectForKey:@"lng"] floatValue]);
    
    //allocating the MKPlacemark of destination location
    MKPlacemark *placemark = [[MKPlacemark alloc]initWithCoordinate:destination addressDictionary:nil];
    // allocating the MKMapItem with MKPlacemark to open the Map
    MKMapItem * item = [[MKMapItem alloc]initWithPlacemark:placemark];
    item.name = Title;
    
    // Preaparing the launchOptions dictionary for predefined keyes MKLaunchOptionsDirectionsModeKey and MKLaunchOptionsMapTypeKey
    NSDictionary *launchOptions = @{
                                    
                                    MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking,
                                    
                                    MKLaunchOptionsMapTypeKey:@(MKMapTypeSatellite)
                                    };
    //This method will open the Map with the opttions given by launchOptions
    [item openInMapsWithLaunchOptions:launchOptions];
}

#pragma mark - Parser Link
- (void)linkThisOffer
{
    [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Choosing offer..."];
    [objLinkUnlinkBL linkOffer:[self.dictOffer objectForKey:@"campaign_uuid"]];
}
- (void)linkungParserFinished:(NSDictionary *)dictData
{
    NSLog(@"link Data = %@", dictData);
    [DSBezelActivityView removeViewAnimated:YES];
    
    if([[dictData objectForKey:@"statusDescription"] isEqualToString:@"Success"])
    {
        btnBuy.enabled = NO;
        [self performSelectorOnMainThread:@selector(showReadyToRedeem) withObject:nil waitUntilDone:NO];
    }
    else
    {
        btnBuy.enabled = YES;
        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"An eror occured. Please try again." waitUntilDone:NO];
    }
}

- (void)showReadyToRedeem
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"This offer is now Ready to Redeem. Do not open the offer until you are ready to redeem." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alert.tag = 1000;
    [alert show];
    alert = nil;
}
- (void)showSurveyBox
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"When was the last time you visited this business?" delegate:self cancelButtonTitle:@"I haven’t been there yet" otherButtonTitles:@"Within the past month", @"One to six months ago", @"Six months to one year ago", @"Longer than one year", nil];
    alert.tag = 2000;
    [alert show];
    alert = nil;
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1000)
    {
        [self showSurveyBox];
    }
    else if(alertView.tag == 2000)
    {
        if(buttonIndex==0)
        {
            [self setSelectedSurvey:@"I haven’t been there yet"];
            NSLog(@"I haven’t been there yet");
        }
        else if(buttonIndex==1)
        {
            [self setSelectedSurvey:@"Within the past month"];
            NSLog(@"Within the past month");
        }
        else if(buttonIndex==2)
        {
            [self setSelectedSurvey:@"One to six months ago"];
            NSLog(@"One to six months ago");
        }
        else if(buttonIndex==3)
        {
            [self setSelectedSurvey:@"Six months to one year ago"];
            NSLog(@"Six months to one year ago");
        }
        else if(buttonIndex==4)
        {
            [self setSelectedSurvey:@"Longer than one year"];
            NSLog(@"Longer than one year");
        }
    }
    else if(alertView.tag == 3000)
    {
        //        [self linkThisOffer];
    }
    else     if(alertView.tag == 2001 && buttonIndex==0)
    {
        if(webViewTC)
        {
            [webViewTC removeFromSuperview];
            webViewTC = nil;
        }
        //        self.view.backgroundColor = [UIColor whiteColor];
        webViewTC = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, 320, self.view.frame.size.height+40)];
        webViewTC.scrollView.bounces = NO;
        webViewTC.userInteractionEnabled = YES;
        webViewTC.clipsToBounds=YES;
        webViewTC.scrollView.showsVerticalScrollIndicator=NO;
        [webViewTC setBackgroundColor:[UIColor whiteColor]];
        [webViewTC setOpaque:NO];
        
        [appDelegate.window addSubview:webViewTC];
        
        NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"LN_TC" ofType:@"html"];
        
        NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
        [webViewTC loadHTMLString:htmlString baseURL:nil];
        
        UIButton *btnIAgree = [[UIButton alloc] initWithFrame:CGRectMake(2, self.view.frame.size.height, 157, 40)];
        [btnIAgree addTarget:self action:@selector(iAgreeClicked) forControlEvents:UIControlEventTouchUpInside];
        [btnIAgree setTitle:@"I AGREE" forState:UIControlStateNormal];
        btnIAgree.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue: 0.0 alpha:0.8];
        [webViewTC addSubview:btnIAgree];
        
        UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(161, self.view.frame.size.height, 157, 40)];
        [btnCancel addTarget:self action:@selector(cancelClicked) forControlEvents:UIControlEventTouchUpInside];
        [btnCancel setTitle:@"CANCEL" forState:UIControlStateNormal];
        btnCancel.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue: 0.0 alpha:0.8];
        [webViewTC addSubview:btnCancel];
        
    }

}

#pragma mark - Parser Survey Box
- (void)setSelectedSurvey:(NSString *)strText
{
    [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Submitting..."];
    [objSurveyBox_BL setSelectedSurvey:strText forOffer:[self.dictOffer objectForKey:@"campaign_uuid"]];
}
- (void)survetBoxParserFinished:(NSDictionary *)dictData
{
    [DSBezelActivityView removeViewAnimated:YES];
    if([[dictData objectForKey:@"statusDescription"] isEqualToString:@"Success"])
    {
        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Thanks!" waitUntilDone:NO];
    }
    else
    {
        //        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Coupon did not delete." waitUntilDone:NO];
    }
    
    NSLog(@"json = %@", dictData);
}

#pragma mark - ===Card Rebate===
#pragma mark - Parser

- (void)linkThisOfferCardRebate
{
    self.strAccountToken = appDelegate.objUserLogedIn.strSelectedCard;
    if (self.strAccountToken && [self.strAccountToken length]>0)
    {
        [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                          withLabel:@"Linking offer..."];
        [objLinkUnlinkCardRebateBL linkOffer:[dictOffer objectForKey:@"campaign_uuid"] andAccountToken:self.strAccountToken];
    }
    else if (appDelegate.objUserLogedIn.strConsumerToken && [appDelegate.objUserLogedIn.strConsumerToken length]>0)
    {
        BW_MyCards_ViewController *objMoreVC = [[BW_MyCards_ViewController alloc] init];
        objMoreVC.intTag = 100;
        //        objMoreVC.objMerchantDetails = self;
        [self presentViewController:objMoreVC animated:YES completion:nil];
        objMoreVC = nil;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"To start linking offers, you need to add a card to your account. Click here to add card now" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Not right now", nil];
        alert.tag = 2001;
        [alert show];
        alert = nil;
    }
}
- (void)unlinkThisOffer
{
    self.strAccountToken = appDelegate.objUserLogedIn.strSelectedCard;

    [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Unlinking offer..."];
    
    [objLinkUnlinkCardRebateBL unlinkOffer:self.strLinkOferID andAccountToken:self.strAccountToken];
}

- (void)LinkParserFinished:(NSDictionary *)dictData
{
    NSLog(@"link Data = %@", dictData);
    [DSBezelActivityView removeViewAnimated:YES];
    
    if([[dictData objectForKey:@"statusDescription"] isEqualToString:@"Success"])
    {
        btnBuy.enabled = NO;
        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Offer linked successfully." waitUntilDone:NO];
    }
    else
    {
        btnBuy.enabled = YES;
        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Offer did not link." waitUntilDone:NO];
    }
}

- (void)UnlinkParserFinished:(NSDictionary *)dictData
{
    NSLog(@"unlink Data = %@", dictData);
    [DSBezelActivityView removeViewAnimated:YES];
    if([[dictData objectForKey:@"statusDescription"] isEqualToString:@"Success"])
    {
        btnBuy.enabled = NO;
        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Offer unlinked successfully." waitUntilDone:NO];
    }
    else
    {
        btnBuy.enabled = YES;
        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Offer did not unlink." waitUntilDone:NO];
    }
}

#pragma mark - linkable registration
- (void)registerWithLinkable
{
    [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Connecting..."];
    [objLoginBL registerWithNetworks];
}
- (void)NetworkRegisterParserFinished:(NSDictionary *)dictData
{
    [DSBezelActivityView removeViewAnimated:YES];
    if([[dictData objectForKey:@"statusDescription"] isEqualToString:@"User successfully registered on networks."])
    {
        appDelegate.objUserLogedIn.strConsumerToken = [dictData objectForKey:@"consumerToken"];
        BW_AddCard_ViewController *objVC = [[BW_AddCard_ViewController alloc] init];
        [self.navigationController pushViewController:objVC animated:YES];
        objVC = nil;
    }
    else if([[dictData objectForKey:@"statusDescription"] isEqualToString:@"Resource already exists."])
    {
        appDelegate.objUserLogedIn.strConsumerToken = [dictData objectForKey:@"consumerToken"];
        BW_AddCard_ViewController *objVC = [[BW_AddCard_ViewController alloc] init];
        [self.navigationController pushViewController:objVC animated:YES];
        objVC = nil;
    }
    else
    {
        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:[dictData objectForKey:@"statusDescription"] waitUntilDone:NO];
    }
}
- (void)cancelClicked
{
    if(webViewTC)
    {
        [webViewTC removeFromSuperview];
        webViewTC = nil;
    }
}

- (void)iAgreeClicked
{
    if(webViewTC)
    {
        [webViewTC removeFromSuperview];
        webViewTC = nil;
    }
    [self registerWithLinkable];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}
#pragma mark -
#pragma mark TableView Delegate Datasource Methods
#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrCancel count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *viewFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    UILabel *lblVersion = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 20)];
    //    lblVersion.text = versionNumber;
    lblVersion.font = [UIFont systemFontOfSize:14.0];
    lblVersion.adjustsFontSizeToFitWidth = YES;
    lblVersion.textColor = [UIColor darkGrayColor];
    lblVersion.backgroundColor = [UIColor clearColor];
    [viewFooter addSubview:lblVersion];
    
    viewFooter.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1.0];
    return viewFooter;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    viewHeader.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1.0];
    
    UILabel *lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 44)];
    lblHeader.text = @"Please help us understand the reason for the cancellation request:";
    lblHeader.numberOfLines = 2;
    lblHeader.textAlignment = NSTextAlignmentCenter;
    lblHeader.font = [UIFont fontWithName:@"Arial" size:16];
    lblHeader.textColor = [UIColor grayColor];
    lblHeader.backgroundColor = [UIColor clearColor];
    [viewHeader addSubview:lblHeader];
    lblHeader = nil;
    
    return viewHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"jobsite";
    
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        @autoreleasepool {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.text = [arrCancel objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [viewCancelPopUp removeFromSuperview];
    strDescCancel = [arrCancel objectAtIndex:indexPath.row];
    [self refundOffer];
    

//    if(indexPath.row==3 && self.card)
//    {
//        BWCardInfoViewController *objCardInfo = [[BWCardInfoViewController alloc] init];
//        objCardInfo.card = self.card;
//        [self.navigationController pushViewController:objCardInfo animated:YES];
//        objCardInfo = nil;
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
