//
//  SurvetBoxParser.m
//  buckworm
//
//  Created by Developer on 8/16/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "SurvetBoxParser.h"

@implementation SurvetBoxParser

@synthesize strCampaignUUID;
@synthesize strText;
@synthesize callBack;

- (void)startParsing
{
//     http://buckworm.com/laravel/index.php/api/v1/lastvisit
    NSString *strURL = [NSString stringWithFormat:@"%@/api/v1/lastvisit", startOfURL];
    
    NSURL *url = [NSURL URLWithString:strURL];
    NSLog(@"URL String = %@", strURL);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:appDelegate.objUserLogedIn.strAPIToken forHTTPHeaderField:@"X-Auth-Token"];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *strPostBody = [NSString stringWithFormat:@"campaign_uuid=%@&last_visit=%@", strCampaignUUID, strText];
    NSLog(@"strPostBody = %@", strPostBody);
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
    
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(survetBoxParserFinished:)])
    {
        [(id)[self callBack] survetBoxParserFinished:json];
    }
}

@end
