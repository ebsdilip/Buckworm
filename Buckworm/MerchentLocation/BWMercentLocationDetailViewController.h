//
//  BWMercentLocationDetailViewController.h
//  buckworm
//
//  Created by TechSunRise on 8/5/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_Base_ViewController.h"
#import <MapKit/MapKit.h>
#import "BW_MerchentLocation_BL.h"

@interface BWMercentLocationDetailViewController : BW_Base_ViewController <BW_MerchentLocation_BL_Delegate, UITableViewDataSource, UITableViewDelegate>
{
    UIBarButtonItem *btnRoot;

    NSMutableArray *arrOffers;
    BW_MerchentLocation_BL *objMerchentLocBL;
    NSString *strImagePath;
    
    UITableView *tblOffers;
    
    UIActivityIndicatorView *indicator1;
    UIImageView *imgViewMerchant;
    NSString *strImageURL;
    NSThread *_thread1;
    
    UIView *viewBG;
}

@property(nonatomic) NSDictionary *dictLocation;
@property(nonatomic) NSString *strImageURL;
@end
