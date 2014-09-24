//
//  CustomMKAnnotationView.h
//  Buckworm
//
//  Created by iLabours on 9/8/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class BWMerchentLocationViewController;
@interface CustomMKAnnotationView : MKAnnotationView
{
//    UIButton *btnMap;
    UIActivityIndicatorView *indicator1;
    NSThread *_thread1;
}
@property(nonatomic) NSString *strImagePath;
@property(nonatomic) BWMerchentLocationViewController *callBack;

- (void)showImage:(NSString *)strImageUrl;

@end
