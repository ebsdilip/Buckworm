//
//  ViewController.m
//  PTKPayment Example
//
//  Created by Alex MacCaw on 1/21/13.
//  Copyright (c) 2013 Stripe. All rights reserved.
//

#import "PaymentViewController.h"
#import "Stripe.h"
#import "BWPurchaseOrderrDetailsViewController.h"

@interface PaymentViewController()

@property IBOutlet PTKView* paymentView;

@end


#pragma mark -

@implementation PaymentViewController

@synthesize objPurchaseOrderVC;
@synthesize strAmount;
@synthesize strCampaign_uuid;

- (instancetype)init
{
    self = [super init];
    if (self) {
        objStripeBL = [[BW_Stripe_BL alloc] init];
        objStripeBL.callBack = self;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showBackButton];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    lblBarTitle.text = @"Change Card";
    

    btnSave = [[UIButton alloc] initWithFrame:CGRectMake(10, 200, 300, 40)];
    btnSave.enabled = NO;
    btnSave.backgroundColor = colorGreen;
    [btnSave addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [btnSave setTitle:@"CONFIRM" forState:UIControlStateNormal];
    [btnSave setTitle:@"CONFIRM" forState:UIControlStateDisabled];
    [self.view addSubview:btnSave];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    saveButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = saveButton;
    
    self.paymentView = [[PTKView alloc] initWithFrame:CGRectMake(15, 80, 290, 45)];
    self.paymentView.delegate = self;
    self.paymentView.backgroundColor = colorTableBG;
    [self.view addSubview:self.paymentView];
}


- (void) paymentView:(PTKView *)paymentView withCard:(PTKCard *)card isValid:(BOOL)valid
{
    btnSave.enabled = valid;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Valid Card" message:@"Card information is valid please confirm the card." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    alert = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender
{
    STPCard *card = [[STPCard alloc] init];
    card.number = self.paymentView.card.number;
    card.expMonth = self.paymentView.card.expMonth;
    card.expYear = self.paymentView.card.expYear;
    card.cvc = self.paymentView.card.cvc;
    
    objPurchaseOrderVC.card = card;
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.paymentView.card.number forKey:@"number"];
    [userDefault setObject:[NSString stringWithFormat:@"%i", self.paymentView.card.expMonth] forKey:@"expMonth"];
    [userDefault setObject:[NSString stringWithFormat:@"%i", self.paymentView.card.expYear] forKey:@"expYear"];
    [userDefault setObject:[NSString stringWithFormat:@"%@", self.paymentView.card.cvc] forKey:@"cvc"];

    [objPurchaseOrderVC.tblOrder reloadData];
    [objPurchaseOrderVC.btnBuy setTitle:@"Confirm Purchase" forState:UIControlStateNormal];
    [self.navigationController popViewControllerAnimated:YES];
    
//    [Stripe createTokenWithCard:card completion:^(STPToken *token, NSError *error) {
//        if (error) {
//            [self handleError:error];
//        } else {
//            [self createBackendChargeWithToken:token];
//        }
//    }];
}
- (void)handleError:(NSError *)error
{

}
- (void)createBackendChargeWithToken:(STPToken *)token
{
    [DSBezelActivityView newActivityViewForView:self.view
                                      withLabel:@"Purchasing..."];
    [objStripeBL makePaymentFor:strCampaign_uuid andAmount:strAmount andToken:token.tokenId];

}

- (void)paymentParserFinished:(NSDictionary *)dictData
{
        [DSBezelActivityView removeViewAnimated:YES];
    if([[dictData objectForKey:@"statusDescription"] isEqualToString:@"Success"])
    {
        [self screenDesignForSuccess];
    }
    else
    {
        [self showAlertWithOKAndMessage:[dictData objectForKey:@"statusDescription"]];
    }
}
- (void)errorInParseing:(NSError *)error
{
    [DSBezelActivityView removeViewAnimated:YES];
}
- (void)screenDesignForSuccess
{
    UIView *viewMessage = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 300)];
    viewMessage.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewMessage];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 320, 40)];
    lblTitle.backgroundColor = colorTableBG;
    lblTitle.textColor = colorGreen;
    lblTitle.font = [UIFont systemFontOfSize:30.0];
    lblTitle.text = @"This Offer is all yours!";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [viewMessage addSubview:lblTitle];

    UILabel *lblThanks = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 280, 20)];
    lblThanks.backgroundColor = [UIColor clearColor];
    lblThanks.textColor = colorGreen;
    lblThanks.text = @"Thank you for your purchase. The Offer will appear in My Offer.";
    lblThanks.font = [UIFont systemFontOfSize:15.0];
    [viewMessage addSubview:lblThanks];

}
@end
