//
//  BW_DigitalCouponsAvailabel_TableViewCell.m
//  buckworm
//
//  Created by Developer on 8/11/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_DigitalCouponsAvailabel_TableViewCell.h"
#import "BWAppDelegate.h"

@implementation BW_DigitalCouponsAvailabel_TableViewCell

@synthesize imgViewOffer;
@synthesize strImagePath;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        imgViewOfferShadow = [[UIImageView alloc] init];
        imgViewOfferShadow.frame = CGRectMake(10, 178, 300, 50);
        imgViewOfferShadow.backgroundColor = [UIColor clearColor];
        imgViewOfferShadow.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"white" ofType:@"png"]];
        [self addSubview:imgViewOfferShadow];
        imgViewOfferShadow = nil;
        
        imgViewOffer = [[UIImageView alloc] init];
        imgViewOffer.frame = CGRectMake(10, 10, 300, 180);
        imgViewOffer.backgroundColor = [UIColor clearColor];
        imgViewOffer.layer.borderWidth = 1.0;
        imgViewOffer.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self addSubview:imgViewOffer];
        
        imgViewOfferShadow = [[UIImageView alloc] init];
        imgViewOfferShadow.frame = CGRectMake(10, 10, 300, 180);
        imgViewOfferShadow.backgroundColor = [UIColor clearColor];
        imgViewOfferShadow.layer.borderWidth = 1.0;
        imgViewOfferShadow.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"black" ofType:@"png"]];
        imgViewOfferShadow.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self addSubview:imgViewOfferShadow];
        
        imgViewComingSoon = [[UIImageView alloc] init];
        imgViewComingSoon.frame = CGRectMake(10, 10, 65, 65);
        imgViewComingSoon.backgroundColor = [UIColor clearColor];
        imgViewComingSoon.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"coming_soon_label" ofType:@"png"]];
        [self addSubview:imgViewComingSoon];
        
        indicator1=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator1.hidesWhenStopped=YES;
        indicator1.center = imgViewOffer.center;
        [self addSubview:indicator1];
        [indicator1 startAnimating];
        
        lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, 280, 40)];
        lblTitle.font = [UIFont boldSystemFontOfSize:16.0];
        lblTitle.numberOfLines = 2;
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.backgroundColor = [UIColor clearColor];
        [self addSubview:lblTitle];
        
        lblOfferType = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, 280, 16)];
        lblOfferType.font = [UIFont boldSystemFontOfSize:10.0];
        lblOfferType.textColor = [UIColor lightGrayColor];
        lblOfferType.backgroundColor = [UIColor clearColor];
        [self addSubview:lblOfferType];
        
        
//        lblOriginaPrice = [[UILabel alloc] initWithFrame:CGRectMake(20, 190, 60, 32)];
//        lblOriginaPrice.font = [UIFont systemFontOfSize:15.0];
//        lblOriginaPrice.textColor = [UIColor grayColor];
//        lblOriginaPrice.backgroundColor = [UIColor clearColor];
//        [self addSubview:lblOriginaPrice];
//        
//        lblOfferPrice = [[UILabel alloc] initWithFrame:CGRectMake(70, 190, 80, 32)];
//        lblOfferPrice.font = [UIFont boldSystemFontOfSize:15.0];
//        lblOfferPrice.textColor = colorGreen;
//        lblOfferPrice.backgroundColor = [UIColor clearColor];
//        [self addSubview:lblOfferPrice];
//        
//        
        lblBoughtTitle = [[UILabel alloc] initWithFrame:CGRectMake(230, 190, 70, 16)];
        lblBoughtTitle.text = @"Download";
        lblBoughtTitle.textAlignment = NSTextAlignmentRight;
        lblBoughtTitle.font = [UIFont systemFontOfSize:12.0];
        lblBoughtTitle.textColor = [UIColor lightGrayColor];
        lblBoughtTitle.backgroundColor = [UIColor clearColor];
        [self addSubview:lblBoughtTitle];
        
        lblBoughtValue = [[UILabel alloc] initWithFrame:CGRectMake(230, 206, 70, 16)];
        lblBoughtValue.textAlignment = NSTextAlignmentRight;
        lblBoughtValue.font = [UIFont systemFontOfSize:12.0];
        lblBoughtValue.textColor = [UIColor blackColor];
        lblBoughtValue.backgroundColor = [UIColor clearColor];
        [self addSubview:lblBoughtValue];
        /*
        imgViewOffer = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 100, 90)];
        imgViewOffer.backgroundColor = [UIColor clearColor];
        imgViewOffer.layer.borderWidth = 1.0;
        imgViewOffer.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self addSubview:imgViewOffer];
        
        indicator1=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator1.hidesWhenStopped=YES;
        indicator1.center = imgViewOffer.center;
        [self addSubview:indicator1];
        [indicator1 startAnimating];
        
        lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(120, 5, 170, 70)];
        lblTitle.font = [UIFont boldSystemFontOfSize:14.0];
        lblTitle.numberOfLines = 4;
        lblTitle.textColor = [UIColor darkGrayColor];
        lblTitle.backgroundColor = [UIColor clearColor];
        [self addSubview:lblTitle];
        
        lblLinkedBy = [[UILabel alloc] initWithFrame:CGRectMake(120, 75, 170, 20)];
        lblLinkedBy.font = [UIFont systemFontOfSize:14.0];
        lblLinkedBy.adjustsFontSizeToFitWidth = YES;
        lblLinkedBy.textColor = [UIColor darkGrayColor];
        lblLinkedBy.backgroundColor = [UIColor clearColor];
        [self addSubview:lblLinkedBy];
        */
    }
    return self;
}

- (void)setParameterAvailable:(NSDictionary *)dictOffer;
{
    BWAppDelegate *appDelegate = (BWAppDelegate *)[UIApplication sharedApplication].delegate;
    
    lblTitle.text = [[dictOffer objectForKey:@"offer_title"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    lblTitle.text = [[dictOffer objectForKey:@"offer_description"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    
    lblLinkedBy.text = [NSString stringWithFormat:@"Available Till: %@",[appDelegate getDateFromFormat:@"yyyy-MM-dd" toFormat:dateFormatToShow withDate:[dictOffer objectForKey:@"offer_end_date"]]];
}

- (void)setParameterReadyToRedeem:(NSDictionary *)dictOffer
{
    BWAppDelegate *appDelegate = (BWAppDelegate *)[UIApplication sharedApplication].delegate;
    
    lblTitle.text = [[dictOffer objectForKey:@"offer_title"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    lblTitle.text = [[dictOffer objectForKey:@"offer_description"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    
    lblLinkedBy.text = [NSString stringWithFormat:@"Redeem by : %@",[appDelegate getDateFromFormat:@"yyyy-MM-dd" toFormat:dateFormatToShow withDate:[dictOffer objectForKey:@"redemption_end_date"]]];
    
}

- (void)setParameterRedeemed:(NSDictionary *)dictOffer
{
    BWAppDelegate *appDelegate = (BWAppDelegate *)[UIApplication sharedApplication].delegate;
    
    lblTitle.text = [[dictOffer objectForKey:@"offer_title"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    lblTitle.text = [[dictOffer objectForKey:@"offer_description"] stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        
    NSString *strRedDate = [dictOffer objectForKey:@"redeem_date"];
    if(strRedDate && [strRedDate length]>0)
    {
        NSArray *arrTemp = [strRedDate componentsSeparatedByString:@" "];
        NSString *strStartDate = [arrTemp count]>0?[arrTemp objectAtIndex:0]:[strRedDate substringToIndex:10];
        lblLinkedBy.text = [NSString stringWithFormat:@"Redeemed On: %@",[appDelegate getDateFromFormat:@"yyyy-MM-dd" toFormat:dateFormatToShow withDate:strStartDate]];
    }
}

- (void)showOfferImage:(NSDictionary *)dictOffer
{
    NSString *strImageURL = [NSString stringWithFormat:@"%@%@", strImagePath, [dictOffer objectForKey:@"offer_image"]];
    
//    strImageURL = @"http://buckworm.com/uploads/shopworm_image/1405424099_gimmeaburger.png";
    
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
                    imgViewOffer.image = img;
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
