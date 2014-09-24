//
//  LoginParser.h
//  EyeWitness
//
//  Created by Gitesh Mac on 10/09/13.
//  Copyright (c) 2013 VincentIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VITJSONParser.h"

@protocol LoginParserDelegate;
@interface LoginParser : VITJSONParser
{
    NSString *strUserName;
    NSString *strPassword;
    
    __unsafe_unretained id <LoginParserDelegate>callBack;
}

@property(nonatomic, retain) NSString *strUserName;
@property(nonatomic, retain) NSString *strPassword;

@property(nonatomic,assign)__unsafe_unretained id <LoginParserDelegate>callBack;

- (void)startParsing;

@end

@protocol LoginParserDelegate <NSObject>

@optional
- (void)LoginParserFinished:(NSDictionary *)dictData;
@optional
- (void)errorInParseing:(NSError *)error;

@end
