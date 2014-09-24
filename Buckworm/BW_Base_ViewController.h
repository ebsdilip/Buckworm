//
//  BW_Base_ViewController.h
//  Buckworm
//
//  Created by Developer on 6/10/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#import "BWAppDelegate.h"
#import "DSActivityView.h"

@interface BW_Base_ViewController : UIViewController
{
    BWAppDelegate *appDelegate;
    UILabel *lblBarTitle;
}
- (void)showBackButton;
- (void)showAlertWithOKAndMessage:(NSString *)strMessage;
- (void)noInternetMessage;
@end
