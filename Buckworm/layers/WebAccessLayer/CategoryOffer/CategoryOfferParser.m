//
//  CategoryOfferParser.m
//  Buckworm
//
//  Created by iLabours on 8/29/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "CategoryOfferParser.h"

@implementation CategoryOfferParser

@synthesize strOfferCategory;
@synthesize strOfferType;
@synthesize callBack;

- (void)startParsing
{
    NSString *strLocation = [NSString stringWithFormat:@"latitude=%f,longitude=%f", appDelegate.currentLocationPoint.coordinate.latitude, appDelegate.currentLocationPoint.coordinate.longitude];

    NSString *strURL;
    
    if([strOfferCategory isEqualToString:@"card%20rebate"])
        strURL = [NSString stringWithFormat:@"%@/api/v1/offer?offer_type=%@&%@", startOfURL, strOfferCategory, strLocation];
    else if(strOfferCategory && [strOfferCategory length]>0)
        strURL = [NSString stringWithFormat:@"%@/api/v1/offer?category=%@&%@&online=false", startOfURL, strOfferCategory, strLocation];
    else
        strURL = [NSString stringWithFormat:@"%@/api/v1/offer?%@&online=false", startOfURL, strLocation];
 
    
//    strURL = @"http://buckworm.com/laravel/index.php/api/v1/offer?latitude=23.3695&longitude=-80.1728";
//http://buckworm.com/laravel/index.php/api/v1/offer
    NSURL *url = [NSURL URLWithString:strURL];
    NSLog(@"URL String = %@", strURL);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:0 timeoutInterval:240];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"GET"];

//    NSString *strPostBody = 
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPBody:[strPostBody dataUsingEncoding:NSUTF8StringEncoding]];

//    Food & Drink
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
    
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(categoryOfferParserFinished:)])
    {
        [(id)[self callBack] categoryOfferParserFinished:json];
    }
    else
        [DSBezelActivityView removeViewAnimated:YES];
}

@end

