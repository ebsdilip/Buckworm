//
//  BWAppDelegate.m
//  Buckworm
//
//  Created by Developer on 8/27/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BWAppDelegate.h"
#import "BWViewController.h"
#import "Stripe.h"

//NSString * const StripePublishableKey = @"pk_test_zSQln43JHIXL9SO47Gb167nN";
NSString * const StripePublishableKey = @"pk_test_4SzD9OZHblrwtSy3PVoU0SuR";

@implementation BWAppDelegate

@synthesize navController;
@synthesize rootViewController;
@synthesize window;

@synthesize locationManager;
@synthesize currentLocationPoint;

@synthesize lblTimer;
@synthesize timerCoupon;

@synthesize isNetAvailable;

@synthesize objUserLogedIn;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self checkNetworkStatus];
 
    [Stripe setDefaultPublishableKey:StripePublishableKey];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    rootViewController = [[BWViewController alloc] init];
    
    
    navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    navController.navigationBar.translucent = NO;
    navController.navigationBarHidden = YES;
    navController.toolbarHidden = YES;
    
    if([BWAppDelegate isCurrentVersionBelongToiOS7])
    {
        navController.navigationBar.tintColor=[UIColor orangeColor];
        navController.toolbar.tintColor=[UIColor orangeColor];
    }
    else
    {
    }
    
    
    double delayInSeconds = 1.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [self.locationManager startUpdatingLocation];
    });
    
    
    self.window.rootViewController = navController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    if(self.currentLocationPoint==nil)
    {
        self.currentLocationPoint = (CLLocation *)[locations lastObject];
        NSLog(@"self.currentLocationPoint = %@", self.currentLocationPoint);
    }
    else
    {
        self.currentLocationPoint = (CLLocation *)[locations lastObject];
        NSLog(@"self.currentLocationPoint = %@", self.currentLocationPoint);
    }
}

+(BOOL)isCurrentVersionBelongToiOS7
{
    return [[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending;
}

- (NSString *)getDateFromFormat:(NSString *)currFormat toFormat:(NSString *)toFormat withDate:(NSString *)strDate
{
    NSString *resultString;
    NSDateFormatter *dateFormatter  =   [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:currFormat];
    
    NSDate *yourDate =   [dateFormatter dateFromString:strDate];
    
    if(yourDate !=nil)
    {
        [dateFormatter setDateFormat:toFormat];
        resultString          =   [dateFormatter stringFromDate:yourDate];
    }
    else
    {
        resultString = strDate;
    }
    
    return resultString;
}
- (NSString *)getCurrentDate
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:dateFormatStandard];
    NSDate *now = [[NSDate alloc] init];
    
    NSString *theDate = [dateFormat stringFromDate:now];
    NSLog(@"theDate: |%@|", theDate);
    now = nil;
    dateFormat = nil;
    
    return theDate;
}

#pragma mark - Timer
- (void)startCouponTimer
{
    seconds = 5*3600;
    timerCoupon = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChanged) userInfo:nil repeats:YES];
}
- (void)stopCouponTimer
{
    if(lblTimer)
    {
        [lblTimer removeFromSuperview];
        lblTimer = nil;
    }
    if(timerCoupon && [timerCoupon isValid])
    {
        [timerCoupon invalidate];
        timerCoupon = nil;
    }
}
- (void)timeChanged
{
    --seconds;
    lblTimer.text = [NSString stringWithFormat:@"%02i:%02i:%02i", seconds/3600, (seconds%3600)/60, seconds%60];
}

#pragma mark - Reachability
- (void)checkNetworkStatus
{
    internetReach = [Reachability reachabilityForInternetConnection];
	[internetReach startNotifier];
	[self updateInterfaceWithReachability: internetReach];
    
    //if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
}

- (void) reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
 	[self updateInterfaceWithReachability: curReach];
}

- (void) updateInterfaceWithReachability: (Reachability*) curReach
{
	NetworkStatus netStatus = [curReach currentReachabilityStatus];
	switch (netStatus)
    {
		case NotReachable:
        {
            self.isNetAvailable=NO;
   			break;
		}
			
		case ReachableViaWiFi:
		{
            self.isNetAvailable=YES;
   			break;
		}
            
		case ReachableViaWWAN:
		{
            self.isNetAvailable=YES;
   			break;
		}
        default:
        {
            self.isNetAvailable=NO;
        }
	}
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
