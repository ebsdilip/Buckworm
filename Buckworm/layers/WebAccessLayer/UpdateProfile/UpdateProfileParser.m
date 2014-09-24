//
//  UpdateProfileParser.m
//  buckworm
//
//  Created by TechSunRise on 6/27/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "UpdateProfileParser.h"

@implementation UpdateProfileParser

@synthesize strUpdate;
@synthesize callBack;

- (void)startParsing
{
    NSString *strURL = [NSString stringWithFormat:@"%@/api/v1/users/%@", startOfURL, appDelegate.objUserLogedIn.strID];
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSLog(@"URL String = %@\n data = %@", strURL, self.strUpdate);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:appDelegate.objUserLogedIn.strAPIToken forHTTPHeaderField:@"X-Auth-Token"];
    [request setHTTPBody:[self.strUpdate dataUsingEncoding:NSUTF8StringEncoding]];

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
    
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(UpdateProfileParserFinished:)])
	{
		[(id)[self callBack] UpdateProfileParserFinished:json];
	}
    
}

@end
