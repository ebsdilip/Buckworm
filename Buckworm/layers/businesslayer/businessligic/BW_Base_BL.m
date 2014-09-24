//
//  BW_Base_BL.m
//  buckworm
//
//  Created by TechSunRise on 6/18/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_Base_BL.h"

@implementation BW_Base_BL

- (instancetype)init
{
    self = [super init];
    if (self) {
        appDelegate = (BWAppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return self;
}

- (void)showAlertNoInternetAvailable
{
    [self performSelectorOnMainThread:@selector(showAlertNoInternetAvailableMainThread) withObject:nil waitUntilDone:YES];
}
- (void)showAlertNoInternetAvailableMainThread
{
    [DSBezelActivityView removeViewAnimated:YES];

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Internet not available!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    alert = nil;
}

@end
