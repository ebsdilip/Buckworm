//
//  BW_MerchantLocationOffer_TableViewCell.m
//  buckworm
//
//  Created by Developer on 8/6/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_MerchantLocationOffer_TableViewCell.h"

@implementation BW_MerchantLocationOffer_TableViewCell

@synthesize strImagePath;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UIImageView *imgViewOfferShadow = [[UIImageView alloc] init];
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
        
        indicator1=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator1.hidesWhenStopped=YES;
        indicator1.center = imgViewOffer.center;
        [self addSubview:indicator1];
        [indicator1 startAnimating];

        lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 280, 40)];
        lblTitle.font = [UIFont boldSystemFontOfSize:16.0];
        lblTitle.numberOfLines = 2;
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.backgroundColor = [UIColor clearColor];
        [self addSubview:lblTitle];
        
        lblSubTitle = [[UILabel alloc] initWithFrame:CGRectMake(120, 25, 170, 50)];
        lblSubTitle.font = [UIFont systemFontOfSize:14.0];
        lblSubTitle.numberOfLines = 9;
        lblSubTitle.textColor = [UIColor darkGrayColor];
        lblSubTitle.backgroundColor = [UIColor clearColor];
//        [self addSubview:lblSubTitle];

        lblBoughtTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 190, 280, 16)];
        lblBoughtTitle.text = @"Available till";
        lblBoughtTitle.textAlignment = NSTextAlignmentRight;
        lblBoughtTitle.font = [UIFont systemFontOfSize:12.0];
        lblBoughtTitle.textColor = [UIColor grayColor];
        lblBoughtTitle.backgroundColor = [UIColor clearColor];
        [self addSubview:lblBoughtTitle];
        
        lblBoughtValue = [[UILabel alloc] initWithFrame:CGRectMake(20, 206, 280, 16)];
        lblBoughtValue.textAlignment = NSTextAlignmentRight;
        lblBoughtValue.font = [UIFont systemFontOfSize:12.0];
        lblBoughtValue.textColor = [UIColor blackColor];
        lblBoughtValue.backgroundColor = [UIColor clearColor];
        [self addSubview:lblBoughtValue];
        
    }
    return self;
}

- (void)setParameter:(NSDictionary *)dictOffer
{
    lblTitle.text = [dictOffer objectForKey:@"offer_description"];
    lblSubTitle.text = [dictOffer objectForKey:@"offer_description"];
    lblBoughtValue.text = [NSString stringWithFormat:@"%@", [dictOffer objectForKey:@"offer_end_date"]];
//
    NSString *strImageURL = [NSString stringWithFormat:@"%@/%@", strImagePath, [dictOffer objectForKey:@"offer_image"]];
    if(imgOffer==nil)
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
                imgOffer = nil;
                
                // We need to download the image, get it in a seperate thread!
                _thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(downloadImage:) object:strImageURL];
                [_thread1 start];
            }
        }
        else
        {
            if(imgOffer == nil)
            {
                imgOffer = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lock@2x" ofType:@"png"]];
                imgViewOffer.image=imgOffer;
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
