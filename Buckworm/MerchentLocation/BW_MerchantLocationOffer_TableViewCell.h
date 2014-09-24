//
//  BW_MerchantLocationOffer_TableViewCell.h
//  buckworm
//
//  Created by Developer on 8/6/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BW_MerchantLocationOffer_TableViewCell : UITableViewCell
{
    NSString *strImagePath;

    NSThread *_thread1;
    UIActivityIndicatorView *indicator1;
    
    UIImageView *imgViewOffer;

    UILabel *lblTitle;
    UILabel *lblSubTitle;
    UILabel *lblBoughtTitle;
    UILabel *lblBoughtValue;
    
    UIImage *imgOffer;
}

@property(nonatomic) NSString *strImagePath;

- (void)setParameter:(NSDictionary *)dictOffer;
- (UIImage *)getImageOfCell;

@end
