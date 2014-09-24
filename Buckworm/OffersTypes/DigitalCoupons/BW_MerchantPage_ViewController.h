//
//  BW_MerchantPage_ViewController.h
//  buckworm
//
//  Created by Developer on 8/21/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeoCodeFromAddressParser.h"

@interface BW_MerchantPage_ViewController : UIViewController <UIWebViewDelegate, GeoCodeFromAddressParserDelegate>
{
    NSString *strBusinessName;
    NSString *strWebsite;
    UIWebView *webView;
}

@property(nonatomic) NSString *strWebsite;
@property(nonatomic) NSString *strBusinessName;

@end
