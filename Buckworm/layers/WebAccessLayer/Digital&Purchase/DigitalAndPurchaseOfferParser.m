//
//  DigitalAndPurchaseOfferParser.m
//  buckworm
//
//  Created by Developer on 8/11/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "DigitalAndPurchaseOfferParser.h"

@implementation DigitalAndPurchaseOfferParser

@synthesize callBack;
@synthesize strCampaignID;
@synthesize strOfferType;
@synthesize strOfferSubCategory;

- (void)startParsing
{
    NSString *strURL;
//    if([strOfferSubCategory isEqualToString:@"expired"])
//        strURL = [NSString stringWithFormat:@"%@/api/v1/%@/%@", startOfURL, @"expiredoffers", strOfferType];
//    else
        strURL = [NSString stringWithFormat:@"%@/api/v1/%@/%@", startOfURL, @"offer", strOfferSubCategory];

//    http://buckworm.com/laravel/index.php/api/v1/offer/linked
    NSURL *url = [NSURL URLWithString:strURL];
    NSLog(@"URL String = %@", strURL);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:appDelegate.objUserLogedIn.strAPIToken forHTTPHeaderField:@"X-Auth-Token"];

    [request setHTTPMethod:@"GET"];
    
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
    if(conn)
    {
        NSLog(@"Connection Successful");
    }
    else
    {
        NSLog(@"Connection could not be made");
    }
    [conn start];
    conn = nil;
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.dataJSON appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(errorInParseing:)])
	{
		[(id)[self callBack] errorInParseing:error];
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:self.dataJSON
                          options:kNilOptions
                          error:&error];
    if(json)
        NSLog(@"dict : %@", json);
    else
        NSLog(@"error : %@", error);
    
    if([strOfferSubCategory isEqualToString:@"unlinkoffers"])
    {
        if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(availableOfferParserFinished:)])
        {
            [(id)[self callBack] availableOfferParserFinished:json];
        }
    }
    else if([strOfferSubCategory isEqualToString:@"linkoffers"]|| [strOfferSubCategory isEqualToString:@"linked"])
    {
        if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(linkedOfferParserFinished:)])
        {
            [(id)[self callBack] linkedOfferParserFinished:json];
        }
    }
    else if([strOfferSubCategory isEqualToString:@"reedemedoffers"] || [strOfferSubCategory isEqualToString:@"redeemed"])
    {
        if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(redeemedOfferParserFinished:)])
        {
            [(id)[self callBack] redeemedOfferParserFinished:json];
        }
    }
    else if([strOfferSubCategory isEqualToString:@"expiredoffers"] || [strOfferSubCategory isEqualToString:@"expired"])
    {
        if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(expiredOfferParserFinished:)])
        {
            [(id)[self callBack] expiredOfferParserFinished:json];
        }
    }//expiredoffers
}

@end
