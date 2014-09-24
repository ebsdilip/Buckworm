//
//  BW_MyCards_TableViewCell.m
//  buckworm
//
//  Created by Developer on 6/11/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_MyCards_TableViewCell.h"

@implementation BW_MyCards_TableViewCell

@synthesize imgViewChecked;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        imgViewChecked = [[UIImageView alloc] initWithFrame:CGRectMake(250, 10, 30, 30)];
        imgViewChecked.backgroundColor = [UIColor clearColor];
        imgViewChecked.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Check-icon" ofType:@"png"]];
        [self addSubview:imgViewChecked];

        UIColor *colorText = [UIColor darkGrayColor];
        lblNickname = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 90, 24)];
        lblNickname.text = @"Nickname : ";
        lblNickname.textAlignment = NSTextAlignmentLeft;
        lblNickname.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
        lblNickname.adjustsFontSizeToFitWidth = YES;
        lblNickname.textColor = colorText;
        lblNickname.backgroundColor = [UIColor clearColor];
        [self addSubview:lblNickname];
        
        lblNicknameValue = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, 100, 24)];
        lblNicknameValue.textAlignment = NSTextAlignmentLeft;
        lblNicknameValue.font = [UIFont fontWithName:@"Arial" size:16];
        lblNicknameValue.adjustsFontSizeToFitWidth = YES;
        lblNicknameValue.textColor = colorText;
        lblNicknameValue.backgroundColor = [UIColor clearColor];
        [self addSubview:lblNicknameValue];
        
        UIView *viewSep = [[UIView alloc] initWithFrame:CGRectMake(15, 44, 275, 1)];
        viewSep.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:viewSep];
        viewSep = nil;
        
        lblCardType = [[UILabel alloc] initWithFrame:CGRectMake(20, 54, 280, 24)];
        lblCardType.textAlignment = NSTextAlignmentLeft;
        lblCardType.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
        lblCardType.adjustsFontSizeToFitWidth = YES;
        lblCardType.textColor = colorText;
        lblCardType.backgroundColor = [UIColor clearColor];
        [self addSubview:lblCardType];

        lblAccNumber = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 150, 24)];
        lblAccNumber.text = @"Masked Account Number : ";
        lblAccNumber.textAlignment = NSTextAlignmentLeft;
        lblAccNumber.font = [UIFont fontWithName:@"Arial" size:12];
        lblAccNumber.adjustsFontSizeToFitWidth = YES;
        lblAccNumber.textColor = colorText;
        lblAccNumber.backgroundColor = [UIColor clearColor];
        [self addSubview:lblAccNumber];

        lblAccNumberValue = [[UILabel alloc] initWithFrame:CGRectMake(170, 80, 130, 24)];
        lblAccNumberValue.textAlignment = NSTextAlignmentLeft;
        lblAccNumberValue.font = [UIFont fontWithName:@"Arial-BoldMT" size:12];
        lblAccNumberValue.adjustsFontSizeToFitWidth = YES;
        lblAccNumberValue.textColor = colorText;
        lblAccNumberValue.backgroundColor = [UIColor clearColor];
        [self addSubview:lblAccNumberValue];

        viewSep = [[UIView alloc] initWithFrame:CGRectMake(15, 106, 275, 1)];
        viewSep.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:viewSep];
        viewSep = nil;

        lblCardCrOrDr = [[UILabel alloc] initWithFrame:CGRectMake(20, 116, 60, 24)];
        lblCardCrOrDr.layer.cornerRadius = 5.0;
        lblCardCrOrDr.shadowOffset = CGSizeMake(1, 1);
        lblCardCrOrDr.shadowColor = [UIColor grayColor];
        lblCardCrOrDr.textAlignment = NSTextAlignmentCenter;
        lblCardCrOrDr.font = [UIFont fontWithName:@"Arial-BoldMT" size:12];
        lblCardCrOrDr.adjustsFontSizeToFitWidth = YES;
        lblCardCrOrDr.textColor = [UIColor whiteColor];
        lblCardCrOrDr.backgroundColor = [UIColor orangeColor];
        [self addSubview:lblCardCrOrDr];
        
        lblDefaultCard = [[UILabel alloc] initWithFrame:CGRectMake(160, 116, 110, 24)];
        lblDefaultCard.textAlignment = NSTextAlignmentRight;
        lblDefaultCard.font = [UIFont fontWithName:@"Arial-BoldMT" size:12];
        lblDefaultCard.adjustsFontSizeToFitWidth = YES;
        lblDefaultCard.textColor = colorText;
        lblDefaultCard.backgroundColor = [UIColor clearColor];
        [self addSubview:lblDefaultCard];

    }
    return self;
}

- (void)setParameter:(NSDictionary *)dictCard
{
    lblCardType.text = [dictCard objectForKey:@"financialInstitutionName"];
    lblNicknameValue.text = [dictCard objectForKey:@"accountNickName"];
    lblAccNumberValue.text = [dictCard objectForKey:@"maskedAccountNumber"];
    lblCardCrOrDr.text = [[dictCard objectForKey:@"accountType"] stringByReplacingOccurrencesOfString:@"CARD" withString:@""];
    if([dictCard objectForKey:@"defaultAccount"])
        lblDefaultCard.text = @"My default card";
    else
        lblDefaultCard.text = @"";
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
