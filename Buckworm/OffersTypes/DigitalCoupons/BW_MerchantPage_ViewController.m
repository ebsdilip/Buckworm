//
//  BW_MerchantPage_ViewController.m
//  buckworm
//
//  Created by Developer on 8/21/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_MerchantPage_ViewController.h"

@interface BW_MerchantPage_ViewController ()

@end

@implementation BW_MerchantPage_ViewController

@synthesize strWebsite;
@synthesize strBusinessName;

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

    [self screenDesigning];
}

- (void)screenDesigning
{
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    viewHeader.backgroundColor = colorGreen;
    [self.view addSubview:viewHeader];
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 22, 40, 40)];
    [btnBack setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon-arrow" ofType:@"png"]] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    btnBack = nil;
    
    UILabel *lblHeaderTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 200, 40)];
    lblHeaderTitle.textAlignment = NSTextAlignmentCenter;
    lblHeaderTitle.font = [UIFont boldSystemFontOfSize:16.0];
    lblHeaderTitle.numberOfLines = 2;
    lblHeaderTitle.textColor = [UIColor whiteColor];
    lblHeaderTitle.backgroundColor = [UIColor clearColor];
    lblHeaderTitle.text = strBusinessName;
    [self.view addSubview:lblHeaderTitle];

//    http://bgeventsandcatering.com
//    www.BroadwayGourmet.com
//    strWebsite = [strWebsite stringByReplacingOccurrencesOfString:@"www." withString:@"http://"];
//    NSString *strURL = [NSString stringWithFormat:@"http://%@", strWebsite];
//    NSString *strURL = [strWebsite stringByReplacingOccurrencesOfString:@"www." withString:@"http://"];
    
//    NSString *strURL = [NSString stringWithFormat:@"http://%@.buckworm.com", [strBusinessName stringByReplacingOccurrencesOfString:@" " withString:@"-"]];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strWebsite]];
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, 320, IS_IPHONE_5?500:416)];
    webView.delegate = self;
    webView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:webView];

    [DSBezelActivityView newActivityViewForView:self.view
                                      withLabel:@"Loading..."];
//    [webView performSelector:@selector(loadRequest:) withObject:request afterDelay:0.1];
    [webView loadRequest:request];

}
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextClicked
{
    [webView goForward];
}
- (void)prevClicked
{
    [webView goBack];
}

- (BOOL)webView:(UIWebView *)wv shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    // Determine if we want the system to handle it.
    NSURL *url = request.URL;
    if (![url.scheme isEqual:@"http"] && ![url.scheme isEqual:@"https"]) {
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            [[UIApplication sharedApplication]openURL:url];
            return NO;
        }
    }
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
