        //
//  VITJSONParser.m
//  Jsondemo
//
//  Created by VincentIT on 7/10/13.
//  Copyright (c) 2013 Soniya. All rights reserved.
//

#import "VITJSONParser.h"

@interface NSDictionary(JSONCategories)
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress;
@end

@implementation NSDictionary(JSONCategories)

+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress
{
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString: urlAddress]];
    NSError* error = nil;
 
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error != nil)
    {
        return [NSDictionary dictionaryWithObject:error forKey:@"Error"];
    }
    return result;
}

@end

@implementation VITJSONParser

@synthesize tagParser;
@synthesize dataJSON;

- (id)init
{
    self = [super init];
    if (self) {

        dataJSON = [NSMutableData data];
        
        appDelegate = (BWAppDelegate *)[UIApplication sharedApplication].delegate;
        opQueue = [[NSOperationQueue alloc] init];
        opQueue.maxConcurrentOperationCount = 5;
        [opQueue addObserver:self forKeyPath:@"operations" options:0 context:NULL];
    }
    return self;
}

- (void)doParsing:(NSString *)strURL
{
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(getData:) object:strURL];
//    if([opQueue operationCount]>0)
//    {
//        NSInvocationOperation *opD = [[opQueue operations] lastObject];
//        [op addDependency:opD];
//    }
    [opQueue addOperation:op];
}

- (void)getData:(NSString *)strURL
{
    myDict = [NSDictionary dictionaryWithContentsOfJSONURLString:strURL];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                         change:(NSDictionary *)change context:(void *)context
{
    if (object == opQueue && [keyPath isEqualToString:@"operations"])
    {
        if ([opQueue.operations count] == 0)
        {
            NSError *error = (NSError *)[myDict objectForKey:@"Error"];
            if(error)
                [self performSelectorOnMainThread:@selector(errorInParseing:) withObject:error waitUntilDone:YES];
            else
                [self performSelectorOnMainThread:@selector(parserFinished:) withObject:myDict waitUntilDone:YES];
        }
    }
//    else
//    {
//        [super observeValueForKeyPath:keyPath ofObject:object
//                               change:change context:context];
//    }
}

- (void)errorInParseing:(NSError *)error
{
}
- (void)parserFinished:(id)data
{
    
}

@end
