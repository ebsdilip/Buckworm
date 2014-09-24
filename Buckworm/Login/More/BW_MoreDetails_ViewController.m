//
//  BW_MoreDetails_ViewController.m
//  buckworm
//
//  Created by Developer on 6/12/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_MoreDetails_ViewController.h"

@interface BW_MoreDetails_ViewController ()

@end

@implementation BW_MoreDetails_ViewController

@synthesize intCategoryID;

- (void)clearMemory
{
    tblFAQ.delegate = nil;
    tblFAQ.dataSource = nil;
    tblFAQ = nil;
    
    webView.delegate = nil;
    [webView removeFromSuperview];
    webView = nil;
    arrFAQ = nil;
    arrIndexes = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        intSelectedQ = -1;
        arrIndexes = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    [self showBackButton];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self showData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self clearMemory];
}

- (void)initializeFAQData
{
    arrFAQ = [[NSMutableArray alloc] init];
    
    [arrFAQ addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"Once you are logged into your account, you can go to MY ACCOUNT. Under the My Cards section, you will get the option to Add New Card.\n\nAlternatively, in the Shopworm section, you can click on any offer on the \"Link This Offer\" button. If this is the first card that you will be adding, then you would be taken to the page where you can enter your card information in a secure environment.", @"1. How do I add a new card?", nil]];
    
    [arrFAQ addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"Once you are logged into your account, Shopworm is where you see the offers available to you and get to link them to your card to start redeeming. And saving!\n\nShopworm also contains your Savings Badge, which tells you exactly how much you have saved so far on redeeming offers. As you link more offers, make more savings, the amount in your \"Savings Bank\" keep increasing!", @"2. What is Shopworm?", nil]];
    
    [arrFAQ addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"Education station is where students of all ages go to access online educational content. The more time you spent learning on our education station, the more points you earn. These points make you eligible for offers where you can make enhanced savings on everyday items. So start learning and earning!", @"3. What is Education Station?", nil]];
    
    [arrFAQ addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"You would receive the following notifications on your registered email address:\n\na. About exciting AVAILABLE offers.\nb. When an offer is about to EXPIRE.\nc. To confirm you have LINKED an offer.\nd. If you have REDEEMED an offer.\ne. When SAVINGS are sent back to you.\nf.System notices from Buckworm.", @"4. Which notifications will I receive?", nil]];
    
    [arrFAQ addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"When you are logged into your account, on \"My Account\" page, you would find the \"Notification\" section. Here you can check/uncheck the notifications to control which notifications will be emailed to you.", @"5. How do I control which notifications are sent to me?", nil]];

    [arrFAQ addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"Buckworm values your feedback tremendously. At the bottom of every page on Buckworm's website, you will find a link to \"Feedback\" form. Feel free to write any suggestions, praise, comments or questions. If required, a Buckworm Customer Service Executive will get back to you as early as possible.", @"6. How do I provide feedback?", nil]];
}
- (void)showData
{
    lblBarTitle.text = [self.title uppercaseString];

    if([[self.title lowercaseString] isEqualToString:@"help"])
    {
        self.title = @"FAQ";
        lblBarTitle.text = @"FAQ";
        [self initializeFAQData];
        
        tblFAQ = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, self.view.frame.size.height-64)];
        tblFAQ.delegate = self;
        tblFAQ.dataSource = self;
        [self.view addSubview:tblFAQ];
    }
    else if([[self.title lowercaseString] isEqualToString:@"privacy policy"])
    {
        if(webView)
        {
            [webView removeFromSuperview];
            webView = nil;
        }
        self.view.backgroundColor = [UIColor whiteColor];
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 74, 300, self.view.frame.size.height-84)];
        webView.scrollView.bounces = NO;
        webView.userInteractionEnabled = YES;
        webView.clipsToBounds=YES;
        webView.scrollView.showsVerticalScrollIndicator=NO;
        [webView setBackgroundColor:[UIColor clearColor]];
        [webView setOpaque:NO];
        
        [self.view addSubview:webView];
        
        NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"PrivacyPolicy" ofType:@"html"];
                
        NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
        [webView loadHTMLString:htmlString baseURL:nil];
    }
}
- (void)showDisclamer
{
    if(webView==nil)
    {
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, 320, self.view.frame.size.height-64)];
        [self.view addSubview:webView];
    }
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"Disclamer For Mobil" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [webView loadHTMLString:htmlString baseURL:nil];
    
}

- (void)showTermsAndCondition
{
    if(webView==nil)
    {
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, 320, self.view.frame.size.height-64)];
        webView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:webView];
    }
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"TermsAndCondition" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [webView loadHTMLString:htmlString baseURL:nil];
    
    //    termsnconditions.html
}
#pragma mark- TableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [arrFAQ count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([arrIndexes containsObject:[NSNumber numberWithInt:(int)section]]) {
        return 1;
    }
    //    if(section==intSelectedQ)
    //        return 1;
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSDictionary *dict = [arrFAQ objectAtIndex:section];
    NSString *strQ = [[dict allKeys] objectAtIndex:0];
    CGSize maximumLabelSize = CGSizeMake(290,9999);
    
    CGSize sizeOfString = [strQ sizeWithFont:[UIFont fontWithName:@"Helvetica" size:18.0]
                           constrainedToSize:maximumLabelSize
                               lineBreakMode:NSLineBreakByTruncatingTail];
    return sizeOfString.height+20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc] init];
    
    viewHeader.backgroundColor = [UIColor whiteColor];
    
    UILabel *lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 290, 48)];
    lblHeader.backgroundColor = [UIColor clearColor];
    lblHeader.textColor = [UIColor orangeColor];
    lblHeader.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    
    NSDictionary *dict = [arrFAQ objectAtIndex:section];
    NSString *strQ = [[dict allKeys] objectAtIndex:0];
    lblHeader.text = strQ;
    CGSize maximumLabelSize = CGSizeMake(290,9999);
    
    CGSize sizeOfString = [strQ sizeWithFont:lblHeader.font
                           constrainedToSize:maximumLabelSize
                               lineBreakMode:lblHeader.lineBreakMode];
    lblHeader.frame = CGRectMake(15, 10, 290, sizeOfString.height);
    lblHeader.numberOfLines = 0;
    [viewHeader addSubview:lblHeader];
    
    UIButton *btnHeader = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, sizeOfString.height+20)];
    [btnHeader addTarget:self action:@selector(questionSelected:) forControlEvents:UIControlEventTouchUpInside];
    btnHeader.tag = section;
    [viewHeader addSubview:btnHeader];
    
//    UIButton *btnArrow = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 40, 22)];
//    btnArrow.backgroundColor = [UIColor clearColor];
//    
//    if ([arrIndexes containsObject:[NSNumber numberWithInt:section]])
//        [btnArrow setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"prevWeb" ofType:@"png"]] forState:UIControlStateNormal];
//    else
//        [btnArrow setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"nextWeb" ofType:@"png"]] forState:UIControlStateNormal];
//    
//    [viewHeader addSubview:btnArrow];
//    
//    btnArrow = nil;
    lblHeader = nil;
    btnHeader = nil;
    return viewHeader;
}
- (void)questionSelected:(UIButton *)sender
{
    if ([arrIndexes containsObject:[NSNumber numberWithInt:(int)sender.tag]]) {
        [arrIndexes removeObject:[NSNumber numberWithInt:(int)sender.tag]];
    }
    else {
        [arrIndexes addObject:[NSNumber numberWithInt:(int)sender.tag]];
    }
    [tblFAQ reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
    //    intSelectedQ = sender.tag;
//    [tblFAQ reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [arrFAQ objectAtIndex:indexPath.section];
    NSString *strQ = [dict objectForKey:[[dict allKeys] objectAtIndex:0]];
    CGSize maximumLabelSize = CGSizeMake(270, 9999);
    
    CGSize sizeOfString = [strQ sizeWithFont:[UIFont systemFontOfSize:17.0]
                           constrainedToSize:maximumLabelSize
                               lineBreakMode:NSLineBreakByTruncatingTail];
    return sizeOfString.height+20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"DetailDesc%li_%li",(long)indexPath.section, (long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        @autoreleasepool {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    }
    cell.textLabel.frame = CGRectMake(40, 0, 270, cell.textLabel.frame.size.height);
//    cell.textLabel.textColor = colorGrayBG;
    
    NSDictionary *dict = [arrFAQ objectAtIndex:indexPath.section];
    cell.textLabel.text = [dict objectForKey:[[dict allKeys] objectAtIndex:0]];
    cell.textLabel.font = [UIFont systemFontOfSize:17.0];
    cell.textLabel.textColor = [UIColor colorWithRed:108.0/255 green:108.0/255 blue:108.0/255 alpha:1.0];
    cell.textLabel.numberOfLines = 0;
    cell.backgroundColor = [UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Orientation Methods
- (BOOL)shouldAutorotate {
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
@end
