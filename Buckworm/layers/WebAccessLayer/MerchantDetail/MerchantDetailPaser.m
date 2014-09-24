//
//  MerchantDetailPaser.m
//  buckworm
//
//  Created by Developer on 8/21/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "MerchantDetailPaser.h"

@implementation MerchantDetailPaser

@synthesize strMerchantID;
@synthesize callBack;

- (void)startParsing
{

    NSString *strURL = [NSString stringWithFormat:@"%@/api/v1/merchant/%@", startOfURL, strMerchantID];

//    NSString *strURL = [NSString stringWithFormat:@"http://%@.buckworm.com", strMerchantID];
    
    NSURL *url = [NSURL URLWithString:strURL];
    NSLog(@"URL String = %@", strURL);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
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
    
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(merchantDetailPaserFinished:)])
    {
        [(id)[self callBack] merchantDetailPaserFinished:json];
    }
}

@end

