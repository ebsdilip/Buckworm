//
//  BWCardInfoViewController.m
//  Buckworm
//
//  Created by iLabours on 9/17/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BWCardInfoViewController.h"
#import "PTKTextField.h"

@interface BWCardInfoViewController ()

@end

@implementation BWCardInfoViewController

@synthesize card;
@synthesize paymentView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showBackButton];
    lblBarTitle.text = @"Card Info";

    [self screenDesigning];
//    [self screenDesignForAccount];
}

- (void)screenDesigning
{
    tblPayment = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, 240)];
    tblPayment.backgroundColor = colorTableBG;
    tblPayment.delegate = self;
    tblPayment.dataSource = self;
    [self.view addSubview:tblPayment];
    
    btnDelete = [[UIButton alloc] initWithFrame:CGRectMake(20, 320, 130, 40)];
    [btnDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnDelete.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [btnDelete setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"done" ofType:@"png"]] forState:UIControlStateNormal];
    [btnDelete setTitle:@"Delete" forState:UIControlStateNormal];
    [btnDelete addTarget:self action:@selector(deleteAccount) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btnDelete];

    btnEdit = [[UIButton alloc] initWithFrame:CGRectMake(20, 320, 280, 40)];
    [btnEdit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnEdit.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [btnEdit setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"done" ofType:@"png"]] forState:UIControlStateNormal];
    [btnEdit setTitle:@"Add New" forState:UIControlStateNormal];
    [btnEdit addTarget:self action:@selector(addNewCard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnEdit];


//    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, 320, 50)];
//    lblTitle.backgroundColor = colorTableBG;
//    lblTitle.textColor = [UIColor blackColor];
//    lblTitle.text = @"   Payment Info";
//    [self.view addSubview:lblTitle];
    
}

- (void)deleteAccount
{

}

- (void)addNewCard
{
    [self screenDesignForAccount];
}
- (void)editAccount
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.29];
    [UIView setAnimationDelegate:nil];
    viewAccount.frame = CGRectMake(0, 64, 320, 300);
    [UIView commitAnimations];

}

- (void)screenDesignForAccount
{
    viewAccount = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 300)];
    viewAccount.backgroundColor = colorTableBG;
    [self.view addSubview:viewAccount];
    
    self.paymentView = [[PTKView alloc] initWithFrame:CGRectMake(15, 20, 290, 45)];
    self.paymentView.delegate = self;
    self.paymentView.backgroundColor = colorTableBG;
    
//    self.paymentView.cardNumberField.text = card.number;
//    self.paymentView.cardExpiryField.text = [NSString stringWithFormat:@"%i/%i", card.expMonth, card.expYear];
//    self.paymentView.cardCVCField.text = card.cvc;
    [viewAccount addSubview:self.paymentView];

    btnConfirm = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 300, 40)];
    btnConfirm.enabled = NO;
    btnConfirm.backgroundColor = colorGreen;
    [btnConfirm addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    [btnConfirm setTitle:@"CONFIRM" forState:UIControlStateNormal];
    [btnConfirm setTitle:@"CONFIRM" forState:UIControlStateDisabled];
    [viewAccount addSubview:btnConfirm];

//    txtFieldCardHolder = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 300, 40)];
//    txtFieldCardHolder.backgroundColor = [UIColor whiteColor];
//    txtFieldCardHolder.placeholder = @"Cardholder Name";
//    [viewAccount addSubview:txtFieldCardHolder];
//
//    txtFieldCardNumber = [[UITextField alloc] initWithFrame:CGRectMake(10, 42, 300, 40)];
//    txtFieldCardNumber.backgroundColor = [UIColor whiteColor];
//    txtFieldCardNumber.placeholder = @"Card Number";
//    [viewAccount addSubview:txtFieldCardNumber];
//
//    txtFieldCardExpiryDate = [[UITextField alloc] initWithFrame:CGRectMake(10, 82, 150, 40)];
//    txtFieldCardExpiryDate.backgroundColor = [UIColor whiteColor];
//    txtFieldCardExpiryDate.placeholder = @"Expiration Date";
//    [viewAccount addSubview:txtFieldCardExpiryDate];
//
//    txtFieldCardCVC = [[UITextField alloc] initWithFrame:CGRectMake(160, 82, 150, 40)];
//    txtFieldCardCVC.backgroundColor = [UIColor whiteColor];
//    txtFieldCardCVC.placeholder = @"CVV";
//    [viewAccount addSubview:txtFieldCardCVC];

//    UIButton *btnDone = [[UIButton alloc] initWithFrame:CGRectMake(20, 200, 130, 40)];
//    [btnDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    btnDone.titleLabel.font = [UIFont boldSystemFontOfSize:18];
//    [btnDone setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"done" ofType:@"png"]] forState:UIControlStateNormal];
//    [btnDone setTitle:@"DONE" forState:UIControlStateNormal];
//    [btnDone addTarget:self action:@selector(doneAccount) forControlEvents:UIControlEventTouchUpInside];
//    [viewAccount addSubview:btnDone];
//    
//    UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(170, 200, 130, 40)];
//    [btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    btnCancel.titleLabel.font = [UIFont boldSystemFontOfSize:18];
//    [btnCancel setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"done" ofType:@"png"]] forState:UIControlStateNormal];
//    [btnCancel setTitle:@"CANCEL" forState:UIControlStateNormal];
//    [btnCancel addTarget:self action:@selector(cancelAccount) forControlEvents:UIControlEventTouchUpInside];
//    [viewAccount addSubview:btnCancel];

}

- (void) paymentView:(PTKView *)paymentView withCard:(PTKCard *)card isValid:(BOOL)valid
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Valid Card" message:@"Card information is valid please confirm the card." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    alert = nil;
    btnConfirm.enabled = YES;
}

- (void)confirm:(UIButton *)sender
{
    card.number = self.paymentView.card.number;
    card.expMonth = self.paymentView.card.expMonth;
    card.expYear = self.paymentView.card.expYear;
    card.cvc = self.paymentView.card.cvc;

    STPCard *cardT = [[STPCard alloc] init];
    cardT.number = self.paymentView.card.number;
    cardT.expMonth = self.paymentView.card.expMonth;
    cardT.expYear = self.paymentView.card.expYear;
    cardT.cvc = self.paymentView.card.cvc;

    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.paymentView.card.number forKey:@"number"];
    [userDefault setObject:[NSString stringWithFormat:@"%i", self.paymentView.card.expMonth] forKey:@"expMonth"];
    [userDefault setObject:[NSString stringWithFormat:@"%i", self.paymentView.card.expYear] forKey:@"expYear"];
    [userDefault setObject:[NSString stringWithFormat:@"%@", self.paymentView.card.cvc] forKey:@"cvc"];
    
    [self.navigationController popViewControllerAnimated:YES];
    

}
- (void)doneAccount
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.29];
    [UIView setAnimationDelegate:nil];
    viewAccount.frame = CGRectMake(320, 64, 320, 300);
    [UIView commitAnimations];

}
- (void)cancelAccount
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.29];
    [UIView setAnimationDelegate:nil];
    viewAccount.frame = CGRectMake(320, 64, 320, 300);
    [UIView commitAnimations];

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
    return 4;
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
    
    UILabel *lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    lblHeader.text = @"Payment Info";
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
    
    cell.textLabel.textColor = [UIColor darkGrayColor];
    if(indexPath.row==0)
    {
        cell.textLabel.text = @"Cardholder Name";
        cell.detailTextLabel.text = card.name?card.name:@"NA";
    }
    else if(indexPath.row==1)
    {
        cell.textLabel.text = @"Card Number";
        cell.detailTextLabel.text = card.number;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else if(indexPath.row==2)
    {
        cell.textLabel.text = @"Expiration date";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%i/%i", card.expMonth, card.expYear];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else
    {
        cell.textLabel.text = @"CVC";
        cell.detailTextLabel.text = card.cvc;
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
    
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
/*
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
*/
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
