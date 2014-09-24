//
//  BWPurchasedCouponViewController.m
//  Buckworm
//
//  Created by iLabours on 9/19/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BWPurchasedCouponViewController.h"
#define DegreesToRadians(x) ((x) * M_PI / 180.0)  

@interface BWPurchasedCouponViewController ()

@end

@implementation BWPurchasedCouponViewController

@synthesize dictOffer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        objDigitalOpBL = [[BW_DigitalOperation_BL alloc] init];
        objDigitalOpBL.callBack = self;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = colorTableBG;
    [self showBackButton];
    lblBarTitle.text = @"Redeem";
    
    [self screenDesigning];
}

- (void)screenDesigning
{
    lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, 320, 80)];
    lblTitle.backgroundColor = colorTableBG;
    lblTitle.textColor = colorGreen;
    lblTitle.font = [UIFont boldSystemFontOfSize:30.0];
    lblTitle.text = @"BUCKWORM";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lblTitle];

    viewDetailBG = [[UIView alloc] initWithFrame:CGRectMake(10, 144, 300, 120)];
    viewDetailBG.backgroundColor = [UIColor whiteColor];
    viewDetailBG.layer.borderWidth = 1.0;
    viewDetailBG.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    imgViewRedeemed = [[UIImageView alloc] initWithFrame:CGRectMake(71, 50, 157, 82)];
    imgViewRedeemed.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"redeemedTag1" ofType:@"png"]];
    imgViewRedeemed.hidden = YES;
    [viewDetailBG addSubview:imgViewRedeemed];
    
    lblRedeemedOn = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 137, 20)];
    lblRedeemedOn.backgroundColor = [UIColor clearColor];
    lblRedeemedOn.textColor = [UIColor colorWithRed:180.0/255 green:67.0/255 blue:69.0/255 alpha:1.0];
    lblRedeemedOn.transform = CGAffineTransformMakeRotation(DegreesToRadians(-5));
    lblRedeemedOn.font = [UIFont systemFontOfSize:12.0];
    [imgViewRedeemed addSubview:lblRedeemedOn];

    lblOfferTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 280, 20)];
    lblOfferTitle.backgroundColor = [UIColor clearColor];
    lblOfferTitle.textColor = colorGreen;
    lblOfferTitle.text = [dictOffer objectForKey:@"offer_title"];
    lblOfferTitle.font = [UIFont systemFontOfSize:15.0];
    [viewDetailBG addSubview:lblOfferTitle];

    lblMerchant = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 280, 20)];
    lblMerchant.backgroundColor = [UIColor clearColor];
    lblMerchant.textColor = [UIColor grayColor];
    lblMerchant.text = [[[dictOffer objectForKey:@"merchant"] objectForKey:@"name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    lblMerchant.font = [UIFont systemFontOfSize:15.0];
    [viewDetailBG addSubview:lblMerchant];

    btnMarkRedeem = [[UIButton alloc] initWithFrame:CGRectMake(10, 274, 300, 40)];
    [btnMarkRedeem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnMarkRedeem.titleLabel.font = [UIFont systemFontOfSize:24];
    btnMarkRedeem.layer.cornerRadius = 5.0;
    btnMarkRedeem.clipsToBounds = YES;
    btnMarkRedeem.layer.borderWidth = 0.5;
    btnMarkRedeem.layer.borderColor = colorTableBG.CGColor;
    [btnMarkRedeem setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"black-bg" ofType:@"png"]] forState:UIControlStateNormal];
    [btnMarkRedeem setTitle:@"Mark as Redeemed" forState:UIControlStateNormal];
    [btnMarkRedeem addTarget:self action:@selector(markAsReddem) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnMarkRedeem];
    
    lblCoupon = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 280, 20)];
    lblCoupon.backgroundColor = [UIColor clearColor];
    lblCoupon.textColor = [UIColor grayColor];
    lblCoupon.text = [@"Coupon Code" uppercaseString];
    lblCoupon.font = [UIFont boldSystemFontOfSize:15.0];
    [viewDetailBG addSubview:lblCoupon];

    NSArray *arrTemp = [dictOffer objectForKey:@"links"];
    NSString *strCouponCode = [self.dictOffer objectForKey:@"coupon_code"];

    if(strCouponCode==nil)
    {
        for (int i=0; i<[arrTemp count]; i++) {
            NSDictionary *dictTemp = [arrTemp objectAtIndex:i];
            if([[dictTemp objectForKey:@"link_id"] isEqualToString:[dictOffer objectForKey:@"link_id"]])
            {
                strCouponCode = [dictTemp objectForKey:@"coupon_code"];
                break;
            }
        }
    }
    
    lblCouponCode = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 280, 20)];
    lblCouponCode.backgroundColor = [UIColor clearColor];
    lblCouponCode.textColor = [UIColor grayColor];
    lblCouponCode.text = [strCouponCode uppercaseString];
    lblCouponCode.font = [UIFont systemFontOfSize:15.0];
    [viewDetailBG addSubview:lblCouponCode];

    lblCustomer = [[UILabel alloc] initWithFrame:CGRectMake(10, 330, 300, 20)];
    lblCustomer.backgroundColor = [UIColor clearColor];
    lblCustomer.textColor = [UIColor grayColor];
    lblCustomer.text = [@"Customer" uppercaseString];
    lblCustomer.font = [UIFont boldSystemFontOfSize:18.0];
    [self.view addSubview:lblCustomer];

    lblCustomerName = [[UILabel alloc] initWithFrame:CGRectMake(10, 350, 300, 20)];
    lblCustomerName.backgroundColor = [UIColor clearColor];
    lblCustomerName.textColor = [UIColor grayColor];
    lblCustomerName.text = appDelegate.objUserLogedIn.strFirstname;
    lblCustomerName.font = [UIFont systemFontOfSize:18.0];
    [self.view addSubview:lblCustomerName];

    [self.view addSubview:viewDetailBG];

}

- (void)markAsReddem
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Offer can only be marked as redeemed once." message:@"Are you sure you've followed all the instructions for using this Offer?. You can see them on the previous screen." delegate:self cancelButtonTitle:@"Go Back" otherButtonTitles:@"I'm Sure", nil];
    alert.tag = 1000;
    [alert show];
    alert = nil;
}
#pragma mark - Redeem
- (void)markAsRedeemed
{
    [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Redeeming offer..."];
    [objDigitalOpBL markAsRedeemedOffer:[self.dictOffer objectForKey:@"campaign_uuid"] andLinkID:[self.dictOffer objectForKey:@"link_id"]];
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
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd-MMM-yyyy hh:mm a"];
    
    lblRedeemedOn.text = [format stringFromDate:[NSDate date]];

    imgViewRedeemed.hidden = NO;
    viewDetailBG.frame = CGRectMake(10, 144, 300, 180);
    lblCoupon.frame = CGRectMake(10, 130, 280, 20);
    lblCouponCode.frame = CGRectMake(10, 150, 280, 20);
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1000)
    {
        if(buttonIndex==0)
            [self.navigationController popViewControllerAnimated:YES];
        else
            [self markAsRedeemed];
    }
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
