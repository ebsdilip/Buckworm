//
//  BWBaseViewController.h
//  Buckworm
//
//  Created by Developer on 8/27/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BWAppDelegate.h"

@interface BWBaseViewController : UIViewController
{
    BWAppDelegate *appDelegate;
}
- (void)showAlertWithOKAndMessage:(NSString *)strMessage;

@end
