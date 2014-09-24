//
//  BW_Base_BL.h
//  buckworm
//
//  Created by TechSunRise on 6/18/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BWAppDelegate.h"
#import "DSActivityView.h"

@interface BW_Base_BL : NSObject
{
    BWAppDelegate *appDelegate;
}
- (void)showAlertNoInternetAvailable;
@end
