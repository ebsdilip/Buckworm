//
//  CardsListParser.m
//  buckworm
//
//  Created by TechSunRise on 6/28/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "CardsListParser.h"

@implementation CardsListParser

@synthesize callBack;

- (void)startParsing
{
//    http://buckworm.com/laravel/index.php/api/v1/networks/cards
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/api/v1/networks/cards", startOfURL]];
    NSLog(@"URL String = %@", [url absoluteString]);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:appDelegate.objUserLogedIn.strAPIToken forHTTPHeaderField:@"X-Auth-Token"];
    
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
    if(json)
        NSLog(@"dict : %@", json);
    else
        NSLog(@"error : %@", error);
    
    NSString *temstr = [[NSString alloc]initWithData:self.dataJSON encoding:NSUTF8StringEncoding];
    NSLog(@"recieved data %@", temstr);

    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(CardsListParserFinished:)])
	{
		[(id)[self callBack] CardsListParserFinished:json];
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
    
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(CardsListParserFinished:)])
	{
		[(id)[self callBack] CardsListParserFinished:json];
	}
}

@end
