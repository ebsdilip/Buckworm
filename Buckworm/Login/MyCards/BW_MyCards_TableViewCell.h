//
//  BW_MyCards_TableViewCell.h
//  buckworm
//
//  Created by Developer on 6/11/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BW_MyCards_TableViewCell : UITableViewCell
{
    UIImageView *imgViewChecked;
    UILabel *lblNickname;
    UILabel *lblNicknameValue;
    UILabel *lblCardType;
    UILabel *lblAccNumber;
    UILabel *lblAccNumberValue;
    UILabel *lblCardCrOrDr;
    UILabel *lblDefaultCard;
}

@property(nonatomic) UIImageView *imgViewChecked;

- (void)setParameter:(NSDictionary *)dictCard;

@end
