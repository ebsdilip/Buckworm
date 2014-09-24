//
//  TechSunRiseMKAnnotation.m
//  MKMapViewDirection
//
//  Created by TechSunRise on 6/19/13.
//  Copyright (c) 2013 techSunRise. All rights reserved.
//

#import "TechSunRiseMKAnnotation.h"

@implementation TechSunRiseMKAnnotation

@synthesize coordinate,title,subtitle,strImageUrlLogo, strImageUrlOffer,imageForMyAnnotation;
@synthesize strText;

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)showImageForComingSoon
{
    if(imageForMyAnnotation==nil)
    {
        strImageUrlOffer = [strImageUrlOffer stringByReplacingOccurrencesOfString:@"\\" withString:@"%5C"];   //Replace \ by %5C
        strImageUrlOffer = [strImageUrlOffer stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        if([strImageUrlOffer length]>5 && [[strImageUrlOffer substringToIndex:4] isEqualToString:@"http"])
        {
            @synchronized(self) {
                if ([[NSThread currentThread] isCancelled]) return;
                
                [_thread1 cancel];	//Cell! Stop what you were doing!
                _thread1 = nil;
                imageForMyAnnotation = nil;
                
                // We need to download the image, get it in a seperate thread!
                _thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(downloadImage:) object:strImageUrlOffer];
                [_thread1 start];
            }
        }
        else
        {
            if(imageForMyAnnotation == nil)
            {
                imageForMyAnnotation = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"lock@2x" ofType:@"png"]];
            }
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
                    imageForMyAnnotation = img;
                else
                    imageForMyAnnotation = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mapIcon" ofType:@"png"]];
            }
            else {
                imageForMyAnnotation = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mapIcon" ofType:@"png"]];
            }
            imageData = nil;
            url = nil;
        }
        else {
            img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mapIcon" ofType:@"png"]];
        }
        @synchronized(self) {
            if (![[NSThread currentThread] isCancelled]) {
                imageForMyAnnotation = img;
            }
        }
        img = nil;
        strImgURL = nil;
    }
}
@end
