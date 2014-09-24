//
//  BW_Register_ViewController.h
//  Buckworm
//
//  Created by Developer on 6/10/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BW_Base_ViewController.h"
#import "BW_SignUp_BL.h"
#import "BW_Login_BL.h"

@interface BW_Register_ViewController : BW_Base_ViewController<UITextFieldDelegate, BW_SignUp_BL_Delegate, BW_Login_BL_Delegate>
{
    BW_SignUp_BL *objSignUpBL;
    BW_Login_BL *objLoginBL;
    
    UIScrollView *scrlView;

    UITextField *txtFieldUsername;
    UITextField *txtFieldEmailAddress;
    UITextField *txtFieldPassword;
    UITextField *txtFieldConfirmPassword;    
}
@end
