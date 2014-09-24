//
//  BW_Login_BO.h
//  buckworm
//
//  Created by TechSunRise on 6/18/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BW_Base_BO.h"

@interface BW_Login_BO : BW_Base_BO
{
    NSString *strID;
    NSString *strFirstname;
    NSString *strDOB;
    NSString *strUserType;
    NSInteger intNumberOfChildren;
    NSString *strEmail;
    NSInteger intZipCode;
    NSString *strSchoolID;
    NSString *strUsername;
    NSString *strVerificationCode;
    NSString *strVerified;
    NSString *strConsumerToken;
    NSString *strAccessToken;
    NSInteger intEarnedPoints;
    NSInteger intCashedPoints;
    BOOL isCardAdded;
    BOOL isActivated;
    
    NSString *strAPIToken;

    NSString *strCreatedAt;
    NSString *strExpiresAt;
    NSString *strlastLogin;
    NSString *strUpdatedAt;
    NSString *strSelectedCard;
    
}

@property(nonatomic, strong, strong) NSString *strID;
@property(nonatomic, strong) NSString *strFirstname;
@property(nonatomic, strong) NSString *strDOB;
@property(nonatomic, strong) NSString *strUserType;
@property(nonatomic) NSInteger intNumberOfChildren;
@property(nonatomic, strong) NSString *strEmail;
@property(nonatomic) NSInteger intZipCode;
@property(nonatomic, strong) NSString *strSchoolID;
@property(nonatomic, strong) NSString *strUsername;
@property(nonatomic, strong) NSString *strVerificationCode;
@property(nonatomic, strong) NSString *strVerified;
@property(nonatomic, strong) NSString *strConsumerToken;
@property(nonatomic, strong) NSString *strAccessToken;
@property(nonatomic) NSInteger intEarnedPoints;
@property(nonatomic) NSInteger intCashedPoints;
@property(nonatomic) BOOL isCardAdded;
@property(nonatomic) BOOL isActivated;

@property(nonatomic, strong) NSString *strAPIToken;

@property(nonatomic, strong) NSString *strPassword;
@property(nonatomic, strong) NSString *strNewPassword;
@property(nonatomic, strong) NSString *strConfirmPassword;
@property(nonatomic, strong) NSString *strSelectedCard;

@end
