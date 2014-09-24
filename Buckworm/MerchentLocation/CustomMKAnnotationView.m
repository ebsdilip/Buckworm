//
//  CustomMKAnnotationView.m
//  Buckworm
//
//  Created by iLabours on 9/8/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "CustomMKAnnotationView.h"
#import "BWMerchentLocationViewController.h"
#import "ImageStore.h"

@implementation CustomMKAnnotationView

@synthesize strImagePath;
@synthesize callBack;

- (void)annotationClicked:(UIButton *)sender
{
    
}

- (void)showImage:(NSString *)strImageUrl
{
    NSLog(@"strImageUrl = %@", strImageUrl);
//    btnMap = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 62, 72)];
//    [btnMap addTarget:self action:@selector(annotationClicked:) forControlEvents:UIControlEventTouchUpInside];
//    btnMap.backgroundColor = [UIColor clearColor];
//    [self addSubview:btnMap];
    
    indicator1=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator1.hidesWhenStopped=YES;
    indicator1.center = self.center;
    [self addSubview:indicator1];
    [indicator1 startAnimating];

    if(self.image==nil)
    {
        strImageUrl = [strImageUrl stringByReplacingOccurrencesOfString:@"\\" withString:@"%5C"];   //Replace \ by %5C
        strImageUrl = [strImageUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        if([strImageUrl length]>5 && [[strImageUrl substringToIndex:4] isEqualToString:@"http"])
        {
            if(![indicator1 isAnimating])
                [indicator1 startAnimating];

            @synchronized(self) {
                if ([[NSThread currentThread] isCancelled]) return;
                
                [_thread1 cancel];	//Cell! Stop what you were doing!
                _thread1 = nil;
                self.image = nil;
//                [btnMap setImage:nil forState:UIControlStateNormal];

                NSString *strImgName = [strImageUrl stringByReplacingOccurrencesOfString:strImagePath withString:@""];

                if ([ImageStore isImageExistsWithNameInDirctory:strImgName])
                {
                    self.image = [ImageStore returnImageWithName:strImgName];
                    [indicator1 stopAnimating];
                }
                else
                {
                // We need to download the image, get it in a seperate thread!
                _thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(downloadImage:) object:strImageUrl];
                [_thread1 start];
                }
            }
        }
        else
        {
            if(self.image==nil)
            {
                self.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pinBlack" ofType:@"png"]];
//                [btnMap setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pinBlack" ofType:@"png"]] forState:UIControlStateNormal];
            }
            [indicator1 stopAnimating];
            [indicator1 removeFromSuperview];
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
                    NSString *strImgName = [strImgURL stringByReplacingOccurrencesOfString:strImagePath withString:@""];
					[ImageStore saveImageWithData:imageData withImageName:strImgName];
                    self.image = img;
//                    [btnMap setImage:img forState:UIControlStateNormal];
                }
                else
                {
                    self.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pinBlack" ofType:@"png"]];
//                    [btnMap setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pinBlack" ofType:@"png"]] forState:UIControlStateNormal];
                }
            }
            else {
                self.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pinBlack" ofType:@"png"]];
//                [btnMap setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pinBlack" ofType:@"png"]] forState:UIControlStateNormal];
            }
            imageData = nil;
            url = nil;
        }
        else {
            img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pinBlack" ofType:@"png"]];
        }
        @synchronized(self) {
            if (![[NSThread currentThread] isCancelled]) {
                self.image = img;
//                [btnMap setImage:img forState:UIControlStateNormal];
                [indicator1 stopAnimating];
                [indicator1 removeFromSuperview];
            }
        }
        img = nil;
        strImgURL = nil;
    }
}

@end
