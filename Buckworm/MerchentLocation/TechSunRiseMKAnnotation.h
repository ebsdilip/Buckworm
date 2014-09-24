//
//  TechSunRiseMKAnnotation.h
//  MKMapViewDirection
//
//  Created by TechSunRise on 6/19/13.
//  Copyright (c) 2013 techSunRise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface TechSunRiseMKAnnotation : NSObject<MKAnnotation>
{    
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subtitle;
    NSThread *_thread1;
}
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *strImageUrlLogo;
@property (nonatomic, copy) NSString *strImageUrlOffer;
@property (nonatomic, retain) UIImage *imageForMyAnnotation;
@property (nonatomic, copy) NSString *strText;
- (void)showImageForComingSoon;

@end
