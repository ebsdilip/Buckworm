//
//  BWMapAddressViewController.h
//  Buckworm
//
//  Created by iLabours on 8/28/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface BWMapAddressViewController : UIViewController
{
    MKMapView *_mapView;
}
@property(nonatomic, strong) NSString *strTitle;
@property(nonatomic) NSDictionary *dictLocation;
@end
