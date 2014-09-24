//
//  OfferParser.m
//  buckworm
//
//  Created by TechSunRise on 6/24/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "OfferParser.h"

@implementation OfferParser

@synthesize strOfferType;
@synthesize callBack;

//Shopworm :
//http://buckworm.com/laravel/index.php/api/v1/networks/offers                  GET : National
//http://buckworm.com/laravel/index.php/api/v1/networks/offers/available        GET : Available
//http://buckworm.com/laravel/index.php/api/v1/networks/offers/buckworm         GET : Local
//http://buckworm.com/laravel/index.php/api/v1/networks/offers/linked           GET : Ready to Redeem
//http://buckworm.com/laravel/index.php/api/v1/networks/offers/redeemed         GET : Redeemed
//
//Wishworm :
//http://buckworm.com/laravel/index.php/api/v1/networks/offers/wishworm          GET Available
//http://buckworm.com/laravel/index.php/api/v1/networks/offers/wishworm/linked   GET Ready To Redeem
//http://buckworm.com/laravel/index.php/api/v1/networks/offers/wishworm/redeemed GET Redeemed

- (void)startParsingDemoRedeem
{
    //http://buckworm.com/laravel/index.php/api/v1/demoredeem
    NSString *strURL = [NSString stringWithFormat:@"%@/api/v1/demoredeem", startOfURL];
    NSURL *url = [NSURL URLWithString:strURL];
    NSLog(@"URL String = %@", strURL);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:0 timeoutInterval:240];
//    NSLog(@"appDelegate.objUserLogedIn.strAPIToken = %@", appDelegate.objUserLogedIn.strAPIToken);
//    [request setHTTPMethod:@"GET"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [request setValue:appDelegate.objUserLogedIn.strAPIToken forHTTPHeaderField:@"X-Auth-Token"];
    
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

- (void)startParsing
{
    NSString *strURL = [NSString stringWithFormat:@"%@/api/v1/networks/offers/%@", startOfURL, strOfferType];
    NSURL *url = [NSURL URLWithString:strURL];
    NSLog(@"URL String = %@", strURL);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:0 timeoutInterval:240];
    NSLog(@"appDelegate.objUserLogedIn.strAPIToken = %@", appDelegate.objUserLogedIn.strAPIToken);
    [request setHTTPMethod:@"GET"];
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
    [conn start];
    conn = nil;
}
- (void)startParsingForTeaserOffers
{
    NSString *strURL = [NSString stringWithFormat:@"%@/api/v1/offers", startOfURL];
    NSURL *url = [NSURL URLWithString:strURL];
    NSLog(@"URL String = %@", strURL);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [request setValue:appDelegate.objUserLogedIn.strAPIToken forHTTPHeaderField:@"X-Auth-Token"];
    
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
//    NSString *strJSON = @"{\"linkedOffer\":[{\"offer\":{\"campaignEndDate\":\"2012-03-09T23:59:59.000-05:00\",\"campaignUuid\":\"cbebd4e4-7c4b-4637-bf81-7885ff71aef6\",\"description\":\"Offer Terms and Conditions: <br /><br />Discount of $5.00off your next purchase of $40.00 or more for products at Home Depot.  Limit one offer per registered user.  This offer is being sponsored and paid for by Linkable Networks, Inc.  The offer is NOT sponsored, endorsed or affiliated with Home Depot.  This offer is only valid for qualifying purchases made on the Payment Card which is registered with the MyLinkables.com service and to which you linked the offer.  Offer valid on purchases made from 12:00:01 A.M. Eastern Time \"ET\" on 01/27/2012 or the date in which you link this offer to your card (whichever is later) and ends at 11:59:00 P.M. ET on 02/24/2012 \"Offer Period\".<br /><br />This Offer is valid in the U.S. only. Gift certificates/cards, packaging, taxes and prior purchases do not qualify toward the minimum purchase requirement and the discount cannot be applied to such items. This offer cannot be combined with other offers, promotions or discounts.  No adjustments on previous purchases.  Purchases made with this offer are not eligible for a price adjustment.  Offer is non-transferable and may be cancelled or modified at any time. The offer is void where prohibited.  This offer is subject to the MyLinkables.com Terms of Service (https://www.mylinkables.com/termsofservice).  This offer is being sponsored by Linkable Networks, Inc., 268 Summer Street, 5th Floor, Boston, MA 02210.<br /><br />Your savings will appear as a Payment Card or PayPal (if applicable) statement credit typically within 7 to 14 business days after the merchant processes your transaction.  This discount is the responsibility of Linkable Networks, Inc., the offer sponsor.  Your Payment Card issuer is not responsible for thediscount's funding.\",\"expiryDate\":\"2012-03-16T23:59:59.000-04:00\",\"id\":7696891154942794000,\"isShareable\":false,\"maxSavings\":null,\"merchant\":[{\"id\":137691,\"name\":\"THE HOME DEPOT\"}],\"numberOfPicksPerHousehold\":1,\"offerArtifact\":[{\"artifactType\":\"IMAGE\",\"embeddedHtml\":null,\"uri\":\"https://d3d81w5o43ld1r.cloudfront.net/qa1/qa1/offerartifacts/180x150/homdepot_20120127_180x150.jpg\"}],\"offerStartDate\":\"2012-02-06T00:00:00.000-05:00\",\"savings\":\"$5.00\",\"subtitle\":\"Save $5 off your next purchase of $40 or more\",\"title\":\"Sponsored by Linkable Networks\"},\"offerLink\":[{\"account\":{\"accountNickName\":\"3xxx\",\"accountToken\":\"000118058604681584319973716928822143210783\",\"accountType\":\"DEBITCARD\",\"defaultAccount\":true,\"financialInstitutionName\":\"Yodlee Data Services\",\"maskedAccountNumber\":\"xxxx3xxx\"},\"expiryDate\":\"2012-03-16T23:59:59.000-04:00\",\"id\":303091063441188,\"offer\":{\"campaignEndDate\":\"2012-03-09T23:59:59.000-05:00\",\"campaignUuid\":\"cbebd4e4-7c4b-4637-bf81-7885ff71aef6\",\"description\":\"Offer Terms and Conditions: <br /><br />Discount of $5.00 off your next purchase of $40.00 or more for products at Home Depot.  Limit one offer per registered user.  This offer is being sponsored and paid for by Linkable Networks, Inc.  The offer is NOT sponsored, endorsed or affiliated with Home Depot. This offer is only valid for qualifying purchases made on the Payment Card which is registered with the MyLinkables.com service and to which you linked the offer.  Offer valid on purchases made from 12:00:01 A.M. Eastern Time \"ET\" on 01/27/2012 or the date in which you link this offer to your card (whichever is later) and ends at 11:59:00 P.M. ET on 02/24/2012 \"Offer Period\".<br /><br />This Offer is valid in the U.S. only.  Gift certificates/cards, packaging, taxes and prior purchases do not qualify toward the minimum purchase requirement and the discount cannot be applied to such items.  This offer cannot be combined with other offers, promotions or discounts. No adjustments on previous purchases.  Purchases made with this offer are not eligible for a price adjustment.  Offer is non-transferable and may be cancelled or modified at any time. The offer is void where prohibited.  This offer is subject to the MyLinkables.com Terms of Service (https://www.mylinkables.com/termsofservice).  This offer is being sponsored by Linkable Networks, Inc., 268 Summer Street, 5th Floor, Boston, MA 02210.<br /><br />Your savings will appear as a Payment Card or PayPal (if applicable) statement credit typically within 7 to 14 business days after the merchant processes your transaction.  This discount is the responsibility of Linkable Networks, Inc., the offer sponsor.  Your Payment Card issuer is not responsible for the discount's funding.\",\"expiryDate\":\"2012-03-16T23:59:59.000-04:00\",\"id\":7696891154942794000,\"isShareable\":false,\"maxSavings\":null,\"merchant\":[{\"id\":137691,\"name\":\"THE HOME DEPOT\"}],\"numberOfPicksPerHousehold\":1,\"offerArtifact\":[{\"artifactType\":\"IMAGE\",\"embeddedHtml\":null,\"uri\":\"https://d3d81w5o43ld1r.cloudfront.net/qa1/qa1/offerartifacts/180x150/homdepot_20120127_180x150.jpg\"}],\"offerStartDate\":\"2012-02-06T00:00:00.000-05:00\",\"savings\":\"$5.00\",\"subtitle\":\"Save $5 off your next purchase of $40 or more\",\"title\":\"Sponsored by Linkable Networks\"},\"offerLinkStatus\":\"REDEEMED\",\"pickedDate\":\"2012-02-27T16:00:20.000-05:00\",\"redeemedDate\":null,\"settlementAmount\":null}]}],\"pagingInfo\":{\"currentPage\":1,\"hasNextPage\":false,\"hasPreviousPage\":false,\"numPages\":1,\"pageSize\":25,\"totalRecords\":1},\"statusCode\":100,\"statusDescription\":\"Success\"}";
//    
//    
//    NSData* data = [strJSON dataUsingEncoding:NSUTF8StringEncoding];
//    self.dataJSON = (NSMutableData *)data;
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:self.dataJSON
                          options:kNilOptions
                          error:&error];
    if(json)
        NSLog(@"dict : %@", json);
    else
        NSLog(@"error : %@", error);
    
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(OfferParserFinished:)])
	{
		[(id)[self callBack] OfferParserFinished:json];
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
    
    if(self.callBack!=nil && [(id)[self callBack] respondsToSelector:@selector(OfferParserFinished:)])
	{
		[(id)[self callBack] OfferParserFinished:json];
	}
}

@end
