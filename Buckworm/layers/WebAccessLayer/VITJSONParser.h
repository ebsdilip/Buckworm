//
//  VITJSONParser.h
//  Jsondemo
//
//  Created by VincentIT on 7/10/13.
//  Copyright (c) 2013 Soniya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BWAppDelegate.h"

@interface VITJSONParser : NSObject
{
    NSInteger tagParser;
    BWAppDelegate *appDelegate;
    NSOperationQueue *opQueue;
    NSDictionary *myDict;

    NSMutableData *dataJSON;
}
@property(nonatomic) NSInteger tagParser;
@property(nonatomic) NSMutableData *dataJSON;

- (void)doParsing:(NSString *)strURL;
@end
