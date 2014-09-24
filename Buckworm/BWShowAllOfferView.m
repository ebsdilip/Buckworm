//
//  BWShowAllOfferView.m
//  Buckworm
//
//  Created by iLabours on 9/10/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BWShowAllOfferView.h"
#import "BWTableViewShowAllOfferCell.h"
#import "BWOfferDetailViewController.h"

@implementation BWShowAllOfferView

@synthesize arrOffers;
@synthesize strImagePath;
@synthesize lblHeaderTitle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
        viewHeader.backgroundColor = colorGreen;
        [self addSubview:viewHeader];
        
        UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 22, 40, 40)];
        btnBack.backgroundColor = [UIColor clearColor];
        [btnBack setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon-arrow" ofType:@"png"]] forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnBack];
        btnBack = nil;
        
        lblHeaderTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 200, 40)];
        lblHeaderTitle.textAlignment = NSTextAlignmentCenter;
//        lblHeaderTitle.text = [[[dictMerchant objectForKey:@"business_name"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"] stringByConvertingHTMLToPlainText];
        lblHeaderTitle.font = [UIFont boldSystemFontOfSize:16.0];
        lblHeaderTitle.numberOfLines = 2;
        lblHeaderTitle.textColor = [UIColor whiteColor];
        lblHeaderTitle.backgroundColor = [UIColor clearColor];
        [self addSubview:lblHeaderTitle];

        tblOffers = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, IS_IPHONE_5?504:416) style:UITableViewStyleGrouped];
        tblOffers.dataSource = self;
        tblOffers.delegate = self;
        tblOffers.separatorStyle = UITableViewCellSeparatorStyleNone;
        tblOffers.backgroundColor = colorTableBG;
        [self addSubview:tblOffers];
    }
    return self;
}

- (void)goBack
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:nil];
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    self.frame = CGRectMake(0, 600, 320, 568);
    [UIView commitAnimations];
}
- (void)animationFinished
{
    [self removeFromSuperview];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}

#pragma mark TableView Delegate Datasource Methods
#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrOffers count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    viewHeader.backgroundColor = colorLightGrayForBG;
    //    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 20)];
    //    lblTitle.font = [UIFont systemFontOfSize:14.0];
    //    lblTitle.textColor = [UIColor darkGrayColor];
    //    lblTitle.backgroundColor = [UIColor clearColor];
    //    if([arrOffers count]>1)
    //        lblTitle.text = [NSString stringWithFormat:@"%i Offers available", [arrOffers count]];
    //    else if([arrOffers count]==1)
    //        lblTitle.text = [NSString stringWithFormat:@"%i Offer available", [arrOffers count]];
    //    else
    //        lblTitle.text = @"Offers not found!";
    //    [viewHeader addSubview:lblTitle];
    
    return viewHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    viewHeader.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1.0];
    
    return viewHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictOffer = [arrOffers objectAtIndex:indexPath.row];
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Offer %@", [dictOffer objectForKey:@"id"]];

    BWTableViewShowAllOfferCell *cell = (BWTableViewShowAllOfferCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        @autoreleasepool {
            cell = [[BWTableViewShowAllOfferCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.strImagePath = strImagePath;
        }
    }
    
    [cell setParameter:dictOffer];
    cell.backgroundColor = colorTableBG;

    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dictOffer = [arrOffers objectAtIndex:indexPath.row];
    NSString *strOfferType = [dictOffer objectForKey:@"offer_master_type"]?[dictOffer objectForKey:@"offer_master_type"]:@"";
    
    if([[strOfferType lowercaseString] isEqualToString:@"digital"] || [[strOfferType lowercaseString] isEqualToString:@"card rebate"] || [[strOfferType lowercaseString] isEqualToString:@"purchase"])
    {
        [self goBack];
        BWTableViewShowAllOfferCell *cell = (BWTableViewShowAllOfferCell *)[tableView cellForRowAtIndexPath:indexPath];
        BWOfferDetailViewController *objVC = [[BWOfferDetailViewController alloc] init];
        objVC.strImagePath = strImagePath;
        objVC.dictOffer = dictOffer;
        objVC.intType = Digital;
        objVC.intStatus = tagAvailable;
        objVC.imageOffer = [cell getImageOfCell];
        BWAppDelegate *appDelegate = (BWAppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate.navController pushViewController:objVC animated:YES];
        objVC = nil;
    }
    else if([[strOfferType lowercaseString] isEqualToString:@"comingsoon"])
    {
        //            imgViewComingSoon.hidden = NO;
        //            lblOfferType.text = @"Coming Soon";
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictOffer = [arrOffers objectAtIndex:indexPath.row];
    [(BWTableViewShowAllOfferCell *)cell showOfferImage:dictOffer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
