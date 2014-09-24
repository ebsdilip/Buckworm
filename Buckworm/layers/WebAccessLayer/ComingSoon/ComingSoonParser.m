//
//  ComingSoonParser.m
//  buckworm
//
//  Created by Developer on 8/1/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "ComingSoonParser.h"
#import "DSActivityView.h"

@implementation ComingSoonParser

@synthesize strPostBody;
@synthesize strOfferType;
@synthesize callBack;

- (void)startParsing
{
    isComingSoon = YES;
    NSString *strURL = [NSString stringWithFormat:@"%@/api/v1/offers/%@", startOfURL, strOfferType];
    NSURL *url = [NSURL URLWithString:strURL];
    NSLog(@"URL String = %@", strURL);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:0 timeoutInterval:240];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
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

- (void)startParsingOfLocalOffer
{
    isComingSoon = NO;
    NSString *strURL = [NSString stringWithFormat:@"%@/api/v1/location/offers", startOfURL];
    NSURL *url = [NSURL URLWithString:strURL];
    NSLog(@"URL String = %@", strURL);

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:0 timeoutInterval:240];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    //Latitude=26.3657&Longitude=-80.1254&offer_type=Digital
    NSLog(@"appDelegate.objUserLogedIn.strAPIToken = %@", appDelegate.objUserLogedIn.strAPIToken);
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:appDelegate.objUserLogedIn.strAPIToken forHTTPHeaderField:@"X-Auth-Token"];
    
    [request setHTTPMethod:@"POST"];

    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[strPostBody dataUsingEncoding:NSUTF8StringEncoding]];

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
    
    if(isComingSoon==YES)
    {
        if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(ComingSoonParserFinished:)])
        {
            [(id)[self callBack] ComingSoonParserFinished:json];
        }
        else
            [DSBezelActivityView removeViewAnimated:YES];
    }
    else
    {
        if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(localOfferParserFinished:)])
        {
            [(id)[self callBack] localOfferParserFinished:json];
        }
        else
            [DSBezelActivityView removeViewAnimated:YES];
    }
}

@end

