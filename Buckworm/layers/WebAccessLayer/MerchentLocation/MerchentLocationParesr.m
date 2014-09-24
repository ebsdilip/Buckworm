//
//  MerchentLocationParesr.m
//  buckworm
//
//  Created by TechSunRise on 8/5/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "MerchentLocationParesr.h"

@implementation MerchentLocationParesr
//http://buckworm.com/laravel/index.php/api/v1/location/merchants

@synthesize strLatitude;
@synthesize strLongitude;
@synthesize callBack;

- (void)startParsing
{
    //username=abcxyz&password=a123
//    http://buckworm.com/laravel/index.php/api/v1/location/merchants

    NSString *postString = [NSString stringWithFormat:@"latitude=%@&longitude=%@", strLatitude, strLongitude];
//    postString = @"latitude=40.696479&longitude=-73.463913";
    
//    latitude longitude
    NSLog(@"postString = %@", postString);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/v1/location/merchants", startOfURL]];
    NSLog(@"URL String = %@", [url absoluteString]);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSData *requestData = [NSData dataWithBytes:[postString UTF8String] length:[postString length]];
    
    [request setHTTPMethod:@"POST"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
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
    
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(MerchentLocationParserFinished:)])
	{
		[(id)[self callBack] MerchentLocationParserFinished:json];
	}
}

@end
