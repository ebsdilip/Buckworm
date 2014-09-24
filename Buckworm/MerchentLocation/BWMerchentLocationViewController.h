//
//  BWMerchentLocationViewController.h
//  buckworm
//
//  Created by TechSunRise on 8/5/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_Base_ViewController.h"
#import <MapKit/MapKit.h>
#import "BW_MerchentLocation_BL.h"

@interface BWMerchentLocationViewController : BW_Base_ViewController<UITextFieldDelegate, MKMapViewDelegate, BW_MerchentLocation_BL_Delegate, CLLocationManagerDelegate>
{
    BW_MerchentLocation_BL *objMerchentLocBL;
    MKMapView *_mapView;
    NSMutableArray *arrBackUp;
    NSMutableArray *arrLocations;
    NSMutableArray *arrComingSoon;
    
    NSThread *_thread1;
    UIActivityIndicatorView *indicator1;
    int lastAnnotationSelected;
    BOOL IsLOGO;
    NSInteger intMapType;
    
    UIButton *btnViewLogo;
    UIButton *btnViewOffer;
    NSString *strImagePathL;
    NSString *strImagePathO;
    UISegmentedControl *segmentedControl;
    
    UIButton *btnRedoSearch;
    UIButton *btnRedPins;
    UIImageView *imgViewSearchBG;
    UITextField *txtFieldSearch;
    UIButton *btnSearch;
    
    NSMutableArray *arrPins;
}

//@property (nonatomic, retain) CLLocationManager *locationManager;
//@property (nonatomic, retain) CLLocation *currentLocationPoint;

- (void)clearMemory;

@end
