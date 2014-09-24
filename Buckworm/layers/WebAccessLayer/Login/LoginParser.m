//
//  LoginParser.m
//  EyeWitness
//
//  Created by Gitesh Mac on 10/09/13.
//  Copyright (c) 2013 VincentIT. All rights reserved.
//

#import "LoginParser.h"

@implementation LoginParser

@synthesize callBack;
@synthesize strUserName;
@synthesize strPassword;

- (void)startParsing
{
    //username=abcxyz&password=a123
    NSString *postString = [NSString stringWithFormat:@"username=%@&password=%@", strUserName, strPassword];
    NSLog(@"postString = %@", postString);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/v1/login", startOfURL]];
    NSLog(@"URL String = %@", [url absoluteString]);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSData *requestData = [NSData dataWithBytes:[postString UTF8String] length:[postString length]];
    
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
    
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(LoginParserFinished:)])
	{
		[(id)[self callBack] LoginParserFinished:json];
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
    NSDictionary *dict = (NSDictionary *)data;
    
    NSLog(@"dict : %@", dict);
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(LoginParserFinished:)])
	{
		[(id)[self callBack] LoginParserFinished:dict];
	}
}

@end
