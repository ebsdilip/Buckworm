//
//  BW_UpdateProfile_ViewController.h
//  buckworm
//
//  Created by TechSunRise on 6/23/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BW_Base_ViewController.h"
#import "BW_UpdateProfile_BL.h"

@interface BW_UpdateProfile_ViewController : BW_Base_ViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, BW_UpdateProfile_BL_Delegate>
{
    BW_UpdateProfile_BL *objUpdateProfileBL;
    
    NSMutableArray *arrSchool;
    UIScrollView *scrlViewProfile;

    UITextField *txtFieldFirstname;
    UITextField *txtFieldUsername;
    UITextField *txtFieldPassword;
    UITextField *txtFieldNewPassword;
    UITextField *txtFieldConfirmPassword;

    UIButton *btnDOB;
    UITextField *txtFieldEmailAddress;
    UITextField *txtFieldZipCode;
    UIButton *btnSchool;
    
    NSString *strDateSelected;
    UIDatePicker *datePicker;
    UIView *viewPickerBG;
    UIToolbar *datePickerToolBar;
    
    UIPickerView *pickerSchool;
    UIButton *btnPickerSchoolDone;
    NSDictionary *dictSelectedSchool;
}
@end
