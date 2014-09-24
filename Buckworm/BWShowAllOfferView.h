//
//  BWShowAllOfferView.h
//  Buckworm
//
//  Created by iLabours on 9/10/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BWShowAllOfferView : UIView <UITableViewDelegate, UITableViewDataSource>
{
    UILabel *lblHeaderTitle;
    UITableView *tblOffers;
    NSMutableArray *arrOffers;
    NSString *strImagePath;
}
@property(nonatomic) UILabel *lblHeaderTitle;
@property(nonatomic) NSMutableArray *arrOffers;
@property(nonatomic) NSString *strImagePath;
@end
