//
//  BW_More_ViewController.h
//  Buckworm
//
//  Created by Developer on 6/10/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "BW_Base_ViewController.h"

@class UIViewController;;
@interface BW_More_ViewController : BW_Base_ViewController <UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate>
{
    UITableView *tblMoreOptions;
    NSArray *arrOptions;
}

@property(nonatomic) UIViewController *callbackToHome;

@end
