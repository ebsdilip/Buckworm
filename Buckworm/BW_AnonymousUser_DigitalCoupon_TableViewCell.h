//
//  BW_AnonymousUser_DigitalCoupon_TableViewCell.h
//  buckworm
//
//  Created by Developer on 8/12/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BWShowAllOfferView.h"

@class BWAppDelegate;
@interface BW_AnonymousUser_DigitalCoupon_TableViewCell : UITableViewCell
{
    BWAppDelegate *appDelegate;
    BWShowAllOfferView *viewAllOffer;
    
    NSThread *_thread1;
    UIActivityIndicatorView *indicator1;

    UILabel *lblMerchant;
    UIImageView *imgViewOfferType;
    UILabel *lblOfferTypeTitle;
    UILabel *lblDistence;
    
    UIImageView *imgViewStackedOffer;
    UIImageView *imgViewOffer;
    UIImageView *imgViewOfferShadow;
    UIImageView *imgViewComingSoon;
    UILabel *lblTitle;
    UILabel *lblOfferType;
    
    UILabel *lblOriginaPrice;
    UILabel *lblOfferPrice;
    
    UILabel *lblBoughtTitle;
    UILabel *lblBoughtValue;
    
    UILabel *lblLinkedBy;
    UILabel *lblLocation;
    UIImage *imgOffer;
    
    UIButton *btnOfferList;
    UIButton *btnViewAllOffers;
    
    BOOL isSingle;
}

@property(nonatomic) UIImageView *imgViewOffer;
@property(nonatomic) NSString *strImagePath;
@property(nonatomic) NSString *strComingSoonImagePath;
@property(nonatomic) UIButton *btnOfferList;
@property(nonatomic) UIButton *btnViewAllOffers;
@property(nonatomic) NSMutableArray *arrOffers;
@property(nonatomic) BOOL isSingle;

- (void)setParameter:(NSDictionary *)dictOffer;
- (void)showOfferImage:(NSDictionary *)dictOffer;

- (UIImage *)getImageOfCell;
- (void)hideAll;
@end
