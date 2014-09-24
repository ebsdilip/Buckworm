//
//  MerchentDetailParser.m
//  buckworm
//
//  Created by TechSunRise on 8/6/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "MerchentDetailParser.h"

@implementation MerchentDetailParser

@synthesize strMerchentID;

//http://buckworm.com/laravel/index.php/api/v1/location/offers/83
@synthesize callBack;

- (void)startParsing
{
    //    http://buckworm.com/laravel/index.php/api/v1/location/offers/83
//    strMerchentID = @"83";
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/v1/location/offers/%@", startOfURL, strMerchentID]];
    NSLog(@"URL String = %@", [url absoluteString]);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
//    [request setHTTPMethod:@"GET"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if(connection)
    {
        NSLog(@"Connection Successful");
    }
    else
    {
        NSLog(@"Connection could not be made");
    }
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

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:self.dataJSON
                          
                          options:kNilOptions
                          error:&error];
    
    NSLog(@"dict : %@", json);
    
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(MerchentDetailParserFinished:)])
	{
		[(id)[self callBack] MerchentDetailParserFinished:json];
	}
}

@end
