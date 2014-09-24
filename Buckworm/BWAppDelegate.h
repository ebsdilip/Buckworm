//
//  BWAppDelegate.h
//  Buckworm
//
//  Created by Developer on 8/27/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import <MapKit/MapKit.h>
#import "BW_Login_BO.h"

@class BWViewController;
@interface BWAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>
{
    Reachability *internetReach;
    int seconds;
}
// UI
@property (strong, nonatomic) BWViewController *rootViewController;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;

//
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *currentLocationPoint;

@property (strong, nonatomic) UILabel *lblTimer;
@property (strong, nonatomic) NSTimer *timerCoupon;

// Network
@property(nonatomic) BOOL isNetAvailable;

@property(nonatomic, strong) BW_Login_BO *objUserLogedIn;

- (void)startCouponTimer;
- (void)stopCouponTimer;

+(BOOL)isCurrentVersionBelongToiOS7;
- (NSString *)getDateFromFormat:(NSString *)currFormat toFormat:(NSString *)toFormat withDate:(NSString *)strDate;
- (NSString *)getCurrentDate;

@end
