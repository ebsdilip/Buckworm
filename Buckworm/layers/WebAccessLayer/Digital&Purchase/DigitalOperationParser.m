//
//  DigitalOperationParser.m
//  buckworm
//
//  Created by Developer on 8/11/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "DigitalOperationParser.h"

@implementation DigitalOperationParser

@synthesize callBack;
@synthesize strOprationType;
@synthesize strCampaignID;
@synthesize strLinkID;

- (void)startParsing
{
    NSString *strURL = [NSString stringWithFormat:@"%@/api/v1/%@", startOfURL, strOprationType];
    if([strOprationType isEqualToString:@"deleteoffers"])
        strURL = [NSString stringWithFormat:@"%@/api/v1/%@/%@", startOfURL, strOprationType, strCampaignID];
    
    NSURL *url = [NSURL URLWithString:strURL];
    NSLog(@"URL String = %@", strURL);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:appDelegate.objUserLogedIn.strAPIToken forHTTPHeaderField:@"X-Auth-Token"];
    
    NSString *strPostBody;
    if([strOprationType isEqualToString:@"linkoffer"])
    {
        [request setHTTPMethod:@"POST"];
        strPostBody = [NSString stringWithFormat:@"campaign_uuid=%@", strCampaignID];
        NSLog(@"strPostBody = %@", strPostBody);
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:[strPostBody dataUsingEncoding:NSUTF8StringEncoding]];
    }
    else if([strOprationType isEqualToString:@"deleteoffers"])
    {
        [request setHTTPMethod:@"DELETE"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

//        strPostBody = [NSString stringWithFormat:@"campaign_id=%@", strCampaignID];
    }
    else if([strOprationType isEqualToString:@"redeem"])
    {
        [request setHTTPMethod:@"POST"];
        strPostBody = [NSString stringWithFormat:@"campaign_uuid=%@&link_id=%@", strCampaignID, strLinkID];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:[strPostBody dataUsingEncoding:NSUTF8StringEncoding]];
    }
    else if([strOprationType isEqualToString:@"lockoffer"])
    {
        [request setHTTPMethod:@"POST"];
        strPostBody = [NSString stringWithFormat:@"campaign_uuid=%@&link_id=%@", strCampaignID, strLinkID];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:[strPostBody dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
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
    
    if([strOprationType isEqualToString:@"linkoffer"])
    {
        if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(linkungParserFinished:)])
        {
            [(id)[self callBack] linkungParserFinished:json];
        }
    }
    else if([strOprationType isEqualToString:@"deleteoffers"])
    {
        if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(unlinkingParserFinished:)])
        {
            [(id)[self callBack] unlinkingParserFinished:json];
        }
    }
    else if([strOprationType isEqualToString:@"redeem"])
    {
        if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(markingAsRedeemedParserFinished:)])
        {
            [(id)[self callBack] markingAsRedeemedParserFinished:json];
        }
    }
    else if([strOprationType isEqualToString:@"lockoffer"])
    {
        if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(markingAsLockedParserFinished:)])
        {
            [(id)[self callBack] markingAsLockedParserFinished:json];
        }
    }
    
}

@end
