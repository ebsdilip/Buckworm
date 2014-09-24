//
//  BWMyCouponsViewController.m
//  Buckworm
//
//  Created by iLabours on 8/30/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BWMyCouponsViewController.h"
#import "BWMyCouponsTableViewCell.h"
#import "BWMyCouponsTableViewCell.h"
#import "BW_DigitalCouponDownloaded_ViewController.h"
#import "BW_Login_BO.h"
#import "BWAppDelegate.h"
#import "BWMerchentLocationViewController.h"

#import "BWOfferDetailViewController.h"

@interface BWMyCouponsViewController ()

@end

@implementation BWMyCouponsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        arrOffer = [[NSMutableArray alloc] init];
        objDC_BL = [[BW_DigitalAndPurchaseOffer_BL alloc] init];
        objDC_BL.callBack = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    lblMessage = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 100)];
    lblMessage.backgroundColor = [UIColor clearColor];
    lblMessage.textAlignment = NSTextAlignmentCenter;
    lblMessage.font = [UIFont boldSystemFontOfSize:16.0];
    lblMessage.textColor = [UIColor darkGrayColor];
    lblMessage.numberOfLines = 0;
    [self.view addSubview:lblMessage];

    [self screenDesigningForUpperSlider];
    [self screenDesigning];
}
- (void)viewDidAppear:(BOOL)animated
{
//    if([arrOffer count]==0)
        [self categoryClicked:btnTab1UI];
}

- (void)screenDesigning
{
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 22, 40, 40)];
    btnBack.backgroundColor = colorGreen;
    [btnBack setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon-arrow" ofType:@"png"]] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    btnBack = nil;

//    UIButton *btnGlob = [[UIButton alloc] initWithFrame:CGRectMake(295, 30, 25, 25)];
//    [btnGlob addTarget:self action:@selector(showMerchants) forControlEvents:UIControlEventTouchUpInside];
//    [btnGlob setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"globeT" ofType:@"png"]] forState:UIControlStateNormal];
//    btnGlob.backgroundColor = colorGreen;
//    [self.view addSubview:btnGlob];

    scrlViewContent = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, 320, IS_IPHONE_5?500:414)];
    scrlViewContent.scrollEnabled = NO;
    scrlViewContent.pagingEnabled = YES;
    //    scrlViewContent.delegate = self;
    scrlViewContent.contentSize = CGSizeMake(320*4, 414);
    //    scrlViewContent
    scrlViewContent.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrlViewContent];
    
    
    tblCat1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, IS_IPHONE_5?500:414) style:UITableViewStylePlain];
    tblCat1.tag = tagLinked;
    tblCat1.dataSource = self;
    tblCat1.delegate = self;
    tblCat1.separatorStyle = UITableViewCellSeparatorStyleNone;
    tblCat1.backgroundColor = colorTableBG;
    [scrlViewContent addSubview:tblCat1];
    
    tblCat2 = [[UITableView alloc] initWithFrame:CGRectMake(320, 0, 320, IS_IPHONE_5?500:414) style:UITableViewStylePlain];
    tblCat2.tag = tagRedeemed;
    tblCat2.dataSource = self;
    tblCat2.delegate = self;
    tblCat2.separatorStyle = UITableViewCellSeparatorStyleNone;
    tblCat2.backgroundColor = colorTableBG;
    [scrlViewContent addSubview:tblCat2];
    
    tblCat3 = [[UITableView alloc] initWithFrame:CGRectMake(640, 0, 320, IS_IPHONE_5?500:414) style:UITableViewStylePlain];
    tblCat3.tag = tagExpired;
    tblCat3.dataSource = self;
    tblCat3.delegate = self;
    tblCat3.separatorStyle = UITableViewCellSeparatorStyleNone;
    tblCat3.backgroundColor = colorTableBG;
    [scrlViewContent addSubview:tblCat3];
    
}

- (void)goBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)showMerchants
{
    BWMerchentLocationViewController *objMapVC = [[BWMerchentLocationViewController  alloc] init];
//    self.title = objMapVC.title;
    [self.navigationController pushViewController:objMapVC animated:YES];
    objMapVC = nil;
}

- (void)screenDesigningForUpperSlider
{
    float width = 160;
    float xRef = 0;
    float yRef = 20.0;
    float xSpace = 0.0;
    
    UIFont *fontUsed = [UIFont boldSystemFontOfSize:14.0];
    
    UIColor *colorButtonBG = [UIColor clearColor];
    UIColor *colorNormal = [UIColor colorWithRed:218.0/255 green:249.0/255 blue:181.0/255 alpha:1.0];
    UIColor *colorDisabled = [UIColor whiteColor];
    
    scrlViewCategory = [[UIScrollViewInView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    scrlViewCategory.scrlViewCategory.delegate = self;
    scrlViewCategory.autoresizesSubviews = NO;
    scrlViewCategory.backgroundColor = colorGreen;
    scrlViewCategory.scrlViewCategory.contentSize = CGSizeMake(480, 44);
    [self.view addSubview:scrlViewCategory];
    
    viewSlide = [[UIView alloc] initWithFrame:CGRectMake(110, 52, 100, 3)];
    viewSlide.frame = CGRectMake(130, 52, 60, 3);
    viewSlide.backgroundColor = [UIColor colorWithRed:218.0/255 green:249.0/255 blue:181.0/255 alpha:1.0];
    [self.view addSubview:viewSlide];
    
    btnTab1UI = [[UIButton alloc] initWithFrame:CGRectMake(xRef, yRef, width, 44)];
    btnTab1UI.tag = 1001;
    btnTab1UI.backgroundColor = colorButtonBG;
    btnTab1UI.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnTab1UI.titleLabel.font = fontUsed;
    btnTab1UI.titleLabel.textColor = [UIColor darkGrayColor];
    btnTab1UI.titleLabel.numberOfLines = 0;
    [scrlViewCategory.scrlViewCategory addSubview:btnTab1UI];
    [btnTab1UI setTitleColor:colorNormal forState:UIControlStateNormal];
    [btnTab1UI setTitleColor:colorDisabled forState:UIControlStateDisabled];
    [btnTab1UI setTitle:@"READY TO REDEEM" forState:UIControlStateNormal];
    [btnTab1UI addTarget:self action:@selector(categoryClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    xRef += width+xSpace;
    
    btnTab2UI = [[UIButton alloc] initWithFrame:CGRectMake(xRef, yRef, width, 44)];
    btnTab2UI.tag = 1002;
    btnTab2UI.backgroundColor = colorButtonBG;
    btnTab2UI.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnTab2UI.titleLabel.font = fontUsed;
    btnTab2UI.titleLabel.textColor = [UIColor darkGrayColor];
    btnTab2UI.titleLabel.numberOfLines = 0;
    [scrlViewCategory.scrlViewCategory addSubview:btnTab2UI];
    [btnTab2UI setTitleColor:colorNormal forState:UIControlStateNormal];
    [btnTab2UI setTitleColor:colorDisabled forState:UIControlStateDisabled];
    [btnTab2UI setTitle:@"REDEEMED" forState:UIControlStateNormal];
    [btnTab2UI addTarget:self action:@selector(categoryClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    xRef += width+xSpace;
    
    btnTab3UI = [[UIButton alloc] initWithFrame:CGRectMake(xRef, yRef, width, 44)];
    btnTab3UI.tag = 1003;
    btnTab3UI.backgroundColor = colorButtonBG;
    btnTab3UI.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnTab3UI.titleLabel.font = fontUsed;
    btnTab3UI.titleLabel.textColor = [UIColor darkGrayColor];
    btnTab3UI.titleLabel.numberOfLines = 0;
    [scrlViewCategory.scrlViewCategory addSubview:btnTab3UI];
    [btnTab3UI setTitleColor:colorNormal forState:UIControlStateNormal];
    [btnTab3UI setTitleColor:colorDisabled forState:UIControlStateDisabled];
    [btnTab3UI setTitle:@"EXPIRED" forState:UIControlStateNormal];
    [btnTab3UI addTarget:self action:@selector(categoryClicked:) forControlEvents:UIControlEventTouchUpInside];
        
}
- (void)categoryClicked:(UIButton *)sender
{
    btnTab1UI.enabled = YES;
    btnTab2UI.enabled = YES;
    btnTab3UI.enabled = YES;
    
    switch (sender.tag) {
        case 1001:
        {
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.29];
            [UIView setAnimationDelegate:nil];
            viewSlide.frame = CGRectMake(92, 52, 134, 3);
            [UIView commitAnimations];
            
            btnTab1UI.enabled = NO;
            [self getLinkedOffers];

            break;
        }
        case 1002:
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.29];
            [UIView setAnimationDelegate:nil];
            viewSlide.frame = CGRectMake(121, 52, 78, 3);
            [UIView commitAnimations];
            
            btnTab2UI.enabled = NO;
            [self getRedeemedOffers];

        }
            break;
        case 1003:
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.29];
            [UIView setAnimationDelegate:nil];
            viewSlide.frame = CGRectMake(130, 52, 60, 3);
            [UIView commitAnimations];
            
            btnTab3UI.enabled = NO;
            [self getExpiredOffers];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - Scroll delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([scrollView isEqual:scrlViewCategory.scrlViewCategory])
    {
        scrlViewContent.contentOffset = CGPointMake(2*scrlViewCategory.scrlViewCategory.contentOffset.x, scrlViewContent.contentOffset.y);
        
//        int intPage = 1001+scrlViewCategory.scrlViewCategory.contentOffset.x/160;
//        [self categoryClicked:(UIButton *)[self.view viewWithTag:intPage]];
    }
    
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2)
{
    
}

// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float off = scrlViewCategory.scrlViewCategory.contentOffset.x;
    int intTemp = off / 160;
    NSLog(@"intTemp=%i, intOffset=%i", intTemp, intOffset);
    if(intOffset != intTemp)
    {
        intOffset = intTemp;
        if(intOffset==0)
        {
            [self categoryClicked:btnTab1UI];
        }
        else if(intOffset==1)
        {
            [self categoryClicked:btnTab2UI];
        }
        else if(intOffset==2)
        {
            [self categoryClicked:btnTab3UI];
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
}

//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//{
//
//}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    return YES;
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    
}

#pragma mark - TableView Delegate Datasource Methods
#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==tagLinked)
        return [arrOffer count]+1;
    else
        return [arrOffer count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == tagLinked && indexPath.row==0)
        return 55;
    else
        return 210;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(tableView.tag == tagLinked && [arrOffer count]==0)
        return 60;
    return 20.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    viewHeader.backgroundColor = colorLightGrayForBG;
    viewHeader.backgroundColor = [UIColor clearColor];
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 20)];
    lblTitle.numberOfLines = 3;
    lblTitle.font = [UIFont systemFontOfSize:14.0];
    lblTitle.textColor = [UIColor darkGrayColor];
    lblTitle.backgroundColor = [UIColor clearColor];
//    if([arrOffer count]>1)
//        lblTitle.text = [NSString stringWithFormat:@"%i Offers %@", [arrOffer count], self.title];
//    else if([arrOffer count]==1)
//        lblTitle.text = [NSString stringWithFormat:@"%i Offer %@", [arrOffer count], self.title];
//    else
//    {
//        if(tableView.tag == tagLinked)
//        {
//            lblTitle.text = @"Sorry, you have not selected any offers yet. Move to Available tab and start choosing offers.";
//            viewHeader.frame = CGRectMake(0, 0, 320, 60);
//            lblTitle.frame = CGRectMake(10, 0, 300, 60);
//        }
//        else
//            lblTitle.text = [NSString stringWithFormat:@"No Offer %@", self.title];
//    }
    
    [viewHeader addSubview:lblTitle];
    
    return viewHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    viewHeader.backgroundColor = [UIColor clearColor];
    
    //    if(searchBarZip==nil)
    //        searchBarZip = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 384, 44)];
    //
    //    searchBarZip.placeholder = @"Search by zip...";
    //    searchBarZip.alpha = 0.5;
    //    searchBarZip.keyboardType = UIKeyboardTypeAlphabet;
    ////    searchBarZip.delegate = self;
    //    searchBarZip.showsCancelButton = YES;
    //    [viewHeader addSubview:searchBarZip];
    
    return viewHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictOffer;
    NSString *CellIdentifier;
    CellIdentifier = @"Search";
    if(tableView.tag==tagLinked && indexPath.row>0)
    {
        dictOffer = [arrOffer objectAtIndex:indexPath.row-1];
        CellIdentifier = [NSString stringWithFormat:@"Offer %i %@", tableView.tag, [dictOffer objectForKey:@"id"]];
    }
    else if(tableView.tag!=tagLinked)
    {
        dictOffer = [arrOffer objectAtIndex:indexPath.row];
        CellIdentifier = [NSString stringWithFormat:@"Offer %i %@", tableView.tag, [dictOffer objectForKey:@"id"]];
    }
    BWMyCouponsTableViewCell *cell = (BWMyCouponsTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        @autoreleasepool {
            cell = [[BWMyCouponsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
    }
    cell.strImagePath = strImagePath;
    if(tableView.tag==tagAvailable)
    {
        [cell setParameterAvailable:dictOffer];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(tableView.tag==tagLinked)
    {
        if(indexPath.row==0)
        {
            [cell hideAll];

            UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
            viewHeader.backgroundColor = [UIColor whiteColor];

            UIImageView *imgViewSearchBG = [[UIImageView alloc] init];
            imgViewSearchBG.frame = CGRectMake(0, 0, 320, 45);
            imgViewSearchBG.backgroundColor = [UIColor clearColor];
            imgViewSearchBG.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"searchBG" ofType:@"png"]];
            [viewHeader addSubview:imgViewSearchBG];
            
            UILabel *lblSearch = [[UILabel alloc] init];
            lblSearch.frame = CGRectMake(40, 0, 200, 44);
            lblSearch.textColor = [UIColor lightGrayColor];
            lblSearch.backgroundColor = [UIColor clearColor];
            lblSearch.font = [UIFont boldSystemFontOfSize:20];
            lblSearch.text = @"Search";
            [viewHeader addSubview:lblSearch];
                        
            UIButton *btnGlob = [[UIButton alloc] initWithFrame:CGRectMake(320-44, 0, 44, 45)];
            [btnGlob addTarget:self action:@selector(showMerchants) forControlEvents:UIControlEventTouchUpInside];
            [btnGlob setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"globe" ofType:@"png"]] forState:UIControlStateNormal];
            btnGlob.backgroundColor = [UIColor clearColor];
            [viewHeader addSubview:btnGlob];
            
            [cell addSubview:viewHeader];
        }
        else
        {
            [cell setParameterReadyToRedeem:dictOffer];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    if(tableView.tag==tagRedeemed)
    {
        [cell setParameterRedeemed:dictOffer];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if(tableView.tag==tagExpired)
    {
        [cell setParameterExpired:dictOffer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.backgroundColor = colorTableBG;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dictOffer;
    if(tableView.tag==tagLinked && indexPath.row>0)
    {
        dictOffer = [arrOffer objectAtIndex:indexPath.row-1];
    }
    else  if(tableView.tag!=tagLinked)
    {
        dictOffer = [arrOffer objectAtIndex:indexPath.row];
    }
    
    BWMyCouponsTableViewCell *cell = (BWMyCouponsTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSString *strOfferType = [dictOffer objectForKey:@"offer_master_type"]?[dictOffer objectForKey:@"offer_master_type"]:@"";

    if(tableView.tag==tagLinked)
    {
        if([[dictOffer objectForKey:@"is_locked"] integerValue]==0)
        {
            if([[strOfferType lowercaseString] isEqualToString:@"digital"])
            {
                if(customAlertBG==nil)
                    customAlertBG = [[UIView alloc] initWithFrame:self.view.frame];
                customAlertBG.backgroundColor = [UIColor colorWithHue:0.0 saturation:0.0 brightness:0.0 alpha:0.5];
                UIView *customAlert = [[UIView alloc] initWithFrame:CGRectMake(10, 120, 300, 290)];
                customAlert.layer.cornerRadius = 5.0;
                customAlert.backgroundColor = colorTableBG;
                [customAlertBG addSubview:customAlert];
                [self.view addSubview:customAlertBG];
                
                UILabel *lblT = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
                lblT.backgroundColor = [UIColor clearColor];
                lblT.textAlignment = NSTextAlignmentCenter;
                lblT.font = [UIFont systemFontOfSize:20.0];
                lblT.textColor = [UIColor blackColor];
                lblT.numberOfLines = 0;
                lblT.text = @"Warning";
                [customAlert addSubview:lblT];
                
                UILabel *lblM = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 280, 120)];
                lblM.backgroundColor = [UIColor clearColor];
                lblM.textAlignment = NSTextAlignmentCenter;
                lblM.font = [UIFont systemFontOfSize:15.0];
                lblM.textColor = [UIColor darkGrayColor];
                lblM.numberOfLines = 0;
                lblM.text = @"By clicking the Ready to Redeem Button you are confirming you are at the merchant and are ready to purchase. The offer will be available for 5 hours and will not be able to be presented after this time.";
                [customAlert addSubview:lblM];
                
                UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(10, 170, 280, 45)];
                [btnCancel addTarget:self action:@selector(alertCancel) forControlEvents:UIControlEventTouchUpInside];
                [btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btnCancel.titleLabel.font = [UIFont systemFontOfSize:16.0];
                [btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
                btnCancel.backgroundColor = [UIColor grayColor];
                [customAlert addSubview:btnCancel];
                
                UIButton *btnReadyToRedeem = [[UIButton alloc] initWithFrame:CGRectMake(10, 225, 280, 45)];
                [btnReadyToRedeem addTarget:self action:@selector(alertReady:) forControlEvents:UIControlEventTouchUpInside];
                btnReadyToRedeem.tag = 1000+indexPath.row;
                [btnReadyToRedeem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btnReadyToRedeem.titleLabel.font = [UIFont systemFontOfSize:16.0];
                [btnReadyToRedeem setTitle:@"Ready To Redeem" forState:UIControlStateNormal];
                btnReadyToRedeem.backgroundColor = colorGreen;
                [customAlert addSubview:btnReadyToRedeem];
            }
            else if([[strOfferType lowercaseString] isEqualToString:@"card rebate"])
            {
                BWOfferDetailViewController *objVC = [[BWOfferDetailViewController alloc] init];
                objVC.strImagePath = strImagePath;
                objVC.dictOffer = dictOffer;
                objVC.intType = DirectToCard;
                objVC.intStatus = tagAvailable;
                objVC.imageOffer = [cell getImageOfCell];
                [appDelegate.navController pushViewController:objVC animated:YES];
                objVC = nil;
            }
            else if([[strOfferType lowercaseString] isEqualToString:@"purchase"])
            {
                BWOfferDetailViewController *objVC = [[BWOfferDetailViewController alloc] init];
                objVC.strImagePath = strImagePath;
                objVC.dictOffer = dictOffer;
                objVC.intType = Purchase;
                objVC.intStatus = tagAvailable;
                objVC.imageOffer = [cell getImageOfCell];
                [appDelegate.navController pushViewController:objVC animated:YES];
                objVC = nil;
            }
        }
        else
        {
            if([[strOfferType lowercaseString] isEqualToString:@"digital"])
            {
                BW_DigitalCouponDownloaded_ViewController *objVC = [[BW_DigitalCouponDownloaded_ViewController alloc] init];
                objVC.strImagePath = strImagePath;
                objVC.dictCoupon = dictOffer;
                objVC.imgOffer = [cell getImageOfCell];
                objVC.intCategory = tableView.tag;
                [self.navigationController pushViewController:objVC animated:YES];
                objVC = nil;
            }
            else if([[strOfferType lowercaseString] isEqualToString:@"card rebate"])
            {
                BWOfferDetailViewController *objVC = [[BWOfferDetailViewController alloc] init];
                objVC.strImagePath = strImagePath;
                objVC.dictOffer = dictOffer;
                objVC.intType = Digital;
                objVC.intStatus = tagAvailable;
                objVC.imageOffer = [cell getImageOfCell];
                [appDelegate.navController pushViewController:objVC animated:YES];
                objVC = nil;
            }
        }
    }
    else if(tableView.tag==tagRedeemed)
    {
    }
    else if(tableView.tag==tagExpired)
    {
    }
}
- (void)alertReady:(UIButton *)sender
{
    [customAlertBG removeFromSuperview];
    NSDictionary *dictOffer = [arrOffer objectAtIndex:sender.tag-1001];
    
    BWMyCouponsTableViewCell *cell = (BWMyCouponsTableViewCell *)[tblCat1 cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag-1000 inSection:0]];
    
    BW_DigitalCouponDownloaded_ViewController *objVC = [[BW_DigitalCouponDownloaded_ViewController alloc] init];
    objVC.strImagePath = strImagePath;
    objVC.dictCoupon = dictOffer;
    objVC.imgOffer = [cell getImageOfCell];
    objVC.intCategory = tblCat1.tag;
    [self.navigationController pushViewController:objVC animated:YES];
    objVC = nil;

}
- (void)alertCancel
{
    [customAlertBG removeFromSuperview];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        NSDictionary *dictOffer = [arrOffer objectAtIndex:alertView.tag-1001];
        
        BWMyCouponsTableViewCell *cell = (BWMyCouponsTableViewCell *)[tblCat1 cellForRowAtIndexPath:[NSIndexPath indexPathForRow:alertView.tag-1000 inSection:0]];
        
        BW_DigitalCouponDownloaded_ViewController *objVC = [[BW_DigitalCouponDownloaded_ViewController alloc] init];
        objVC.strImagePath = strImagePath;
        objVC.dictCoupon = dictOffer;
        objVC.imgOffer = [cell getImageOfCell];
        objVC.intCategory = tblCat1.tag;
        [self.navigationController pushViewController:objVC animated:YES];
        objVC = nil;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([appDelegate.objUserLogedIn.strConsumerToken length]>0)
    {
        NSDictionary *dictOffer;
        if(tableView.tag==tagLinked && indexPath.row>0)
        {
            dictOffer = [arrOffer objectAtIndex:indexPath.row-1];
        }
        else  if(tableView.tag!=tagLinked)
        {
            dictOffer = [arrOffer objectAtIndex:indexPath.row];
        }

        [(BWMyCouponsTableViewCell *)cell showOfferImage:dictOffer];
    }
}

#pragma mark - Parser

- (void)getAvailableOffers
{
    [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Fetching offers..."];
    [objDC_BL getAvailableOffer:@"digital"];
}
- (void)availableOfferParserFinished:(NSDictionary *)dictOffers
{
    strImagePath = [dictOffers objectForKey:@"imagePath"];
    [DSBezelActivityView removeViewAnimated:YES];
    [arrOffer removeAllObjects];
    [arrOffer addObjectsFromArray:[dictOffers objectForKey:@"offers"]];
    
//    tblCat1.tag = tagAvailable;
//    [tblCat1 reloadData];
    
    if([arrOffer count]==0)
        lblMessage.text = @"Digital coupons not available.";
    else
        lblMessage.text = @"";
}

- (void)getLinkedOffers
{
    [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Fetching offers..."];
    [objDC_BL getLinkedOffer:@"digital"];
}

- (void)linkedOfferParserFinished:(NSDictionary *)dictOffers
{
    strImagePath = [dictOffers objectForKey:@"imagePath"];

    [DSBezelActivityView removeViewAnimated:YES];
    [arrOffer removeAllObjects];
    [arrOffer addObjectsFromArray:[dictOffers objectForKey:@"offers"]];
    
//    [self performSelectorOnMainThread:@selector(filter) withObject:nil waitUntilDone:NO];
    [self filter];
    if([arrOffer count]==0)
        lblMessage.text = @"Ready to redeem coupons not found.";
    else
        lblMessage.text = @"";
}

- (void)filter
{
    [DSBezelActivityView removeViewAnimated:YES];

    NSMutableArray *arrFiltered = [[NSMutableArray alloc] init];
    
    
    for (int i=0; i<[arrOffer count]; i++)
    {
        NSMutableDictionary *dictOfferCopy = [[NSMutableDictionary alloc] initWithDictionary:[arrOffer objectAtIndex:i]];
        
        NSArray *arrLink = [dictOfferCopy objectForKey:@"links"];
        NSArray *arrLock = [dictOfferCopy objectForKey:@"locks"];

        
        for (int j=0; j<[arrLink count]; j++)
        {
            NSDictionary *dictLink = [arrLink objectAtIndex:j];

//            if(j==0)
            {
                [dictOfferCopy addEntriesFromDictionary:dictLink];
                [dictOfferCopy setObject:@"0" forKey:@"is_locked"];

                if(arrLock && [arrLock count]>0)
                {
                    for (int k=0; k<[arrLock count]; k++)
                    {
                        NSDictionary *dictLock = [arrLock objectAtIndex:k];

                        if([[dictLink objectForKey:@"link_id"] isEqualToString:[dictLock objectForKey:@"link_id"]])
                        {
                            [dictOfferCopy addEntriesFromDictionary:dictLock];
                            [dictOfferCopy setObject:@"1" forKey:@"is_locked"];
                            [arrFiltered addObject:dictOfferCopy];
                            dictLock = nil;
                            dictOfferCopy = nil;
                            break;
                        }
                    }
                }
                if(dictOfferCopy)
                    [arrFiltered addObject:dictOfferCopy];
            }
            dictLink = nil;
        }
        dictOfferCopy = nil;
        arrLink = nil;
        arrLock = nil;
    }
    
    [arrOffer removeAllObjects];
    [arrOffer addObjectsFromArray:arrFiltered];
    tblCat1.dataSource = self;
    tblCat1.delegate = self;
    tblCat2.dataSource = nil;
    tblCat2.delegate = nil;
    tblCat3.dataSource = nil;
    tblCat3.delegate = nil;
    
    [tblCat1 reloadData];

}
- (void)getRedeemedOffers
{
    [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Fetching offers..."];
    [objDC_BL getRedeemedOffer:@"digital"];
}

- (void)redeemedOfferParserFinished:(NSDictionary *)dictOffers
{
    [DSBezelActivityView removeViewAnimated:YES];
    [arrOffer removeAllObjects];
    [arrOffer addObjectsFromArray:[dictOffers objectForKey:@"offers"]];
    
    tblCat1.dataSource = nil;
    tblCat1.delegate = nil;
    tblCat2.dataSource = self;
    tblCat2.delegate = self;
    tblCat3.dataSource = nil;
    tblCat3.delegate = nil;

    [tblCat2 reloadData];
    
    if([arrOffer count]==0)
        lblMessage.text = @"Redeemed coupons not found.";
    else
        lblMessage.text = @"";
}

- (void)getExpiredOffers
{
    [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Fetching offers..."];
    [objDC_BL getExpiredOffer:@"digital"];
}

- (void)expiredOfferParserFinished:(NSDictionary *)dictOffers
{
    [DSBezelActivityView removeViewAnimated:YES];
    [arrOffer removeAllObjects];
    [arrOffer addObjectsFromArray:[dictOffers objectForKey:@"offers"]];
    
    tblCat1.dataSource = nil;
    tblCat1.delegate = nil;
    tblCat2.dataSource = nil;
    tblCat2.delegate = nil;
    tblCat3.dataSource = self;
    tblCat3.delegate = self;

    [tblCat3 reloadData];
    
    if([arrOffer count]==0)
        lblMessage.text = @"Expited coupons not found.";
    else
        lblMessage.text = @"";
}

- (void)errorInParseing:(NSError *)error
{
    [DSBezelActivityView removeViewAnimated:YES];
    [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Internet connection appears to be offline." waitUntilDone:NO];
    
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
