//
//  BWTableViewShowAllOfferCell.m
//  Buckworm
//
//  Created by iLabours on 9/10/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BWTableViewShowAllOfferCell.h"

@implementation BWTableViewShowAllOfferCell

@synthesize imgViewOffer;
@synthesize strImagePath;
@synthesize strComingSoonImagePath;
@synthesize btnOfferList;
@synthesize arrOffers;
@synthesize isSingle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        appDelegate = (BWAppDelegate *)[UIApplication sharedApplication].delegate;
        
        imgViewStackedOffer = [[UIImageView alloc] init];
        imgViewStackedOffer.frame = CGRectMake(10, 40, 300, 120);
        imgViewStackedOffer.frame = CGRectMake(10, 0, 300, 200);
        imgViewStackedOffer.backgroundColor = [UIColor whiteColor];
        imgViewStackedOffer.layer.cornerRadius = 5.0;
        imgViewStackedOffer.layer.borderColor = [UIColor whiteColor].CGColor;
        //        imgViewStackedOffer.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"stack1" ofType:@"png"]];
        
        [self addSubview:imgViewStackedOffer];
        
        lblMerchant = [[UILabel alloc] initWithFrame:CGRectMake(20, 2, 200, 40)];
        lblMerchant.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
        lblMerchant.adjustsFontSizeToFitWidth = YES;
        lblMerchant.textColor = [UIColor darkGrayColor];
        lblMerchant.backgroundColor = [UIColor clearColor];
        [self addSubview:lblMerchant];
        
        imgViewOfferType = [[UIImageView alloc] init];
        imgViewOfferType.layer.cornerRadius = 5.0;
        imgViewOfferType.layer.borderColor = [UIColor whiteColor].CGColor;
        imgViewOfferType.frame = CGRectMake(230, 11, 20, 20);
        imgViewOfferType.backgroundColor = [UIColor clearColor];
        [self addSubview:imgViewOfferType];
        
        lblOfferTypeTitle = [[UILabel alloc] initWithFrame:CGRectMake(255, 7, 40, 30)];
        lblOfferTypeTitle.numberOfLines = 2;
        lblOfferTypeTitle.font = [UIFont boldSystemFontOfSize:9.0];
        lblOfferTypeTitle.adjustsFontSizeToFitWidth = YES;
        lblOfferTypeTitle.textColor = [UIColor darkGrayColor];
        lblOfferTypeTitle.backgroundColor = [UIColor clearColor];
        [self addSubview:lblOfferTypeTitle];
        
        imgViewOffer = [[UIImageView alloc] init];
        imgViewOffer.frame = CGRectMake(15, 40, 290, 120);
        imgViewOffer.backgroundColor = [UIColor clearColor];
        [self addSubview:imgViewOffer];
        
        imgViewOfferShadow = [[UIImageView alloc] init];
        imgViewOfferShadow.frame = CGRectMake(15, 0, 290, 160);
        imgViewOfferShadow.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"black" ofType:@"png"]];
        imgViewOfferShadow.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6];
        [self addSubview:imgViewOfferShadow];
        
        imgViewComingSoon = [[UIImageView alloc] init];
        imgViewComingSoon.frame = CGRectMake(182, 2, 125, 125);
        imgViewComingSoon.backgroundColor = [UIColor clearColor];
        imgViewComingSoon.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"comingsoon" ofType:@"png"]];
        [self addSubview:imgViewComingSoon];
        
        indicator1=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator1.hidesWhenStopped=YES;
        indicator1.center = imgViewOffer.center;
        [self addSubview:indicator1];
        [indicator1 startAnimating];
        
        lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 122, 280, 38)];
        lblTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
        lblTitle.numberOfLines = 2;
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.backgroundColor = [UIColor clearColor];
        [self addSubview:lblTitle];
        
        lblOfferType = [[UILabel alloc] initWithFrame:CGRectMake(20, 144, 200, 14)];
        lblOfferType.font = [UIFont boldSystemFontOfSize:11.0];
        lblOfferType.textColor = [UIColor lightGrayColor];
        lblOfferType.backgroundColor = [UIColor clearColor];
        [self addSubview:lblOfferType];
        
        lblOriginaPrice = [[UILabel alloc] initWithFrame:CGRectMake(20, 138, 60, 20)];
        lblOriginaPrice.font = [UIFont systemFontOfSize:15.0];
        lblOriginaPrice.textColor = [UIColor lightGrayColor];
        lblOriginaPrice.backgroundColor = [UIColor clearColor];
        [self addSubview:lblOriginaPrice];
        
        lblOfferPrice = [[UILabel alloc] initWithFrame:CGRectMake(70, 138, 80, 20)];
        lblOfferPrice.font = [UIFont boldSystemFontOfSize:15.0];
        lblOfferPrice.textColor = [UIColor whiteColor];
        lblOfferPrice.backgroundColor = [UIColor clearColor];
        [self addSubview:lblOfferPrice];
        
        lblDistence = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 180, 40)];
        lblDistence.text = @"";
        lblDistence.adjustsFontSizeToFitWidth = YES;
        lblDistence.font = [UIFont boldSystemFontOfSize:12.0];
        lblDistence.textColor = [UIColor grayColor];
        lblDistence.backgroundColor = [UIColor clearColor];
        [self addSubview:lblDistence];
        
        lblBoughtTitle = [[UILabel alloc] initWithFrame:CGRectMake(205, 160, 75, 40)];
        lblBoughtTitle.text = @"Downloaded:";
        lblBoughtTitle.textAlignment = NSTextAlignmentRight;
        lblBoughtTitle.font = [UIFont systemFontOfSize:12.0];
        lblBoughtTitle.textColor = [UIColor grayColor];
        lblBoughtTitle.backgroundColor = [UIColor clearColor];
        [self addSubview:lblBoughtTitle];
        
        lblBoughtValue = [[UILabel alloc] initWithFrame:CGRectMake(285, 160, 30, 40)];
        lblBoughtValue.textAlignment = NSTextAlignmentLeft;
        lblBoughtValue.adjustsFontSizeToFitWidth = YES;
        lblBoughtValue.font = [UIFont systemFontOfSize:12.0];
        lblBoughtValue.textColor = [UIColor blackColor];
        lblBoughtValue.backgroundColor = [UIColor clearColor];
        [self addSubview:lblBoughtValue];
        
        btnOfferList = [[UIButton alloc] initWithFrame:CGRectMake(20, 195, 170, 20)];
        [btnOfferList setTitle:@"Choose Offer" forState:UIControlStateNormal];
        [btnOfferList setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"downArrow" ofType:@"png"]] forState:UIControlStateNormal];
        btnOfferList.imageEdgeInsets = UIEdgeInsetsMake(0, 145, 0, 0);
        btnOfferList.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
        btnOfferList.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue: 0.0 alpha:0.8];
        btnOfferList.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
        btnOfferList.titleLabel.adjustsFontSizeToFitWidth = YES;
        btnOfferList.layer.borderColor = [UIColor whiteColor].CGColor;
        [btnOfferList setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnOfferList setTitleColor:[UIColor colorWithRed:1.0 green:0.5 blue: 0.0 alpha:1.0] forState:UIControlStateHighlighted];
        
    }
    return self;
}

- (void)hideAll
{
    lblOriginaPrice.hidden = YES;
    lblOfferPrice.hidden = YES;
    
    lblBoughtTitle.hidden = YES;
    lblBoughtValue.hidden = YES;
    
    lblLinkedBy.hidden = YES;
    lblLocation.hidden = YES;
    imgViewOffer.hidden = YES;
    imgViewOfferShadow.hidden = YES;
    imgViewComingSoon.hidden = YES;
    lblTitle.hidden = YES;
    lblOfferType.hidden = YES;
    
    
}
- (void)setParameter:(NSDictionary *)dictOffer
{
    
    NSArray *arrLoc = [dictOffer objectForKey:@"location"];
    if(arrLoc && [arrLoc count]>0)
    {
        //        appDelegate.currentLocationPoint.coordinate.latitude
        //        appDelegate.currentLocationPoint.coordinate.longitude
        NSDictionary *dictLoc = [arrLoc objectAtIndex:0];
        
        CLLocation *locationA = [[CLLocation alloc] initWithLatitude:appDelegate.currentLocationPoint.coordinate.latitude longitude:appDelegate.currentLocationPoint.coordinate.longitude];
        CLLocation *locationB = [[CLLocation alloc] initWithLatitude:[[dictLoc objectForKey:@"latitude"] floatValue] longitude:[[dictLoc objectForKey:@"longitude"] floatValue]];
        
        CLLocationDistance distanceInMeters = [locationA distanceFromLocation:locationB];
        int distance =(distanceInMeters/1000)* 0.62137;
        locationA = nil;
        locationB = nil;
        lblDistence.text=[NSString stringWithFormat:@"%@ • %d mi", [dictLoc objectForKey:@"city"], distance];
        
    }

    lblMerchant.text = [[dictOffer objectForKey:@"merchant"] objectForKey:@"name"];
    lblBoughtValue.text = [dictOffer objectForKey:@"downloads"];
    
    if([[dictOffer allKeys] count]==8)
    {
        lblTitle.text = [[dictOffer objectForKey:@"title"]?[dictOffer objectForKey:@"title"]:[dictOffer objectForKey:@"offer_title"]?[dictOffer objectForKey:@"offer_title"]:@"" stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        lblLocation.text = [NSString stringWithFormat:@"Location : %@", [dictOffer objectForKey:@"location"]?[dictOffer objectForKey:@"location"]:[dictOffer objectForKey:@"offer_location"]?[dictOffer objectForKey:@"offer_location"]:@""];
        lblTitle.text = [lblTitle.text stringByConvertingHTMLToPlainText];
        lblLocation.text = [lblTitle.text stringByConvertingHTMLToPlainText];
        imgViewComingSoon.hidden = NO;
    }
    else
    {
        lblTitle.text = [[dictOffer objectForKey:@"offer_title"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        
        imgViewComingSoon.hidden = YES;
        lblLocation.text = @"";
        lblLinkedBy.text = [NSString stringWithFormat:@"Available Till : %@", [appDelegate getDateFromFormat:@"yyyy-MM-dd" toFormat:dateFormatToShow withDate:[dictOffer objectForKey:@"offer_end_date"]]];
        
        [btnOfferList removeFromSuperview];
        
        NSString *strOfferType = [dictOffer objectForKey:@"offer_master_type"]?[dictOffer objectForKey:@"offer_master_type"]:@"";
        
        
        if([[strOfferType lowercaseString] isEqualToString:@"digital"])
        {
            imgViewOfferType.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"digi-coupon" ofType:@"png"]];
            imgViewOfferType.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DG_Icon" ofType:@"png"]];
            lblOfferType.text = @"Download Offer";
            lblOfferTypeTitle.text = @"Digital Coupon";
        }
        else if([[strOfferType lowercaseString] isEqualToString:@"card rebate"])
        {
            imgViewOfferType.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"direct-to-card" ofType:@"png"]];
            imgViewOfferType.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DCR_Icon" ofType:@"png"]];
            lblOfferType.text = @"Link Offer to Card";
            lblOfferTypeTitle.text = @"Direct To Card Rebate";
        }
        else if([[strOfferType lowercaseString] isEqualToString:@"purchase"])
        {
            lblTitle.frame = CGRectMake(20, 106, 280, 38);
            
            imgViewOfferType.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"purch-off" ofType:@"png"]];
            imgViewOfferType.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PO_Icon" ofType:@"png"]];
            lblOfferType.text = @"Purchase Offer";
            lblOfferType.text = @"";
            lblOfferTypeTitle.text = @"Purchase Offer";
            lblOriginaPrice.text = [dictOffer objectForKey:@"original_price"];
            lblOfferPrice.text = [dictOffer objectForKey:@"purchase_price"];
            CGSize size = [lblOriginaPrice.text sizeWithFont:lblOriginaPrice.font constrainedToSize:CGSizeMake(60, 40) lineBreakMode:NSLineBreakByWordWrapping];
            UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(20, 148, size.width, 1)];
            viewLine.backgroundColor = [UIColor whiteColor];
            [self addSubview:viewLine];
            lblOfferPrice.frame = CGRectMake(30+size.width, 138, 80, 20);
            
            //            viewLine.center = lblOfferPrice.center;
            //            lblOriginaPrice = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 60, 40)];
        }
        else if([[strOfferType lowercaseString] isEqualToString:@"wishworm"])
        {
            lblOfferType.text = [@"Wishworm Offer" uppercaseString];
            [self addSubview:btnOfferList];
        }
        else if([[strOfferType lowercaseString] isEqualToString:@"comingsoon"])
        {
            lblTitle.text = @"";
            imgViewComingSoon.hidden = NO;
            lblOfferType.text = @"";//[@"Coming Soon" uppercaseString];
            lblBoughtTitle.text = @"";
            lblBoughtValue.text = @"";
            
        }
        else
            lblOfferType.text = [strOfferType uppercaseString];
        
        lblOfferType.text = @"";
        
        lblTitle.text = [lblTitle.text stringByConvertingHTMLToPlainText];
        lblLocation.text = [lblTitle.text stringByConvertingHTMLToPlainText];
    }
    //    lblOfferTypeTitle.hidden = YES;
    //    imgViewOfferType.frame = CGRectMake(230, 4, 80, 32);
    //    imgViewOfferType.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"purchase-offer-dgray" ofType:@"png"]];
}

- (void)showOfferImage:(NSDictionary *)dictOffer
{
    if(isSingle==YES)
    {
        if([arrOffers count]>1)
        {
            float diff = [arrOffers count]*7;
            imgViewStackedOffer.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%i", [arrOffers count]] ofType:@"png"]];
            imgViewOffer.frame = CGRectMake(10, 8+diff, 306-diff, 180-diff);
            
            
        }
    }
    NSString *strImageURL;
    
    if([[dictOffer allKeys] count]==8)
        strImageURL = [NSString stringWithFormat:@"%@%@", strComingSoonImagePath, [dictOffer objectForKey:@"offer_image"]];
    else
        strImageURL = [NSString stringWithFormat:@"%@%@", strImagePath, [dictOffer objectForKey:@"offer_image"]];
    
    NSLog(@"strImageURL = %@", strImageURL);
    
    if(imgViewOffer.image==nil)
    {
        strImageURL = [strImageURL stringByReplacingOccurrencesOfString:@"\\" withString:@"%5C"];   //Replace \ by %5C
        strImageURL = [strImageURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        if([strImageURL length]>5 && [[strImageURL substringToIndex:4] isEqualToString:@"http"])
        {
            if(![indicator1 isAnimating])
                [indicator1 startAnimating];
            
            @synchronized(self) {
                if ([[NSThread currentThread] isCancelled]) return;
                
                [_thread1 cancel];	//Cell! Stop what you were doing!
                _thread1 = nil;
                imgViewOffer.image = nil;
                
                // We need to download the image, get it in a seperate thread!
                _thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(downloadImage:) object:strImageURL];
                [_thread1 start];
            }
        }
        else
        {
            if(imgViewOffer.image == nil)
            {
                imgViewOffer.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lock@2x" ofType:@"png"]];
            }
            [indicator1 stopAnimating];
        }
    }
}

- (void)downloadImage:(NSString *)strImageURL
{
    [NSThread sleepForTimeInterval:0.2]; // Why sleep? Because if we are scrolling fast the thread will be canceled and we don't want to start downloading.
    
    if (![[NSThread currentThread] isCancelled])
    {
        NSString *strImgURL = strImageURL;
        
        NSError *error = nil;
        NSURL *url = [NSURL URLWithString:strImgURL];
        UIImage *img;
        if(url)
        {
            NSData *imageData = [[NSData alloc] initWithContentsOfURL:url options:3 error:&error];
            if(!error){
                img = [UIImage imageWithData:imageData];
                if(img)
                {
                    imgViewOffer.image = img;
                }
                else
                    imgViewOffer.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lock@2x" ofType:@"png"]];
            }
            else {
                img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lock@2x" ofType:@"png"]];
            }
            imageData = nil;
            url = nil;
        }
        else {
            img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lock@2x" ofType:@"png"]];
        }
        @synchronized(self) {
            if (![[NSThread currentThread] isCancelled]) {
                imgViewOffer.image = img;
                [indicator1 stopAnimating];
            }
        }
        img = nil;
        strImgURL = nil;
    }
}

- (UIImage *)getImageOfCell
{
    return imgViewOffer.image;
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
