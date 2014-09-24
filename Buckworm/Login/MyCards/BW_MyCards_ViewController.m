//
//  BW_MyCards_ViewController.m
//  Buckworm
//
//  Created by Developer on 6/10/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_MyCards_ViewController.h"
#import "BW_MyCards_TableViewCell.h"
#import "BW_AddCard_ViewController.h"

@interface BW_MyCards_ViewController ()

@end

@implementation BW_MyCards_ViewController

@synthesize callbackToHome;
@synthesize intTag;

- (void)clearMemory
{
    tblCards = nil;
    tblCards.delegate = nil;
    tblCards.dataSource = nil;
    lblMessageOfferNotAvailable = nil;
    arrCards = nil;

    objLoginBL.callBack = nil;
    objLoginBL = nil;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        intTag = 0;
        objCardBL = [[BW_MyCards_BL alloc] init];
        objCardBL.callBack = self;

        objLoginBL = [[BW_Login_BL alloc] init];
        objLoginBL.callBack = self;
        
        arrCards = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self showBackButton];

    UIBarButtonItem *btnShare = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addACardClicked)];
    self.navigationItem.rightBarButtonItem = btnShare;

    [self screenDesigning];
    
//    [self performSelector:@selector(getCards) withObject:nil afterDelay:0.4];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self performSelector:@selector(getCards) withObject:nil afterDelay:0.4];
}
- (void)screenDesigning
{
    lblBarTitle.text = intTag==100?@"Select A Card":@"My Cards";

    tblCards = [[UITableView alloc] initWithFrame:CGRectMake(10, 64, 300, IS_IPHONE_5?396:308) style:UITableViewStylePlain];
    tblCards.backgroundColor = [UIColor clearColor];
    tblCards.backgroundView = nil;
    tblCards.separatorStyle = UITableViewCellSeparatorStyleNone;
    tblCards.delegate = self;
    tblCards.dataSource = self;
    [self.view addSubview:tblCards];
    
    UIButton *btnDONE = [[UIButton alloc] initWithFrame:CGRectMake(15, IS_IPHONE_5?520:432, 290, 30)];
    [btnDONE addTarget:self action:@selector(btnDONEClicked) forControlEvents:UIControlEventTouchUpInside];
    btnDONE.titleLabel.font = [UIFont systemFontOfSize:16.0];
    btnDONE.backgroundColor = colorLightGrayForBG;
    btnDONE.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btnDONE.layer.borderWidth = 1.0;
    [btnDONE setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnDONE setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [btnDONE setTitle:@"DONE" forState:UIControlStateNormal];
    [self.view addSubview:btnDONE];

}
- (void)btnDONEClicked
{
    if(strSelectedCard!=nil && [strSelectedCard length]>0)
    {
        appDelegate.objUserLogedIn.strSelectedCard = strSelectedCard;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Please select a card." waitUntilDone:NO];

}
- (void)addACardClicked
{
    if([appDelegate.objUserLogedIn.strConsumerToken length]>0)
    {
        BW_AddCard_ViewController *objVC = [[BW_AddCard_ViewController alloc] init];
        [self.navigationController pushViewController:objVC animated:YES];
        objVC = nil;
    }
    else
    {
        if(webView)
        {
            [webView removeFromSuperview];
            webView = nil;
        }
        //        self.view.backgroundColor = [UIColor whiteColor];
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, 320, self.view.frame.size.height+40)];
        webView.scrollView.bounces = NO;
        webView.userInteractionEnabled = YES;
        webView.clipsToBounds=YES;
        webView.scrollView.showsVerticalScrollIndicator=NO;
        [webView setBackgroundColor:[UIColor whiteColor]];
        [webView setOpaque:NO];
        
        [appDelegate.window addSubview:webView];
        
        NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"LN_TC" ofType:@"html"];
        
        NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
        [webView loadHTMLString:htmlString baseURL:nil];
        
        UIButton *btnIAgree = [[UIButton alloc] initWithFrame:CGRectMake(2, self.view.frame.size.height, 157, 40)];
        [btnIAgree addTarget:self action:@selector(iAgreeClicked) forControlEvents:UIControlEventTouchUpInside];
        [btnIAgree setTitle:@"I AGREE" forState:UIControlStateNormal];
        btnIAgree.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue: 0.0 alpha:0.8];
        [webView addSubview:btnIAgree];
        
        UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(161, self.view.frame.size.height, 157, 40)];
        [btnCancel addTarget:self action:@selector(cancelClicked) forControlEvents:UIControlEventTouchUpInside];
        [btnCancel setTitle:@"CANCEL" forState:UIControlStateNormal];
        btnCancel.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue: 0.0 alpha:0.8];
        [webView addSubview:btnCancel];

    }
}
- (void)cancelClicked
{
    if(webView)
    {
        [webView removeFromSuperview];
        webView = nil;
    }
}
- (void)iAgreeClicked
{
    if(webView)
    {
        [webView removeFromSuperview];
        webView = nil;
    }
    [self registerWithLinkable];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 2003 && buttonIndex==0)
    {
        [self registerWithLinkable];
    }
}

#pragma mark - linkable registration
- (void)registerWithLinkable
{
    if(self.navigationController)
        [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Connecting..."];
    else
        [DSBezelActivityView newActivityViewForView:self.view
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
    else
    {
        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:[dictData objectForKey:@"statusDescription"] waitUntilDone:NO];
    }
}
#pragma mark -
#pragma mark TableView Delegate Datasource Methods
#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [arrCards count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    viewHeader.backgroundColor = [UIColor clearColor];
    return viewHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    viewHeader.backgroundColor = [UIColor clearColor];
    return viewHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"jobsite";
    
    BW_MyCards_TableViewCell *cell = (BW_MyCards_TableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        @autoreleasepool {
            cell = [[BW_MyCards_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    }
    
    NSDictionary *dictCard = [arrCards objectAtIndex:indexPath.section];
    [cell setParameter:dictCard];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"card_600" ofType:@"png"]]];
//    cell.textLabel.text = [arrOptions objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
    
    if(intTag==100)
        cell.backgroundColor = [UIColor orangeColor];
    
    
    if([strSelectedCard isEqualToString:[dictCard objectForKey:@"accountToken"]])
        cell.imgViewChecked.hidden = NO;
    else
        cell.imgViewChecked.hidden = YES;
        
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictCard = [arrCards objectAtIndex:indexPath.section];
    strSelectedCard = [dictCard objectForKey:@"accountToken"];
    [tblCards reloadData];
}
#pragma mark - PARSERS
- (void)getCards
{
    if(self.navigationController)
        [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Fetching cards..."];
    else
        [DSBezelActivityView newActivityViewForView:self.view
                                      withLabel:@"Fetching cards..."];

    [objCardBL getCards];
}

- (void)CardsListParserFinished:(NSDictionary *)dictData
{
    [arrCards removeAllObjects];
    
    [arrCards addObjectsFromArray:[dictData objectForKey:@"account"]];
    [tblCards reloadData];
    if([arrCards count]==0)
        [self ShowMessage:@"No cards added."];
    else
    {
        [self hideMessage];
        for (int i=0; i<[arrCards count]; i++)
        {
            NSDictionary *dictCard = [arrCards objectAtIndex:i];
            if([dictCard objectForKey:@"defaultAccount"])
            {
                strSelectedCard = [dictCard objectForKey:@"accountToken"];
                break;
            }
        }
    }
    [DSBezelActivityView removeViewAnimated:YES];
}

- (void)errorInParseing:(NSError *)error
{
    [DSBezelActivityView removeViewAnimated:YES];
    [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Internet connection appears to be offline." waitUntilDone:NO];
}
- (void)ShowMessage:(NSString *)strMessage
{
    if(lblMessageOfferNotAvailable==nil)
    {
        lblMessageOfferNotAvailable = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 100)];
        lblMessageOfferNotAvailable.textAlignment = NSTextAlignmentCenter;
        lblMessageOfferNotAvailable.font = [UIFont boldSystemFontOfSize:16.0];
        lblMessageOfferNotAvailable.textColor = [UIColor darkGrayColor];
        lblMessageOfferNotAvailable.numberOfLines = 0;
        [self.view addSubview:lblMessageOfferNotAvailable];
    }
    else
    {
        [self.view addSubview:lblMessageOfferNotAvailable];
    }
    lblMessageOfferNotAvailable.text = strMessage;
}

- (void)hideMessage
{
    if(lblMessageOfferNotAvailable)
        [lblMessageOfferNotAvailable removeFromSuperview];
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
