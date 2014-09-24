//
//  BW_Login_ViewController.h
//  Buckworm
//
//  Created by Developer on 6/10/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BW_Base_ViewController.h"
#import "BW_Login_BL.h"

@class BWViewController;
@interface BW_Login_ViewController : BW_Base_ViewController <UITextFieldDelegate, BW_Login_BL_Delegate>
{
    UITextField *txtFieldUsername;
    UITextField *txtFieldPassword;
    
    BW_Login_BL *objLoginBL;
}
@property(nonatomic) UIViewController *callBack;
@property(nonatomic) NSInteger isMore;
@end
