//
//  BWPurchaseOrderrDetailsViewController.m
//  Buckworm
//
//  Created by iLabours on 9/12/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BWPurchaseOrderrDetailsViewController.h"
#import "PaymentViewController.h"
#import "BWCardInfoViewController.h"
#import "BWPurchasedCouponViewController.h"

@import PassKit;

#define STRIPE_TEST_PUBLIC_KEY @"pk_test_4RztR5xhbZIUFreNg3NmXgHP"
#define STRIPE_TEST_POST_URL @"https://api.stripe.com/v1/charges"

@interface BWPurchaseOrderrDetailsViewController ()

@end

@implementation BWPurchaseOrderrDetailsViewController

@synthesize dictOffer;
@synthesize tblOrder;

@synthesize btnBuy;
@synthesize card;
@synthesize strPrice;
@synthesize strPurchasePrice;
@synthesize strCampaign_uuid;
@synthesize strTitle;

@synthesize imageOffer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        objStripeBL = [[BW_Stripe_BL alloc] init];
        objStripeBL.strAction = @"pay";
        objStripeBL.callBack = self;

        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSString *strNumber = [userDefault objectForKey:@"number"];
        NSString *strExpMonth = [userDefault objectForKey:@"expMonth"];
        NSString *strExpYear = [userDefault objectForKey:@"expYear"];
        NSString *strCVC = [userDefault objectForKey:@"cvc"];

        if(strNumber && [strNumber length]>5)
        {
            card = [[STPCard alloc] init];
            card.number = strNumber;
            card.expMonth = [strExpMonth integerValue];
            card.expYear = [strExpYear integerValue];
            card.cvc = strCVC;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackButton];
    [self screenDesigning];
}

- (void)screenDesigning
{
//    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
//    viewHeader.backgroundColor = colorGreen;
//    [self.view addSubview:viewHeader];
//    
//    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 22, 40, 40)];
//    btnBack.backgroundColor = [UIColor clearColor];
//    [btnBack setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon-arrow" ofType:@"png"]] forState:UIControlStateNormal];
//    [btnBack addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btnBack];
//    btnBack = nil;
//    
    UILabel *lblHeaderTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 22, 200, 40)];
    lblHeaderTitle.textAlignment = NSTextAlignmentCenter;
    lblHeaderTitle.text = @"Confirm";
    lblHeaderTitle.font = [UIFont boldSystemFontOfSize:16.0];
    lblHeaderTitle.numberOfLines = 2;
    lblHeaderTitle.textColor = [UIColor whiteColor];
    lblHeaderTitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblHeaderTitle];
    
    float yRef = 64.0;
    imgViewOffer = [[UIImageView alloc] init];
    imgViewOffer.image = imageOffer;
    imgViewOffer.frame = CGRectMake(0, yRef, 320, 180);
    imgViewOffer.backgroundColor = [UIColor clearColor];
    imgViewOffer.layer.borderWidth = 1.0;
    imgViewOffer.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:imgViewOffer];
    
    imgViewOfferShadow = [[UIImageView alloc] init];
    imgViewOfferShadow.frame = CGRectMake(0, yRef, 320, 180);
    imgViewOfferShadow.backgroundColor = [UIColor clearColor];
    imgViewOfferShadow.layer.borderWidth = 1.0;
    imgViewOfferShadow.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"black" ofType:@"png"]];
    imgViewOfferShadow.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:imgViewOfferShadow];
    
    yRef += imgViewOfferShadow.frame.size.height;
    
    CGSize size = [strTitle sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, yRef+5, 300, size.height)];
    lblTitle.frame = CGRectMake(20, 200, 280, 40);
    lblTitle.text = strTitle;
    lblTitle.font = [UIFont boldSystemFontOfSize:16.0];
    lblTitle.numberOfLines = 2;
    lblTitle.textColor = [UIColor whiteColor];
    lblTitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblTitle];

    
    tblOrder = [[UITableView alloc] initWithFrame:CGRectMake(0, yRef, 320, IS_IPHONE_5?250:180) style:UITableViewStylePlain];
    tblOrder.backgroundColor = colorTableBG;
    tblOrder.delegate = self;
    tblOrder.dataSource = self;
    [self.view addSubview:tblOrder];
    
    
    UIImageView *imgViewBuyButton = [[UIImageView alloc] initWithFrame:CGRectMake(0, IS_IPHONE_5?518-20:430-20, 320, 70)];
    imgViewBuyButton.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"black-bg" ofType:@"png"]];
    [self.view addSubview:imgViewBuyButton];
    
    btnBuy = [[UIButton alloc] initWithFrame:CGRectMake(10, IS_IPHONE_5?523-20:435-20, 300, 40)];
    [btnBuy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnBuy.titleLabel.font = [UIFont systemFontOfSize:24];
    [btnBuy setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"done" ofType:@"png"]] forState:UIControlStateNormal];
    if(card!=nil)
        [btnBuy setTitle:@"Confirm Purchase" forState:UIControlStateNormal];
    else
        [btnBuy setTitle:@"Add Payment Method" forState:UIControlStateNormal];

    [btnBuy addTarget:self action:@selector(addPayment) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBuy];
    
    lblTitle = [[UILabel alloc] init];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.frame = CGRectMake(10, IS_IPHONE_5?543:455, 300, 20);
    lblTitle.text = @"Information is sent over a secure connection.";
    lblTitle.font = [UIFont systemFontOfSize:12.0];
    lblTitle.textColor = [UIColor lightGrayColor];
    lblTitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblTitle];

}

- (void)addPayment
{
    if([[btnBuy titleForState:UIControlStateNormal] isEqualToString:@"Confirm Purchase"])
    {
        [DSBezelActivityView newActivityViewForView:self.view
                                          withLabel:@"Purchasing..."];
        [self save:nil];
    }
    else if([[btnBuy titleForState:UIControlStateNormal] isEqualToString:@"Add Payment Method"])
    {
        PaymentViewController *objVC = [[PaymentViewController alloc] init];
        objVC.strAmount = strPurchasePrice;
        objVC.strCampaign_uuid = strCampaign_uuid;
        objVC.objPurchaseOrderVC = self;
        [self.navigationController pushViewController:objVC animated:YES];
        objVC = nil;
    }
}
#pragma mark - Stripe

- (IBAction)save:(id)sender
{

//    STPCard *card = [[STPCard alloc] init];
//    card.number = self.paymentView.card.number;
//    card.expMonth = self.paymentView.card.expMonth;
//    card.expYear = self.paymentView.card.expYear;
//    card.cvc = self.paymentView.card.cvc;
    
    [Stripe createTokenWithCard:card completion:^(STPToken *token, NSError *error) {
        if (error) {
            [self handleError:error];
        } else {
            [self createBackendChargeWithToken:token];
        }
    }];
}
- (void)handleError:(NSError *)error
{
    [DSBezelActivityView removeViewAnimated:YES];
}
- (void)createBackendChargeWithToken:(STPToken *)token
{
    [objStripeBL makePaymentFor:strCampaign_uuid andAmount:strPurchasePrice andToken:token.tokenId];
}

- (void)paymentParserFinished:(NSDictionary *)dictData
{
    [DSBezelActivityView removeViewAnimated:YES];

    if([[dictData objectForKey:@"statusDescription"] isEqualToString:@"Success"])
    {
        [self screenDesignForSuccess:[dictData objectForKey:@"coupon_code"]];
    }
    else
    {
        [self showAlertWithOKAndMessage:[dictData objectForKey:@"statusDescription"]];
    }

    btnBuy.enabled = NO;
}
- (void)errorInParseing:(NSError *)error
{
    [DSBezelActivityView removeViewAnimated:YES];
}
- (void)screenDesignForSuccess:(NSString *)strCouponC
{
    strCouponCode = strCouponC;
    UIView *viewMessage = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 290)];
    viewMessage.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewMessage];
    
    UIImageView *imgViewRight = [[UIImageView alloc] initWithFrame:CGRectMake(116, 30, 87, 87)];
    imgViewRight.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"rightIcon" ofType:@"png"]];
    [viewMessage addSubview:imgViewRight];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 130, 320, 40)];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.textColor = colorGreen;
    lblTitle.font = [UIFont systemFontOfSize:24.0];
    lblTitle.text = @"This Offer is all yours!";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [viewMessage addSubview:lblTitle];
    
    UILabel *lblThanks = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, 280, 50)];
    lblThanks.backgroundColor = [UIColor clearColor];
    lblThanks.textColor = [UIColor grayColor];
    lblThanks.textAlignment = NSTextAlignmentCenter;
    lblThanks.numberOfLines = 0;
    lblThanks.text = @"Thank you for your purchase. The Offer will appear in My Offer.";
    lblThanks.font = [UIFont systemFontOfSize:15.0];
    [viewMessage addSubview:lblThanks];
    
    UIButton *btnShare = [[UIButton alloc] initWithFrame:CGRectMake(0, 240, 160, 50)];
    [btnShare addTarget:self action:@selector(shareClicked) forControlEvents:UIControlEventTouchUpInside];
    btnShare.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btnShare.layer.borderWidth = 0.5;
    [btnShare setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"btnShare" ofType:@"png"]] forState:UIControlStateNormal];
    [viewMessage addSubview:btnShare];

    UIButton *btnViewOffers = [[UIButton alloc] initWithFrame:CGRectMake(160, 240, 160, 50)];
    [btnViewOffers addTarget:self action:@selector(viewOfferClicked) forControlEvents:UIControlEventTouchUpInside];
    btnViewOffers.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btnViewOffers.layer.borderWidth = 0.5;
    [btnViewOffers setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"btnViewOffer" ofType:@"png"]] forState:UIControlStateNormal];
    [viewMessage addSubview:btnViewOffers];

}

- (void)viewOfferClicked
{
    BWPurchasedCouponViewController *objVC = [[BWPurchasedCouponViewController alloc] init];
    objVC.dictOffer = [[NSMutableDictionary alloc] initWithDictionary:self.dictOffer];
    [objVC.dictOffer setObject:strCouponCode forKey:@"coupon_code"];
    [self.navigationController pushViewController:objVC animated:YES];
    objVC = nil;
}
- (void)shareClicked
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
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *viewFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
//    UILabel *lblVersion = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 80)];
//    lblVersion.text = @"By confirming the purchase, I agree to Buckworm's Terms of Use and Privacy Statement.";
//    lblVersion.numberOfLines = 0;
//    lblVersion.font = [UIFont systemFontOfSize:14.0];
//    lblVersion.adjustsFontSizeToFitWidth = YES;
//    lblVersion.textColor = [UIColor darkGrayColor];
//    lblVersion.backgroundColor = [UIColor clearColor];
//    [viewFooter addSubview:lblVersion];
    
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
    
    UILabel *lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    lblHeader.text = @"Order Details";
    lblHeader.textAlignment = NSTextAlignmentCenter;
    lblHeader.font = [UIFont fontWithName:@"Arial" size:18];
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
    cell.textLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];

    cell.textLabel.textColor = [UIColor darkGrayColor];
    if(indexPath.row==0)
    {
        cell.textLabel.text = @"Quantity";
        cell.detailTextLabel.text = @"1";
    }
    else if(indexPath.row==1)
    {
        cell.textLabel.text = @"Subtotal";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"$%@", strPurchasePrice];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else if(indexPath.row==2)
    {
        cell.textLabel.text = @"Total Price";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"$%@", strPurchasePrice];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else if(indexPath.row==3)
    {
        cell.textLabel.text = @"Payment Method";
        if(self.card)
        {
            cell.imageView.image = [self setCardTypeImage];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else
    {
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = @"By confirming the purchase, I agree to Buckworm's Terms of Use and Privacy Statement.";
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    }

    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row==3 && self.card)
    {
        BWCardInfoViewController *objCardInfo = [[BWCardInfoViewController alloc] init];
        objCardInfo.card = self.card;
        [self.navigationController pushViewController:objCardInfo animated:YES];
        objCardInfo = nil;
    }
}
- (UIImage *)setCardTypeImage
{
    NSString *cardTypeName = @"placeholder";
    
    if(card!=nil)
    {
        PTKCardNumber *cardNumber = [PTKCardNumber cardNumberWithString:card.number];
        PTKCardType cardType = [cardNumber cardType];
        
        switch (cardType) {
            case PTKCardTypeAmex:
                cardTypeName = @"amex";
                break;
            case PTKCardTypeDinersClub:
                cardTypeName = @"diners";
                break;
            case PTKCardTypeDiscover:
                cardTypeName = @"discover";
                break;
            case PTKCardTypeJCB:
                cardTypeName = @"jcb";
                break;
            case PTKCardTypeMasterCard:
                cardTypeName = @"mastercard";
                break;
            case PTKCardTypeVisa:
                cardTypeName = @"visa";
                break;
            default:
                break;
        }
    }
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:cardTypeName ofType:@"png"]];
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
