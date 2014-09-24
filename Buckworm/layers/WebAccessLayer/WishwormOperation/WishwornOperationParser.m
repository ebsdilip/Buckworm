//
//  WishwornOperationParser.m
//  buckworm
//
//  Created by Developer on 7/19/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "WishwornOperationParser.h"

@implementation WishwornOperationParser

@synthesize callBack;
@synthesize strOperation;
@synthesize strOfferID;
@synthesize strMerchantID;
@synthesize strWish;
@synthesize strCampaignuuID;
@synthesize strAccountToken;

- (void)startParsing
{
    NSString *strURL = [NSString stringWithFormat:@"%@/api/v1/networks/offers/wishworm/%@", startOfURL, strOperation];
    if([strOperation isEqualToString:@"lock"])
        strURL = [NSString stringWithFormat:@"%@/api/v1/networks/offers/lock", startOfURL];
    
    NSURL *url = [NSURL URLWithString:strURL];
    NSLog(@"URL String = %@", strURL);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSLog(@"appDelegate.objUserLogedIn.strAPIToken = %@", appDelegate.objUserLogedIn.strAPIToken);
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:appDelegate.objUserLogedIn.strAPIToken forHTTPHeaderField:@"X-Auth-Token"];
    
    NSString *strPostBody;
    if([strOperation isEqualToString:@"makeawish"])
    {
        [request setHTTPMethod:@"POST"];
        strPostBody = [NSString stringWithFormat:@"merchant_id=%@&wish=%@", strMerchantID, strWish];
    }
    else if([strOperation isEqualToString:@"download"])
    {
        [request setHTTPMethod:@"POST"];
        strPostBody = [NSString stringWithFormat:@"offer_id=%@&campaignuuid=%@&accountToken=%@", strOfferID, strCampaignuuID, strAccountToken];
    }
    else if([strOperation isEqualToString:@"option"])
    {
        [request setHTTPMethod:@"POST"];
        strPostBody = [NSString stringWithFormat:@"option_id=%@", strOfferID];
    }
    else if([strOperation isEqualToString:@"lock"])
    {
        [request setHTTPMethod:@"POST"];
        strPostBody = [NSString stringWithFormat:@"offer_id=%@", strOfferID];
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
    
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(wishwormOperationsParserFinished:)])
	{
		[(id)[self callBack] wishwormOperationsParserFinished:json];
	}
    
}


- (void)errorInParseing:(NSError *)error
{
    NSLog(@"JSON Error = %@", error.description);
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(errorInParseing:)])
	{
		[(id)[self callBack] errorInParseing:error];
	}
}

- (void)parserFinished:(id)data
{
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data
                          
                          options:kNilOptions
                          error:&error];
    
    NSLog(@"dict : %@", json);
    
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(wishwormOperationsParserFinished:)])
	{
		[(id)[self callBack] wishwormOperationsParserFinished:json];
	}
}

@end
