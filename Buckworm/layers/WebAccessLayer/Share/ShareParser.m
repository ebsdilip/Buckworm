//
//  ShareParser.m
//  buckworm
//
//  Created by Developer on 8/11/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "ShareParser.h"

@implementation ShareParser

@synthesize callBack;
@synthesize strOperation;
@synthesize strShareID;
@synthesize strOfferID;
@synthesize strToEmails;

- (instancetype)init
{
    self = [super init];
    if (self) {
        strShareID  = nil;
    }
    return self;
}
- (void)startParsing
{
    NSString *strURL;
    if(strShareID==nil)
        strURL = [NSString stringWithFormat:@"%@/api/v1/networks/offers/%@", startOfURL, strOperation];
    else
        strURL = [NSString stringWithFormat:@"%@/api/v1/networks/offers/share/%@", startOfURL, strShareID];
    
    NSURL *url = [NSURL URLWithString:strURL];
    NSLog(@"URL String = %@", strURL);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:appDelegate.objUserLogedIn.strAPIToken forHTTPHeaderField:@"X-Auth-Token"];
    
    NSString *strPostBody;
    if([strOperation isEqualToString:@"sharewith"])
    {
        [request setHTTPMethod:@"POST"];
        strPostBody = [NSString stringWithFormat:@"share_id=%@", strShareID];
    }
    else if([strOperation isEqualToString:@"share"])
    {
        if(strShareID==nil)
        {
            [request setHTTPMethod:@"POST"];
            strPostBody = [NSString stringWithFormat:@"offer_id=%@&shared_via=email&shared_with=%@", strOfferID, strToEmails];
        }
        else
        {
            [request setHTTPMethod:@"GET"];
            strPostBody = [NSString stringWithFormat:@"share_id=%@", strShareID];
        }
    }
    
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
    
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(ShareParserFinished:)])
	{
		[(id)[self callBack] ShareParserFinished:json];
	}    
}

@end
