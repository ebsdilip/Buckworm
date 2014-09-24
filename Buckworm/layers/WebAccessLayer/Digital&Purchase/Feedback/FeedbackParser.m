//
//  FeedbackParser.m
//  buckworm
//
//  Created by Developer on 8/16/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "FeedbackParser.h"

@implementation FeedbackParser

@synthesize strComment;
@synthesize strRating;
@synthesize strAmount;
@synthesize strCampaignUUID;
@synthesize callBack;

- (void)startParsing
{
    //http://buckworm.com/laravel/index.php/api/v1/comment
    NSString *strURL = [NSString stringWithFormat:@"%@/api/v1/comment", startOfURL];

    NSURL *url = [NSURL URLWithString:strURL];
    NSLog(@"URL String = %@", strURL);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:appDelegate.objUserLogedIn.strAPIToken forHTTPHeaderField:@"X-Auth-Token"];

    [request setHTTPMethod:@"POST"];
    
    NSString *strPostBody = [NSString stringWithFormat:@"comment=%@&source_id=%@&source_type=Merchant&rating=%@&amount=%@", strComment, strCampaignUUID, strRating, strAmount];
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
    
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(feedbackParserFinished:)])
    {
        [(id)[self callBack] feedbackParserFinished:json];
    }
}

@end
