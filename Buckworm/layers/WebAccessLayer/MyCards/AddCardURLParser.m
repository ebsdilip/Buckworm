//
//  AddCardURLParser.m
//  buckworm
//
//  Created by TechSunRise on 6/19/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "AddCardURLParser.h"

@implementation AddCardURLParser

@synthesize callBack;

- (void)startParsing
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/v1/networks/cards/add", startOfURL]];
    NSLog(@"URL String = %@", [url absoluteString]);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:appDelegate.objUserLogedIn.strAPIToken forHTTPHeaderField:@"X-Auth-Token"];
    //    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
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
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data
                          
                          options:kNilOptions
                          error:&error];
    
    NSLog(@"dict : %@", json);
    
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(AddCardURLParserFinished:)])
	{
		[(id)[self callBack] AddCardURLParserFinished:json];
	}
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(errorInParseing:)])
	{
		[(id)[self callBack] errorInParseing:error];
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
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
    
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(AddCardURLParserFinished:)])
	{
		[(id)[self callBack] AddCardURLParserFinished:json];
	}
}

@end
