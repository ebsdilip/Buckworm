//
//  BW_AddCard_ViewController.m
//  buckworm
//
//  Created by TechSunRise on 6/19/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_AddCard_ViewController.h"

@interface BW_AddCard_ViewController ()

@end

@implementation BW_AddCard_ViewController

- (void)clearMemory
{
    strAddCardURLToLoad = nil;
    objMyCardsBL.callBack = nil;
    objMyCardsBL = nil;
    
    webViewAddCards.delegate = nil;
    webViewAddCards = nil;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        objMyCardsBL = [[BW_MyCards_BL alloc] init];
        objMyCardsBL.callBack = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackButton];
    lblBarTitle.text = self.title;

    [self getAddCardURL];
}

- (void)showInWebView
{
    if(webViewAddCards==nil)
    {
        webViewAddCards = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, 320, IS_IPHONE_5?460-64:372-64)];
        webViewAddCards.delegate = self;
        [self.view addSubview:webViewAddCards];
    }
    
    NSURL *websiteUrl = [NSURL URLWithString:strAddCardURLToLoad];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Loading..."];
    [webViewAddCards performSelector:@selector(loadRequest:) withObject:urlRequest afterDelay:0.1];
    
    UIBarButtonItem *flexibleSpace =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:webViewAddCards action:@selector(reload)];
    NSArray *toolbarItems = [NSArray arrayWithObjects:flexibleSpace, barButton, flexibleSpace, nil];
    [self.navigationController.toolbar setItems:toolbarItems animated:NO];
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [DSBezelActivityView removeViewAnimated:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [DSBezelActivityView removeViewAnimated:YES];
}

- (void)getAddCardURL
{
    [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Loading..."];
    [objMyCardsBL getAddCardURL];
}

- (void)errorInParseing:(NSError *)error
{
    [DSBezelActivityView removeViewAnimated:YES];
    [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Internet connection appears to be offline." waitUntilDone:NO];

}

- (void)AddCardURLParserFinished:(NSString *)strAddCardURL
{
    [DSBezelActivityView removeViewAnimated:YES];
    
//    https://www.mylinkables.com/consumerapi/cardlink?access_token=&cap=buckworm
    strAddCardURLToLoad = strAddCardURL;
    
    [self showInWebView];
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
