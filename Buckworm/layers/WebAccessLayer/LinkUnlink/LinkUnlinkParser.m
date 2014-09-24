//
//  LinkUnlinkParser.m
//  buckworm
//
//  Created by TechSunRise on 6/28/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "LinkUnlinkParser.h"

@implementation LinkUnlinkParser

@synthesize callBack;

@synthesize strMethod;
@synthesize strOfferID;
@synthesize strAccount;

- (void)startParsing
{
    // /api/v1/networks/offers/{offerid}/card/{account}/link
    // /api/v1/networks/offers/unlink/{offerid}
    
    NSString *strURL;
    if([strMethod isEqualToString:@"link"])
        strURL = [NSString stringWithFormat:@"%@/api/v1/networks/offers/%@/card/%@/link", startOfURL, self.strOfferID, self.strAccount];
    else if([strMethod isEqualToString:@"unlink"])
        strURL = [NSString stringWithFormat:@"%@/api/v1/networks/offers/unlink/%@", startOfURL, self.strOfferID];
    
    NSURL *url = [NSURL URLWithString:strURL];
    NSLog(@"URL String = %@", strURL);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:appDelegate.objUserLogedIn.strAPIToken forHTTPHeaderField:@"X-Auth-Token"];
    
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
    if(conn)
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
    if(json)
        NSLog(@"dict : %@", json);
    else
        NSLog(@"error : %@", error);
    
    if([strMethod isEqualToString:@"link"])
    {
        if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(LinkParserFinished:)])
        {
            [(id)[self callBack] LinkParserFinished:json];
        }
    }
    else if([strMethod isEqualToString:@"unlink"])
    {
        if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(UnlinkParserFinished:)])
        {
            [(id)[self callBack] UnlinkParserFinished:json];
        }
    }
}

@end
