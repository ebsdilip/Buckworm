//
//  BW_DigitalCouponDownloaded_ViewController.m
//  buckworm
//
//  Created by Developer on 8/11/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_DigitalCouponDownloaded_ViewController.h"
#import "BWOfferDetailViewController.h"

@interface BW_DigitalCouponDownloaded_ViewController ()

@end

@implementation BW_DigitalCouponDownloaded_ViewController

@synthesize imgOffer;
@synthesize dictCoupon;
@synthesize intCategory;
@synthesize strImagePath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        seconds = -1;
        isExiting = YES;
        objDigitalOpBL = [[BW_DigitalOperation_BL alloc] init];
        objDigitalOpBL.callBack = self;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isFromViewDidLoad = YES;
    [self showBackButton];
    [self screenDesign];
    
}
- (void)backButtonClicked
{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *dateCurrent = [dateFormater dateFromString:[dictCoupon objectForKey:@"current_time"]];
    NSDate *dateLinked = [dateFormater dateFromString:[dictCoupon objectForKey:@"locked_at"]];
    
    NSLog(@"\n Current Time = %@ \n Linked Time = %@", [dictCoupon objectForKey:@"current_time"], [dictCoupon objectForKey:@"locked_at"]);
    NSTimeInterval distanceBetweenDates = [dateCurrent timeIntervalSinceDate:dateLinked];
    seconds = 18000- distanceBetweenDates;

    if(customAlertBG==nil)
        customAlertBG = [[UIView alloc] initWithFrame:self.view.frame];
    customAlertBG.backgroundColor = [UIColor colorWithHue:0.0 saturation:0.0 brightness:0.0 alpha:0.5];
    UIView *customAlert = [[UIView alloc] initWithFrame:CGRectMake(10, 120, 300, 250)];
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
    
    UILabel *lblM = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 280, 80)];
    lblM.backgroundColor = [UIColor clearColor];
    lblM.textAlignment = NSTextAlignmentCenter;
    lblM.font = [UIFont systemFontOfSize:15.0];
    lblM.textColor = [UIColor darkGrayColor];
    lblM.numberOfLines = 0;
    lblM.text = [NSString stringWithFormat:@"Have you redeemed this offer? This offer will expire in less than %@", lblTimer?lblTimer.text:appDelegate.lblTimer.text];
    [customAlert addSubview:lblM];
    
    UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(10, 130, 280, 45)];
    [btnCancel addTarget:self action:@selector(alertNotYet:) forControlEvents:UIControlEventTouchUpInside];
    [btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnCancel.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [btnCancel setTitle:@"Not Yet" forState:UIControlStateNormal];
    btnCancel.backgroundColor = [UIColor grayColor];
    [customAlert addSubview:btnCancel];

    UIButton *btnReadyToRedeem = [[UIButton alloc] initWithFrame:CGRectMake(10, 185, 280, 45)];
    [btnReadyToRedeem addTarget:self action:@selector(alertHaveRedeem:) forControlEvents:UIControlEventTouchUpInside];
    btnReadyToRedeem.tag = 2000;
    [btnReadyToRedeem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnReadyToRedeem.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [btnReadyToRedeem setTitle:@"Yes, I’ve Redeemed It" forState:UIControlStateNormal];
    btnReadyToRedeem.backgroundColor = colorGreen;
    [customAlert addSubview:btnReadyToRedeem];

//    if(seconds>0)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"Have you redeemed this offer? This offer will expire in less than %@", lblTimer?lblTimer.text:appDelegate.lblTimer.text] delegate:self cancelButtonTitle:@"CANCEL" otherButtonTitles:@"YES, I’VE REDEEMED IT", @"NOT YET", nil];
//        alert.tag = 2000;
//        [alert show];
//        alert = nil;
//    }
//    else
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"Have you redeemed this offer? This offer will expire in less than %@", lblTimer?lblTimer.text:appDelegate.lblTimer.text] delegate:self cancelButtonTitle:@"CANCEL" otherButtonTitles:@"YES, I’VE REDEEMED IT", @"NOT YET", nil];
//        alert.tag = 2000;
//        [alert show];
//        alert = nil;
//    }
}

- (void)alertNotYet:(UIButton *)sender
{
    [viewFeedback removeFromSuperview];
    if(lblTimer==nil)
        [appDelegate stopCouponTimer];
    else
        [self stopCouponTimer];
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)alertHaveRedeem:(UIButton *)sender
{
    [viewFeedback removeFromSuperview];
    [self btnDONEClicked];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated
{
    isExiting = NO;
    if(isFromViewDidLoad==YES && [[dictCoupon objectForKey:@"is_locked"] integerValue]==0)
        [self markAsLocked];
    else if(isFromViewDidLoad==YES)
    {
        [self showLocalTimer];
    }
    isFromViewDidLoad = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
//    if(lblTimer==nil)
//        [appDelegate stopCouponTimer];
//    else
//        [self stopCouponTimer];
}

- (void)startCouponTimer
{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *dateCurrent = [dateFormater dateFromString:[dictCoupon objectForKey:@"current_time"]];
    NSDate *dateLinked = [dateFormater dateFromString:[dictCoupon objectForKey:@"locked_at"]];

    NSLog(@"\n Current Time = %@ \n Linked Time = %@", [dictCoupon objectForKey:@"current_time"], [dictCoupon objectForKey:@"locked_at"]);
    NSTimeInterval distanceBetweenDates = [dateCurrent timeIntervalSinceDate:dateLinked];
    
    seconds = 18000- distanceBetweenDates;
    if(seconds<0)
    {
        UILabel *lblExpired = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
        lblExpired.userInteractionEnabled = YES;
        lblExpired.text = @"Expired";
        lblExpired.textAlignment = NSTextAlignmentCenter;
        lblExpired.font = [UIFont boldSystemFontOfSize:70];
        lblExpired.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3];
        lblExpired.textColor = [UIColor whiteColor];
        [self.view addSubview:lblExpired];
    }
    else
    {
        timerCoupon = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChanged) userInfo:nil repeats:YES];
    }
}
- (void)stopCouponTimer
{
    if(lblTimer)
    {
        [lblTimer removeFromSuperview];
        lblTimer = nil;
    }
    if(timerCoupon && [timerCoupon isValid])
    {
        [timerCoupon invalidate];
        timerCoupon = nil;
    }
}
- (void)timeChanged
{
    --seconds;
    lblTimer.text = [NSString stringWithFormat:@"%02i:%02i:%02i", seconds/3600, (seconds%3600)/60, seconds%60];
}

- (void)showLocalTimer
{
    appDelegate.lblTimer = nil;
    UIView *viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 34)];
    viewBG.backgroundColor = colorOfferTitleBG;
    [self.view addSubview:viewBG];
    viewBG = nil;
    
    UIImageView *imgViewUnlock = [[UIImageView alloc] initWithFrame:CGRectMake(20, 64+7, 20, 20)];
    imgViewUnlock.backgroundColor = [UIColor clearColor];
    imgViewUnlock.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lock" ofType:@"png"]];
    [self.view addSubview:imgViewUnlock];
    imgViewUnlock = nil;
    
    UIImageView *imgViewtimer = [[UIImageView alloc] initWithFrame:CGRectMake(210, 64+7, 20, 20)];
    imgViewtimer.backgroundColor = [UIColor clearColor];
    imgViewtimer.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"time" ofType:@"png"]];
    [self.view addSubview:imgViewtimer];
    imgViewtimer = nil;
    
    if(lblTimer==nil)
    {
        [self startCouponTimer];
        lblTimer = [[UILabel alloc] initWithFrame:CGRectMake(240, 64+7, 60, 20)];
        lblTimer.font = [UIFont systemFontOfSize:14.0];
        lblTimer.textColor = [UIColor grayColor];
        lblTimer.backgroundColor = [UIColor clearColor];
    }
    [self.view addSubview:lblTimer];
}

- (void)showAppDelegateTimer
{
    lblTimer = nil;
    UIView *viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 34)];
    viewBG.backgroundColor = colorOfferTitleBG;
    [self.view addSubview:viewBG];
    viewBG = nil;
    
    UIImageView *imgViewUnlock = [[UIImageView alloc] initWithFrame:CGRectMake(20, 64+7, 20, 20)];
    imgViewUnlock.backgroundColor = [UIColor clearColor];
    imgViewUnlock.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lock" ofType:@"png"]];
    [self.view addSubview:imgViewUnlock];
    imgViewUnlock = nil;
    
    UIImageView *imgViewtimer = [[UIImageView alloc] initWithFrame:CGRectMake(210, 64+7, 20, 20)];
    imgViewtimer.backgroundColor = [UIColor clearColor];
    imgViewtimer.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"time" ofType:@"png"]];
    [self.view addSubview:imgViewtimer];
    imgViewtimer = nil;
    
    if(appDelegate.lblTimer==nil)
    {
        [appDelegate startCouponTimer];
        appDelegate.lblTimer = [[UILabel alloc] initWithFrame:CGRectMake(240, 64+7, 60, 20)];
        appDelegate.lblTimer.font = [UIFont systemFontOfSize:14.0];
        appDelegate.lblTimer.textColor = [UIColor grayColor];
        appDelegate.lblTimer.backgroundColor = [UIColor clearColor];
    }
    [self.view addSubview:appDelegate.lblTimer];
}


- (void)screenDesign
{
    self.view.backgroundColor = colorTableBG;
    float yRef = 10.0;
    float ySpace = 2.0;
    
    UIImageView *imgViewCouponBordder = [[UIImageView alloc] init];
    imgViewCouponBordder.frame = CGRectMake(10, 64+35, 300, self.view.frame.size.height-190);
    imgViewCouponBordder.backgroundColor = [UIColor whiteColor];
//    imgViewCouponBordder.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"coupon_bg2" ofType:@"png"]];
    [self.view addSubview:imgViewCouponBordder];
    imgViewCouponBordder = nil;
    
    scrlView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64+40, 320, self.view.frame.size.height-200)];
    scrlView.layer.borderColor = [UIColor grayColor].CGColor;    
    scrlView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrlView];
    
    lblBarTitle.text = [[[dictCoupon objectForKey:@"merchant"] objectForKey:@"name"] uppercaseString];
    UILabel *lblProvider = [[UILabel alloc] initWithFrame:CGRectMake(20, yRef, 280, 20)];
    lblProvider.text = [[[dictCoupon objectForKey:@"merchant"] objectForKey:@"name"] uppercaseString];
    lblProvider.font = [UIFont boldSystemFontOfSize:14.0];
    lblProvider.adjustsFontSizeToFitWidth = YES;
    lblProvider.textAlignment = NSTextAlignmentCenter;
    lblProvider.textColor = [UIColor grayColor];
    lblProvider.backgroundColor = [UIColor clearColor];
    [scrlView addSubview:lblProvider];
    
    yRef += ySpace+lblProvider.frame.size.height;

    UIImageView *imgViewOffer = [[UIImageView alloc] initWithFrame:CGRectMake(103, yRef, 114, 100)];
    imgViewOffer.backgroundColor = [UIColor clearColor];
    imgViewOffer.layer.borderWidth = 1.0;
    imgViewOffer.layer.borderColor = [UIColor lightGrayColor].CGColor;
    imgViewOffer.image = imgOffer;
    [scrlView addSubview:imgViewOffer];
    
    yRef += ySpace+imgViewOffer.frame.size.height;
    imgViewOffer = nil;
    
    UILabel *lblCouponCode = [[UILabel alloc] initWithFrame:CGRectMake(20, yRef, 280, 20)];
    lblCouponCode.font = [UIFont boldSystemFontOfSize:14.0];
    lblCouponCode.textAlignment = NSTextAlignmentCenter;
    lblCouponCode.adjustsFontSizeToFitWidth = YES;
    lblCouponCode.text = [[NSString stringWithFormat:@"Coupon Code: %@", [dictCoupon objectForKey:@"coupon_code"]] uppercaseString];
    lblCouponCode.textColor = [UIColor grayColor];
    lblCouponCode.backgroundColor = [UIColor clearColor];
    [scrlView addSubview:lblCouponCode];
    
    yRef += ySpace+lblCouponCode.frame.size.height;

    UILabel *lblOffer = [[UILabel alloc] initWithFrame:CGRectMake(20, yRef, 280, 40)];
    lblOffer.font = [UIFont systemFontOfSize:14.0];
    lblOffer.numberOfLines = 2;
    lblOffer.textAlignment = NSTextAlignmentCenter;
    lblOffer.text = [NSString stringWithFormat:@"Offer : %@", [[dictCoupon objectForKey:@"offer_title"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]];
    lblOffer.textColor = [UIColor grayColor];
    lblOffer.backgroundColor = [UIColor clearColor];
    [scrlView addSubview:lblOffer];
    
    
    yRef += ySpace+lblOffer.frame.size.height;
    
    CGSize size = [[self.dictCoupon objectForKey:@"offer_term_and_condition"] sizeWithFont:[UIFont fontWithName:@"helvetica" size:12.0] constrainedToSize:CGSizeMake(228, 2000) lineBreakMode:NSLineBreakByWordWrapping];

//    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(20, yRef, 280, IS_IPHONE_5?140:80)];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(20, yRef, 280, size.height+100)];
    webView.scrollView.scrollEnabled = NO;
    //        webView.delegate = self;
    [scrlView addSubview:webView];
    webView.backgroundColor = [UIColor clearColor];
    NSString *myDescriptionHTML = [NSString stringWithFormat:@"<html> \n"
                                   "<head> \n"
                                   "<style type=\"text/css\"> \n"
                                   "body {font-family: \"%@\"; font-size: %@; color: #888888;}\n"
                                   "</style> \n"
                                   "</head> \n"
                                   "<body>Terms & Conditions <br>%@</body> \n"
                                   "</html>", @"helvetica", [NSNumber numberWithInt:12], [[self.dictCoupon objectForKey:@"offer_term_and_condition"] stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"]];
    [webView setOpaque:NO];
    
    //        NSString *embedHTML = [NSString stringWithFormat:@"<html><head></head><body>%@</body></html>", [self.dictCoupon objectForKey:@"description"]];
    [webView loadHTMLString: myDescriptionHTML baseURL: nil];
    
    //        webView.frame = CGRectMake(20, yRef, 280, webView.scrollView.contentSize.height);
    yRef += webView.scrollView.contentSize.height;
    webView = nil;

    scrlView.contentSize = CGSizeMake(scrlView.contentSize.width, yRef);
    
    UIButton *btnDONE = [[UIButton alloc] initWithFrame:CGRectMake(15, IS_IPHONE_5?104+375:104+295, 290, 30)];
    [btnDONE addTarget:self action:@selector(btnDONEClicked) forControlEvents:UIControlEventTouchUpInside];
    btnDONE.titleLabel.font = [UIFont systemFontOfSize:16.0];
    btnDONE.backgroundColor = colorLightGrayForBG;
    btnDONE.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btnDONE.layer.borderWidth = 1.0;
    [btnDONE setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnDONE setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [btnDONE setTitle:@"MARK AS REDEEMED" forState:UIControlStateNormal];
    [btnDONE setTitle:@"TRANSACTION COMPLETE" forState:UIControlStateNormal];
    [self.view addSubview:btnDONE];
    
    UIButton *btnShare = [[UIButton alloc] initWithFrame:CGRectMake(15, IS_IPHONE_5?104+455:104+375, 290, 30)];
    [btnShare addTarget:self action:@selector(btnShareClicked) forControlEvents:UIControlEventTouchUpInside];
    btnShare.backgroundColor = [UIColor clearColor];
    btnShare.titleLabel.font = [UIFont systemFontOfSize:16.0];
    btnShare.backgroundColor = colorLightGrayForBG;
    btnShare.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btnShare.layer.borderWidth = 1.0;
    [btnShare setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnShare setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [btnShare setTitle:@"SHARE WITH FRIENDS" forState:UIControlStateNormal];
    //    [self.view addSubview:btnShare];
    btnShare = nil;
    
    UIButton *btnMoreDetails = [[UIButton alloc] initWithFrame:CGRectMake(15, IS_IPHONE_5?104+415:104+335, 290, 30)];
    [btnMoreDetails addTarget:self action:@selector(moreDetailClicked) forControlEvents:UIControlEventTouchUpInside];
    btnMoreDetails.backgroundColor = [UIColor clearColor];
    btnMoreDetails.titleLabel.font = [UIFont systemFontOfSize:16.0];
    btnMoreDetails.backgroundColor = colorLightGrayForBG;
    btnMoreDetails.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btnMoreDetails.layer.borderWidth = 1.0;
    [btnMoreDetails setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnMoreDetails setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [btnMoreDetails setTitle:@"VIEW MORE DETAILS" forState:UIControlStateNormal];
    [self.view addSubview:btnMoreDetails];
    btnMoreDetails = nil;

    lblProvider = nil;
    lblOffer = nil;
    lblCouponCode = nil;
    btnDONE = nil;
    
}

- (void)btnShareClicked
{
    [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Under developement." waitUntilDone:NO];
}
- (void)moreDetailClicked
{
    isExiting = NO;

    BWOfferDetailViewController *objVC = [[BWOfferDetailViewController alloc] init];
    objVC.strImagePath = strImagePath;
    objVC.dictOffer = dictCoupon;
    objVC.intType = Digital;
    objVC.intStatus = tagLinked;
    objVC.imageOffer = imgOffer;
    [appDelegate.navController pushViewController:objVC animated:YES];
    objVC = nil;

}
- (void)btnDONEClicked
{
    // Show a confirmation message to the user.
    appDelegate.lblTimer = nil;
    [self markAsRedeemed];
}

#pragma mark - Parser make Locked
- (void)markAsLocked
{
    [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Loading..."];
    [objDigitalOpBL markAsLockedOffer:[self.dictCoupon objectForKey:@"campaign_uuid"] andLinkID:[self.dictCoupon objectForKey:@"link_id"]];
}

- (void)markingAsLockedParserFinished:(NSDictionary *)dictData
{
    [DSBezelActivityView removeViewAnimated:YES];
    if([[dictData objectForKey:@"statusDescription"] isEqualToString:@"Success"])
    {
        [self showAppDelegateTimer];
//        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Coupon reddemed successfully." waitUntilDone:NO];
    }
    else
    {
//        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Coupon did not reddemed." waitUntilDone:NO];
    }
}

#pragma mark - Redeem
- (void)markAsRedeemed
{
    [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Redeeming offer..."];
    [objDigitalOpBL markAsRedeemedOffer:[self.dictCoupon objectForKey:@"campaign_uuid"] andLinkID:[self.dictCoupon objectForKey:@"link_id"]];
}

- (void)markingAsRedeemedParserFinished:(NSDictionary *)dictData
{
    NSLog(@"unlink Data = %@", dictData);
    [DSBezelActivityView removeViewAnimated:YES];
    if([[dictData objectForKey:@"statusDescription"] isEqualToString:@"Success"])
    {
        [self performSelectorOnMainThread:@selector(showOfferRedeemed) withObject:nil waitUntilDone:NO];
    }
    else
    {
        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Offer did not redeemed." waitUntilDone:NO];
    }
}
- (void)showOfferRedeemed
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Offer redeemed successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alert.tag = 1000;
    [alert show];
    alert = nil;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1000)
    {
        [self showFeedbackView];
        if(lblTimer==nil)
            [appDelegate stopCouponTimer];
        else
            [self stopCouponTimer];

    }
    else if(alertView.tag == 2000)
    {
        if(buttonIndex==1)
        {
            [self btnDONEClicked];
        }
        else if(buttonIndex==2)
        {
            if(lblTimer==nil)
                [appDelegate stopCouponTimer];
            else
                [self stopCouponTimer];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
- (void)errorInParseing:(NSError *)error
{
    [DSBezelActivityView removeViewAnimated:YES];
    [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Internet connection appears to be offline." waitUntilDone:NO];
}

#pragma mark -
- (void)showFeedbackView
{
    if(viewFeedback==nil)
    {
        viewFeedback = nil;
    }
    viewFeedback = [[BWDigitalCouponFeedbackView alloc] init];
    viewFeedback.frame = CGRectMake(0, 0, 320, 600);
    viewFeedback.callBack = self;
    viewFeedback.strMerchantID = [self.dictCoupon objectForKey:@"merchant_id"];// Merchant ID bhejna hai
    viewFeedback.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    [self.view addSubview:viewFeedback];
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
