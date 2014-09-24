//
//  BW_DigitalCouponsAvailabel_TableViewCell.h
//  buckworm
//
//  Created by Developer on 8/11/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BW_DigitalCouponsAvailabel_TableViewCell : UITableViewCell
{
    NSThread *_thread1;
    UIActivityIndicatorView *indicator1;
    
    UIImageView *imgViewOffer;
    UIImageView *imgViewOfferShadow;
    UIImageView *imgViewComingSoon;
    UILabel *lblTitle;
    UILabel *lblOfferType;
    UILabel *lblBoughtTitle;
    UILabel *lblBoughtValue;
    UILabel *lblLinkedBy;
    UIImage *imgOffer;
}

@property(nonatomic) UIImageView *imgViewOffer;
@property(nonatomic) NSString *strImagePath;

- (void)setParameterAvailable:(NSDictionary *)dictOffer;
- (void)setParameterReadyToRedeem:(NSDictionary *)dictOffer;
- (void)setParameterRedeemed:(NSDictionary *)dictOffer;
- (void)showOfferImage:(NSDictionary *)dictOffer;

- (UIImage *)getImageOfCell;
//- (void)setParameterForAnonymous:(NSDictionary *)dictOffer;

@end
