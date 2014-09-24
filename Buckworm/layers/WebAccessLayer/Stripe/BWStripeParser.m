//
//  BWStripeParser.m
//  Buckworm
//
//  Created by iLabours on 9/15/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BWStripeParser.h"

@implementation BWStripeParser

@synthesize strDescription;
@synthesize strAction;
@synthesize strOrderNumber;
@synthesize strAmount;
@synthesize strCampaign_uuid;
@synthesize strStripeToken;
@synthesize callBack;

- (void)startParsing
{
    //http://buckworm.com/laravel/index.php/api/v1/stripe/pay
    //http://buckworm.com/laravel/index.php/api/v1/stripe/refund
    
    NSString *strURL;
    strURL = [NSString stringWithFormat:@"%@/api/v1/stripe/%@", startOfURL, self.strAction];
    
    NSURL *url = [NSURL URLWithString:strURL];
    NSLog(@"URL String = %@", strURL);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:appDelegate.objUserLogedIn.strAPIToken forHTTPHeaderField:@"X-Auth-Token"];
    
    NSString *strPostBody;
    
    if([self.strAction isEqualToString:@"pay"])
    {
        strPostBody = [NSString stringWithFormat:@"stripeToken=%@&amount=%@&campaign_uuid=%@", strStripeToken, strAmount, strCampaign_uuid];
    }
    else if([self.strAction isEqualToString:@"refund"])
    {
        strPostBody = [NSString stringWithFormat:@"orderno=%@&description=%@", strOrderNumber, strDescription];
    }

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
    
    if([self.strAction isEqualToString:@"pay"])
    {
        if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(paymentParserFinished:)])
        {
            [(id)[self callBack] paymentParserFinished:json];
        }
    }
    else if([self.strAction isEqualToString:@"refund"])
    {
        if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(refundParserFinished:)])
        {
            [(id)[self callBack] refundParserFinished:json];
        }
    }
}

@end
