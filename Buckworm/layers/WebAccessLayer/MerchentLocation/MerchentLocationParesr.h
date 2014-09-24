//
//  MerchentLocationParesr.h
//  buckworm
//
//  Created by TechSunRise on 8/5/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "VITJSONParser.h"

@protocol MerchentLocationParesrDelegate;
@interface MerchentLocationParesr : VITJSONParser
{
    NSString *strLatitude;
    NSString *strLongitude;
    __unsafe_unretained id <MerchentLocationParesrDelegate>callBack;

}

@property(nonatomic) NSString *strLatitude;
@property(nonatomic) NSString *strLongitude;

@property(nonatomic, assign) __unsafe_unretained id <MerchentLocationParesrDelegate>callBack;

- (void)startParsing;

@end

@protocol MerchentLocationParesrDelegate <NSObject>

@optional
- (void)errorInParseing:(NSError *)error;
@optional
- (void)MerchentLocationParserFinished:(NSDictionary *)dictOffers;

@end