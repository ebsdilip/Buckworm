//
//  SignUpParser.m
//  buckworm
//
//  Created by TechSunRise on 6/28/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "SignUpParser.h"

@implementation SignUpParser

@synthesize callBack;
@synthesize strPostString;

- (void)startParsing
{
//username=abcxyz&email=abc%40ex ample.com&password=a12345678&f irst=ab&dob=2001­01­01&user_type =S&zipcode=00501&schoolid=19743

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/v1/users", startOfURL]];
    NSLog(@"URL String = %@", [url absoluteString]);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSData *requestData = [NSData dataWithBytes:[strPostString UTF8String] length:[strPostString length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
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
    
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(SignUpParserFinished:)])
	{
		[(id)[self callBack] SignUpParserFinished:json];
	}
}

@end
