//
//  GeoCodeFromAddressParser.m
//  buckworm
//
//  Created by Developer on 8/13/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "GeoCodeFromAddressParser.h"

@implementation GeoCodeFromAddressParser
//https://maps.googleapis.com/maps/api/geocode/json?address=bhopal&key=AIzaSyA4-Wl2BiqR1g1LwIYoRE9VqfEZIZRZxhw

@synthesize strAddress;
@synthesize callBack;

- (void)startParsing
{
    NSString *strURL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@&key=AIzaSyA4-Wl2BiqR1g1LwIYoRE9VqfEZIZRZxhw", strAddress];
    
    NSURL *url = [NSURL URLWithString:strURL];
    NSLog(@"URL String = %@", strURL);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
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

    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(GeoCodeFromAddressParserFinished:)])
	{
		[(id)[self callBack] GeoCodeFromAddressParserFinished:json];
	}
}

@end
