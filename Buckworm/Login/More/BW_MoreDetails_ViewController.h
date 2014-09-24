//
//  BW_MoreDetails_ViewController.h
//  buckworm
//
//  Created by Developer on 6/12/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BW_Base_ViewController.h"

@interface BW_MoreDetails_ViewController : BW_Base_ViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSInteger intCategoryID;
    UIWebView *webView;
    
    UITableView *tblFAQ;
    
    NSMutableArray *arrFAQ;
    NSMutableArray *arrIndexes;
    NSInteger intSelectedQ;
}
@property(nonatomic) NSInteger intCategoryID;

@end
