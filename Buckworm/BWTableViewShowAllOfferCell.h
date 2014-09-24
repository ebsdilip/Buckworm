//
//  BWTableViewShowAllOfferCell.h
//  Buckworm
//
//  Created by iLabours on 9/10/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BWAppDelegate;
@interface BWTableViewShowAllOfferCell : UITableViewCell
{
    BWAppDelegate *appDelegate;
    NSThread *_thread1;
    UIActivityIndicatorView *indicator1;
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
    
    UILabel *lblMerchant;
    UIImageView *imgViewOfferType;
    UILabel *lblOfferTypeTitle;
    UILabel *lblDistence;
    BOOL isSingle;
}

@property(nonatomic) UIImageView *imgViewOffer;
@property(nonatomic) NSString *strImagePath;
@property(nonatomic) NSString *strComingSoonImagePath;
@property(nonatomic) UIButton *btnOfferList;
@property(nonatomic) NSMutableArray *arrOffers;
@property(nonatomic) BOOL isSingle;

- (void)setParameter:(NSDictionary *)dictOffer;
- (void)showOfferImage:(NSDictionary *)dictOffer;
- (UIImage *)getImageOfCell;
- (void)hideAll;
@end

