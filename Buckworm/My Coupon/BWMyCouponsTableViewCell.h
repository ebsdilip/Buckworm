//
//  BWMyCouponsTableViewCell.h
//  Buckworm
//
//  Created by iLabours on 8/30/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BWAppDelegate;
@interface BWMyCouponsTableViewCell : UITableViewCell
{
    BWAppDelegate *appDelegate;
    NSThread *_thread1;
    UIActivityIndicatorView *indicator1;
    UIActivityIndicatorView *indicator2;
    
    UIImageView *imgViewStackedOffer;
    UIImageView *imgViewOfferType;
    UILabel *lblMerchant;
    UILabel *lblOfferTypeTitle;
    UILabel *lblOriginaPrice;
    UILabel *lblOfferPrice;
    UILabel *lblDistence;
    
    UIImageView *imgViewOffer;
    UIImageView *imgViewOfferLogo;
    UIImageView *imgViewOfferShadow;
    UIImageView *imgViewComingSoon;
    UILabel *lblTitle;
    UILabel *lblOfferType;

    UIImageView *imgViewBottomBG;
    UILabel *lblBoughtTitle;
    UILabel *lblBoughtValue;
    UILabel *lblAvailableTitle;
    UILabel *lblAvailableValue;
    UILabel *lblRedeemByTitle;
    UILabel *lblRedeemByValue;
    
    UILabel *lblLinkedBy;
    UIImage *imgOffer;
}

@property(nonatomic) UIImageView *imgViewOffer;
@property(nonatomic) NSString *strImagePath;

- (void)setParameterAvailable:(NSDictionary *)dictOffer;
- (void)setParameterReadyToRedeem:(NSDictionary *)dictOffer;
- (void)setParameterRedeemed:(NSDictionary *)dictOffer;
- (void)setParameterExpired:(NSDictionary *)dictOffer;
- (void)showOfferImage:(NSDictionary *)dictOffer;

- (UIImage *)getImageOfCell;
- (void)hideAll;

@end
