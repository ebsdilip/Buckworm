//
//  BW_UpdateProfile_ViewController.m
//  buckworm
//
//  Created by TechSunRise on 6/23/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_UpdateProfile_ViewController.h"

@interface BW_UpdateProfile_ViewController ()

@end

@implementation BW_UpdateProfile_ViewController

- (void)clearMemory
{
    objUpdateProfileBL.callBack = nil;
    objUpdateProfileBL = nil;
    
    arrSchool = nil;
    scrlViewProfile = nil;
    
    txtFieldFirstname.delegate = nil;
    txtFieldUsername.delegate = nil;
    txtFieldPassword.delegate = nil;
    txtFieldNewPassword.delegate = nil;
    txtFieldConfirmPassword.delegate = nil;
    txtFieldEmailAddress.delegate = nil;
    txtFieldZipCode.delegate = nil;

    txtFieldFirstname = nil;
    txtFieldUsername = nil;
    txtFieldPassword = nil;
    txtFieldNewPassword = nil;
    txtFieldConfirmPassword = nil;
    txtFieldEmailAddress = nil;
    txtFieldZipCode = nil;


    btnDOB = nil;
    btnSchool = nil;
    
    strDateSelected = nil;
    
    datePicker = nil;;
    viewPickerBG = nil;
    datePickerToolBar = nil;
    
    pickerSchool.delegate = nil;
    pickerSchool.dataSource = nil;
    pickerSchool = nil;
    
    btnPickerSchoolDone = nil;
    dictSelectedSchool = nil;
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        objUpdateProfileBL = [[BW_UpdateProfile_BL alloc] init];
        objUpdateProfileBL.callBack = self;
        
        arrSchool = [[NSMutableArray alloc] init];

    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self resignAllTextFields];
}
- (void)resignAllTextFields
{
    [txtFieldUsername resignFirstResponder];
    [txtFieldPassword resignFirstResponder];
    [txtFieldConfirmPassword resignFirstResponder];
    
    [txtFieldFirstname resignFirstResponder];
    [txtFieldEmailAddress resignFirstResponder];
    [txtFieldZipCode resignFirstResponder];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackButton];
    [self screenDesignProfile];
    lblBarTitle.text = @"UPDATE PROFILE";
    
    UIImageView *imgViewBuyButton = [[UIImageView alloc] initWithFrame:CGRectMake(0, IS_IPHONE_5?518:430, 320, 50)];
    imgViewBuyButton.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"black-bg" ofType:@"png"]];
    [self.view addSubview:imgViewBuyButton];

    UIButton *btnUpdate = [[UIButton alloc] initWithFrame:CGRectMake(50, IS_IPHONE_5?523:435, 220, 40)];
    [btnUpdate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnUpdate.titleLabel.font = [UIFont boldSystemFontOfSize:24];
    [btnUpdate setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"done" ofType:@"png"]] forState:UIControlStateNormal];
    [btnUpdate setTitle:@"UPDATE" forState:UIControlStateNormal];
    [btnUpdate addTarget:self action:@selector(updateProfileToTheServer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnUpdate];

//    UIBarButtonItem *btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    
//    btnSpace.width = [BWAppDelegate isCurrentVersionBelongToiOS7]?114:104;
//    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"UPDATE" style:UIBarButtonItemStyleBordered target:self action:@selector(updateProfileToTheServer)];
//    
//    [self setToolbarItems:[NSArray arrayWithObjects:btnSpace, anotherButton, nil] animated:YES];

}
#pragma mark- Profile

- (void)screenDesignProfile
{
    float yRef = 0.0;
    float space = 0.0;
    if(IS_IPHONE_5)
    {
        //        yRef = 80.0;
    }
    UIColor *colorTxtFieldBG = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    UIColor *colorTxtFieldText = [UIColor orangeColor];
    UIColor *colorTitleText = [UIColor grayColor];

    UIFont *fontValue = [UIFont systemFontOfSize:12];
    
//    colorTxtFieldBG = textFieldBGColor;
    
    scrlViewProfile = [[UIScrollView alloc] init];
    scrlViewProfile.backgroundColor = [UIColor clearColor];
    scrlViewProfile.frame = CGRectMake(0, 64, 320, IS_IPHONE_5?460:370);
    //    scrlViewProfile.contentSize = CGSizeMake(320*4, 284);
    //    scrlViewProfile.pagingEnabled = YES;
    [self.view addSubview:scrlViewProfile];
    
    UILabel *lblFirstname = [[UILabel alloc] initWithFrame:CGRectMake(20, yRef, 100, 30)];
    lblFirstname.text = @"Firstname";
    lblFirstname.font = [UIFont systemFontOfSize:14.0];
    lblFirstname.backgroundColor = [UIColor clearColor];
    lblFirstname.textColor = colorTitleText;
    [scrlViewProfile addSubview:lblFirstname];
    yRef += lblFirstname.frame.size.height;
    lblFirstname = nil;

    txtFieldFirstname = [[UITextField alloc] initWithFrame:CGRectMake(20, yRef, 280, 30)];
    txtFieldFirstname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtFieldFirstname.text = appDelegate.objUserLogedIn.strFirstname;
    txtFieldFirstname.delegate = self;
    txtFieldFirstname.font = fontValue;
    txtFieldFirstname.returnKeyType = UIReturnKeyNext;
    txtFieldFirstname.textColor = colorTxtFieldText;
    txtFieldFirstname.backgroundColor = colorTxtFieldBG;
    txtFieldFirstname.layer.borderColor = [UIColor whiteColor].CGColor;
    [scrlViewProfile addSubview:txtFieldFirstname];
    
    yRef += 30+space;
    
    UILabel *lblBirthDate = [[UILabel alloc] initWithFrame:CGRectMake(20, yRef, 280, 30)];
    lblBirthDate.textColor = colorTitleText;
    lblBirthDate.text = @"Birth Date";
    lblBirthDate.font = [UIFont systemFontOfSize:14.0];
    lblBirthDate.backgroundColor = [UIColor clearColor];
    [scrlViewProfile addSubview:lblBirthDate];
    yRef += 30;
    lblBirthDate = nil;
    
    btnDOB = [[UIButton alloc] initWithFrame:CGRectMake(20, yRef, 280, 30)];
    btnDOB.titleLabel.font = fontValue;
    btnDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnDOB setTitle:appDelegate.objUserLogedIn.strDOB forState:UIControlStateNormal];
    [btnDOB setTitleColor:colorTxtFieldText forState:UIControlStateNormal];
    [btnDOB setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    btnDOB.backgroundColor = colorTxtFieldBG;
    btnDOB.layer.borderColor = [UIColor whiteColor].CGColor;
//    btnDOB.layer.borderWidth = 1.0;
//    btnDOB.layer.cornerRadius = 5.0;
    [btnDOB addTarget:self action:@selector(btnMonthClicked) forControlEvents:UIControlEventTouchUpInside];
    [scrlViewProfile addSubview:btnDOB];
    
    yRef += 30+space;
    
    UILabel *lblEmailAddress = [[UILabel alloc] initWithFrame:CGRectMake(20, yRef, 280, 30)];
    lblEmailAddress.textColor = colorTitleText;
    lblEmailAddress.text = @"Email Address";
    lblEmailAddress.font = [UIFont systemFontOfSize:14.0];
    lblEmailAddress.backgroundColor = [UIColor clearColor];
    [scrlViewProfile addSubview:lblEmailAddress];
    yRef += 30;
    
    txtFieldEmailAddress = [[UITextField alloc] initWithFrame:CGRectMake(20, yRef, 280, 30)];
    txtFieldEmailAddress.enabled = NO;
    txtFieldEmailAddress.font =  fontValue;
    txtFieldEmailAddress.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtFieldEmailAddress.text = appDelegate.objUserLogedIn.strEmail;
    txtFieldEmailAddress.adjustsFontSizeToFitWidth = YES;
    txtFieldEmailAddress.delegate = self;
    txtFieldEmailAddress.returnKeyType = UIReturnKeyNext;
    txtFieldEmailAddress.keyboardType = UIKeyboardTypeEmailAddress;
    txtFieldEmailAddress.textColor = colorTxtFieldText;
    txtFieldEmailAddress.backgroundColor = colorTxtFieldBG;
    txtFieldEmailAddress.layer.borderColor = [UIColor whiteColor].CGColor;
    [scrlViewProfile addSubview:txtFieldEmailAddress];
    
    yRef += 30+space;
    
    UILabel *lblConfirmPassword = [[UILabel alloc] initWithFrame:CGRectMake(20, yRef, 280, 30)];
    lblConfirmPassword.textColor = colorTitleText;
    lblConfirmPassword.text = @"Zip Code";
    lblConfirmPassword.font = [UIFont systemFontOfSize:14.0];
    lblConfirmPassword.backgroundColor = [UIColor clearColor];
    [scrlViewProfile addSubview:lblConfirmPassword];
    yRef += lblConfirmPassword.frame.size.height+space;
    
    txtFieldZipCode = [[UITextField alloc] initWithFrame:CGRectMake(20, yRef, 280, 30)];
    txtFieldZipCode.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtFieldZipCode.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    txtFieldZipCode.text = [NSString stringWithFormat:@"%li", (long)appDelegate.objUserLogedIn.intZipCode];
    txtFieldZipCode.delegate = self;
    txtFieldZipCode.font =  fontValue;
    txtFieldZipCode.returnKeyType = UIReturnKeyNext;
    txtFieldZipCode.textColor = colorTxtFieldText;
    txtFieldZipCode.backgroundColor = colorTxtFieldBG;
    txtFieldZipCode.layer.borderColor = [UIColor whiteColor].CGColor;
    [scrlViewProfile addSubview:txtFieldZipCode];
    
    yRef += 30+space;

    UILabel *lblSchoolTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, yRef, 100, 30)];
    lblSchoolTitle.text = @"School";
    lblSchoolTitle.font = [UIFont systemFontOfSize:14.0];
    lblSchoolTitle.backgroundColor = [UIColor clearColor];
    lblSchoolTitle.textColor = colorTitleText;
    [scrlViewProfile addSubview:lblSchoolTitle];
    lblSchoolTitle = nil;
    
    yRef += 30;

    btnSchool = [[UIButton alloc] initWithFrame:CGRectMake(20, yRef, 280, 30)];
    btnSchool.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnSchool setTitle:appDelegate.objUserLogedIn.strSchoolID forState:UIControlStateNormal];
    btnSchool.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnSchool setTitleColor:colorTxtFieldText forState:UIControlStateNormal];
    [btnSchool setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    btnSchool.backgroundColor = colorTxtFieldBG;
    btnSchool.layer.borderColor = [UIColor whiteColor].CGColor;
//    btnSchool.layer.borderWidth = 1.0;
//    btnSchool.layer.cornerRadius = 5.0;
    [btnSchool addTarget:self action:@selector(btnSchoolClicked) forControlEvents:UIControlEventTouchUpInside];
    btnSchool.titleLabel.numberOfLines = 2;
    [scrlViewProfile addSubview:btnSchool];

    yRef += 40+space;

    [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Fetching schools..."];
    
    [self getSchoolsOfZipCode:txtFieldZipCode.text];

    
    UILabel *lblUsername = [[UILabel alloc] initWithFrame:CGRectMake(20, yRef, 200, 30)];
    lblUsername.text = @"Username";
    lblUsername.font = [UIFont systemFontOfSize:14.0];
    lblUsername.backgroundColor = [UIColor clearColor];
    lblUsername.textColor = colorTitleText;
    [scrlViewProfile addSubview:lblUsername];
    lblUsername = nil;

    yRef += 30;
    
    txtFieldUsername = [[UITextField alloc] initWithFrame:CGRectMake(20, yRef, 280, 30)];
    txtFieldUsername.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtFieldUsername.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    txtFieldUsername.text = appDelegate.objUserLogedIn.strUsername;
    txtFieldUsername.delegate = self;
    txtFieldUsername.font =  fontValue;
    txtFieldUsername.returnKeyType = UIReturnKeyNext;
    txtFieldUsername.textColor = colorTxtFieldText;
    txtFieldUsername.backgroundColor = colorTxtFieldBG;
    txtFieldUsername.layer.borderColor = [UIColor whiteColor].CGColor;
    [scrlViewProfile addSubview:txtFieldUsername];
    
    space = 10;
    yRef += 30+space;
    
    UILabel *lblChangePassword = [[UILabel alloc] initWithFrame:CGRectMake(20, yRef, 200, 30)];
    lblChangePassword.text = @"Change Password";
    lblChangePassword.font = [UIFont systemFontOfSize:14.0];
    lblChangePassword.backgroundColor = [UIColor clearColor];
    lblChangePassword.textColor = colorTitleText;
    [scrlViewProfile addSubview:lblChangePassword];
    lblChangePassword = nil;

    yRef += 30+space;
    
    txtFieldPassword = [[UITextField alloc] initWithFrame:CGRectMake(20, yRef, 280, 30)];
    txtFieldPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtFieldPassword.placeholder = @"Password";
    txtFieldPassword.text = @"";//appDelegate.objUserLogedIn.strPassword;
    txtFieldPassword.delegate = self;
    txtFieldPassword.font =  fontValue;
    txtFieldPassword.secureTextEntry = YES;
    txtFieldPassword.returnKeyType = UIReturnKeyNext;
    txtFieldPassword.textColor = colorTxtFieldText;
    txtFieldPassword.backgroundColor = colorTxtFieldBG;
    txtFieldPassword.layer.borderColor = [UIColor whiteColor].CGColor;
    [scrlViewProfile addSubview:txtFieldPassword];
    
    yRef += txtFieldPassword.frame.size.height+space;
    
    txtFieldNewPassword = [[UITextField alloc] initWithFrame:CGRectMake(20, yRef, 280, 30)];
    txtFieldNewPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtFieldNewPassword.placeholder = @"New Password";
    txtFieldNewPassword.delegate = self;
    txtFieldNewPassword.font =  fontValue;
    txtFieldNewPassword.secureTextEntry = YES;
    txtFieldNewPassword.returnKeyType = UIReturnKeyNext;
    txtFieldNewPassword.textColor = colorTxtFieldText;
    txtFieldNewPassword.backgroundColor = colorTxtFieldBG;
    txtFieldNewPassword.layer.borderColor = [UIColor whiteColor].CGColor;
    [scrlViewProfile addSubview:txtFieldNewPassword];
    
    yRef += txtFieldNewPassword.frame.size.height+space;

    txtFieldConfirmPassword = [[UITextField alloc] initWithFrame:CGRectMake(20, yRef, 280, 30)];
    txtFieldConfirmPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtFieldConfirmPassword.placeholder = @"Type new password again";
    txtFieldConfirmPassword.delegate = self;
    txtFieldConfirmPassword.font =  fontValue;
    txtFieldConfirmPassword.secureTextEntry = YES;
    txtFieldConfirmPassword.returnKeyType = UIReturnKeyDone;
    txtFieldConfirmPassword.textColor = colorTxtFieldText;
    txtFieldConfirmPassword.backgroundColor = colorTxtFieldBG;
    txtFieldConfirmPassword.layer.borderColor = [UIColor whiteColor].CGColor;
    [scrlViewProfile addSubview:txtFieldConfirmPassword];

    yRef += txtFieldConfirmPassword.frame.size.height+space;

    scrlViewProfile.contentSize = CGSizeMake(320, yRef+50);
}
- (void)btnMonthClicked
{
    if(datePicker==nil)
    {
        viewPickerBG = [[UIView alloc]initWithFrame:CGRectMake(0, 600, 320, 350)];
        viewPickerBG.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:viewPickerBG];
        
        datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 44, 320, 200)];
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.tag=104;
        datePicker.hidden = NO;
        
        NSLog(@"appDelegate.objUserLogedIn.strDOB = %@", appDelegate.objUserLogedIn.strDOB);
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        
        NSDate *dateTemp = [dateFormat dateFromString:appDelegate.objUserLogedIn.strDOB];
        NSLog(@"dateTemp = %@", dateTemp);
        
        datePicker.date = [dateFormat dateFromString:appDelegate.objUserLogedIn.strDOB]?[dateFormat dateFromString:appDelegate.objUserLogedIn.strDOB]:[NSDate date];
        strDateSelected = [dateFormat stringFromDate:datePicker.date];
        [viewPickerBG addSubview:datePicker];
        dateFormat = nil;
        
        datePickerToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, 320, 44)];
        [datePickerToolBar setTintColor:colorTheme];
        [viewPickerBG addSubview:datePickerToolBar];
        
        UIBarButtonItem *btnToolbarCancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelClickedDatePicker)];
        UIBarButtonItem *btnToolbarDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneClickedDatePicker)];
        
        UIBarButtonItem *spac=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        datePickerToolBar.items = [[NSArray alloc] initWithObjects:spac, btnToolbarCancel, btnToolbarDone,nil];
        
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    if(IS_IPHONE_5)
        viewPickerBG.center=CGPointMake(160, 490);
    else
        viewPickerBG.center=CGPointMake(160, 400);
    [UIView commitAnimations];
    
    [self resignAllTextFields];
    
    scrlViewProfile.contentOffset = CGPointMake(0, 30);
}

- (void)cancelClickedDatePicker
{
    [self hideDatePicker];
}
- (void)doneClickedDatePicker
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    strDateSelected = [dateFormat stringFromDate:datePicker.date];
    [btnDOB setTitle:strDateSelected forState:UIControlStateNormal];
    dateFormat = nil;
    
    [self hideDatePicker];
}
- (void)hideDatePicker
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.5];
    viewPickerBG.center=CGPointMake(160,750);
    [UIView commitAnimations];
}

#pragma mark - School 
- (void)btnSchoolClicked
{
    [self resignAllTextFields];

    if(pickerSchool==nil)
    {
        pickerSchool = [[UIPickerView alloc] init];
        pickerSchool.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.9];
//        pickerSchool.tag = tagSchool;
        pickerSchool.frame = CGRectMake(0, 600, 320, 200);
        pickerSchool.showsSelectionIndicator = YES;
        pickerSchool.delegate = self;
        pickerSchool.dataSource = self;
        [self.view addSubview:pickerSchool];


        btnPickerSchoolDone = [[UIButton alloc] initWithFrame:CGRectMake(320, IS_IPHONE_5?320:240, 77, 25)];
        [btnPickerSchoolDone setTitle:@"Done" forState:UIControlStateNormal];
        [btnPickerSchoolDone addTarget:self action:@selector(btnPickerSchoolDoneClicked) forControlEvents:UIControlEventTouchUpInside];
//        btnSave_I_am.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
        [btnPickerSchoolDone setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"btn_unselected_bg" ofType:@"png"]] forState:UIControlStateNormal];
        [btnPickerSchoolDone setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"btn_selected_bg" ofType:@"png"]] forState:UIControlStateHighlighted];
        [btnPickerSchoolDone setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"btn_selected_bg" ofType:@"png"]] forState:UIControlStateSelected];
        [self.view addSubview:btnPickerSchoolDone];
    }
    else
        [pickerSchool reloadComponent:0];
    
    [pickerSchool removeFromSuperview];
    [btnPickerSchoolDone removeFromSuperview];
    [self.view addSubview:pickerSchool];
    [self.view addSubview:btnPickerSchoolDone];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.29];
    [UIView setAnimationDelegate:nil];
    if(IS_IPHONE_5)
    {
        btnPickerSchoolDone.frame = CGRectMake(228, 386, 77, 25);
        pickerSchool.frame = CGRectMake(0, 386, 372, 180);
    }
    else
    {
        btnPickerSchoolDone.frame = CGRectMake(228, 300, 77, 25);
        pickerSchool.frame = CGRectMake(0, 300, 320, 180);
    }

    [UIView commitAnimations];
    
}
- (void)btnPickerSchoolDoneClicked
{
    [self hideSchoolPicker];
}
- (void)hideSchoolPicker
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.29];
    [UIView setAnimationDelegate:nil];
    btnPickerSchoolDone.frame = CGRectMake(320, IS_IPHONE_5?386:240, 77, 25);
    pickerSchool.frame = CGRectMake(0, 600, 320, 180);
    [UIView commitAnimations];
    
}

#pragma mark - UIPickerView
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [arrSchool count];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view;
{
    NSDictionary *dictSchool = [arrSchool objectAtIndex:row];
    NSString *strTitle = [dictSchool objectForKey:@"name"];
    
    UILabel *lblForRow = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 50)];
    lblForRow.textAlignment = NSTextAlignmentCenter;
    lblForRow.numberOfLines = 0;
    lblForRow.text = strTitle;
    return lblForRow;
}
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    NSString *strTitle = @"";
//    
//    strTitle = [arrSchool objectAtIndex:row];
//    return strTitle;
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    dictSelectedSchool = [arrSchool objectAtIndex:row];
    NSString *strTitle = [dictSelectedSchool objectForKey:@"name"];
    [btnSchool setTitle:strTitle forState:UIControlStateNormal];
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.5];

    textField.layer.borderWidth = 1.0;
    if([textField isEqual:txtFieldZipCode])
    {
        scrlViewProfile.contentOffset = CGPointMake(0, 150);
    }
    else if([textField isEqual:txtFieldUsername])
    {
        scrlViewProfile.contentOffset = CGPointMake(0, 250);
    }
    else if([textField isEqual:txtFieldPassword])
    {
        scrlViewProfile.contentOffset = CGPointMake(0, 400);
    }
    else if([textField isEqual:txtFieldNewPassword])
    {
        scrlViewProfile.contentOffset = CGPointMake(0, 400);
    }
    else if([textField isEqual:txtFieldConfirmPassword])
    {
        scrlViewProfile.contentOffset = CGPointMake(0, 400);
    }
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.layer.borderWidth = 0.0;
    //    if([textField isEqual:txtFieldConfirmPassword])
    //        scrlView.contentOffset = CGPointMake(0, 100);
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([textField isEqual:txtFieldZipCode])
    {
        NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        
        if ([string rangeOfCharacterFromSet:notDigits].location == NSNotFound && [txtFieldZipCode.text length]<10)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([textField isEqual:txtFieldFirstname])//Profile
    {
        if([txtFieldFirstname.text length]==0)
            [self showAlertWithOKAndMessage:@"Please enter the firstname."];
        else
        {
            [txtFieldFirstname resignFirstResponder];
            [self btnMonthClicked];
        }
    }
    else if([textField isEqual:txtFieldEmailAddress])
    {
        NSString *str_email=txtFieldEmailAddress.text;
        NSString *emailEx =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailExPredicate =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailEx];
        BOOL emailValidation = [emailExPredicate evaluateWithObject:str_email];
        
        if (emailValidation)
            [txtFieldZipCode becomeFirstResponder];
        else
            [self showAlertWithOKAndMessage:@"Please enter valid email id."];
    }
    else if([textField isEqual:txtFieldZipCode])
    {
        if([txtFieldZipCode.text length]==0)
            [self showAlertWithOKAndMessage:@"Please enter zip code."];
        else
        {
            [txtFieldZipCode resignFirstResponder];
            scrlViewProfile.contentOffset = CGPointMake(0, 0);
            if(appDelegate.objUserLogedIn.intZipCode!=[txtFieldZipCode.text integerValue])
            {
                [self checkZipCode:txtFieldZipCode.text];
            }
        }
    }
    else if ([textField isEqual:txtFieldUsername])
    {
        if([txtFieldUsername.text length]==0)
            [self showAlertWithOKAndMessage:@"Please enter the username."];
        else
        {
            if(![appDelegate.objUserLogedIn.strUsername isEqualToString:txtFieldUsername.text])
            {
                [self checkUsername:txtFieldUsername.text];
            }
        }
    }
    else if ([textField isEqual:txtFieldPassword])
    {
        if([txtFieldPassword.text length]==0)
            [self showAlertWithOKAndMessage:@"Please enter the password."];
        else if([txtFieldPassword.text isEqualToString:appDelegate.objUserLogedIn.strPassword])
            [txtFieldNewPassword becomeFirstResponder];
        else
            [self showAlertWithOKAndMessage:@"Incorrect password."];
    }
    else if([textField isEqual:txtFieldNewPassword])
    {
        if([txtFieldNewPassword.text length]==0)
            [self showAlertWithOKAndMessage:@"Please enter confirm password."];
        else
        {
            [txtFieldConfirmPassword becomeFirstResponder];
//            scrlView.contentOffset = CGPointMake(0, 0);
        }
    }
    else if([textField isEqual:txtFieldConfirmPassword])
    {
        if([txtFieldConfirmPassword.text length]==0)
            [self showAlertWithOKAndMessage:@"Please enter confirm password."];
        else if([txtFieldNewPassword.text length] <8 || [txtFieldConfirmPassword.text length]<8)
            [self showAlertWithOKAndMessage:@"New password must be at least 8 charectors."];
        else if(![txtFieldNewPassword.text isEqualToString:txtFieldConfirmPassword.text])
        {
            [self showAlertWithOKAndMessage:@"New password not matching with confirm password."];
        }
        else
        {
            [txtFieldConfirmPassword resignFirstResponder];
            scrlViewProfile.contentOffset = CGPointMake(0, 0);
        }
    }
    return YES;
}

#pragma mark - Parser
- (void)updateProfileToTheServer
{
//    Body : first=dilipSaketd&dob=2002-07-13&zipcode=99507&schoolid=19742

    NSString *strUpdate = @"";
    
    if(![appDelegate.objUserLogedIn.strFirstname isEqualToString:txtFieldFirstname.text])
        strUpdate = [strUpdate stringByAppendingString:[NSString stringWithFormat:@"first=%@",txtFieldFirstname.text]];
    if(![appDelegate.objUserLogedIn.strDOB isEqualToString:[btnDOB titleForState:UIControlStateNormal]])
        strUpdate = [strUpdate stringByAppendingString:[NSString stringWithFormat:@"%@dob=%@", [strUpdate length]>0?@"&":@"", [btnDOB titleForState:UIControlStateNormal]]];
    if(appDelegate.objUserLogedIn.intZipCode!=[txtFieldZipCode.text integerValue])
        strUpdate = [strUpdate stringByAppendingString:[NSString stringWithFormat:@"%@zipcode=%@", [strUpdate length]>0?@"&":@"", txtFieldZipCode.text]];
    if(dictSelectedSchool!=nil)
    {
        NSString *strTempSchoolID = [dictSelectedSchool objectForKey:@"id"];
        if(![appDelegate.objUserLogedIn.strSchoolID isEqualToString:strTempSchoolID])
            strUpdate = [strUpdate stringByAppendingString:[NSString stringWithFormat:@"%@schoolid=%@", [strUpdate length]>0?@"&":@"", strTempSchoolID]];
    }
    if(![appDelegate.objUserLogedIn.strUsername isEqualToString:txtFieldUsername.text])
        strUpdate = [strUpdate stringByAppendingString:[NSString stringWithFormat:@"%@username=%@", [strUpdate length]>0?@"&":@"", txtFieldUsername.text]];
    if([txtFieldConfirmPassword.text length]>0)
        strUpdate = [strUpdate stringByAppendingString:[NSString stringWithFormat:@"%@password=%@", [strUpdate length]>0?@"&":@"", txtFieldConfirmPassword.text]];
    
    if([strUpdate length]>0)
    {
        [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                          withLabel:@"Updating..."];
        [objUpdateProfileBL updateUser:strUpdate];
    }
    else
    {
        [self showAlertWithOKAndMessage:@"No any changes done."];
    }
}

- (void)UpdateProfileParserFinished:(NSDictionary *)dictOffers
{
    [DSBezelActivityView removeViewAnimated:YES];
    if([dictOffers objectForKey:@"statusDescription"])
        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:[dictOffers objectForKey:@"statusDescription"] waitUntilDone:NO];
    else
    {
        NSArray *arrTemp = [dictOffers objectForKey:@"first"];
        if([arrTemp count]>0)
            [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:[arrTemp objectAtIndex:0] waitUntilDone:NO];
    }
}

- (void)errorInParseing:(NSError *)error
{
    [DSBezelActivityView removeViewAnimated:YES];
    [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Internet connection appears to be offline." waitUntilDone:NO];
}

#pragma mark - SchoolsOfZipCode Parser
- (void)getSchoolsOfZipCode:(NSString *)strZipCode
{
    [objUpdateProfileBL getSchoolsOfZipCode:strZipCode];
}
- (void)SchoolsByZipCodeParserFinished:(NSDictionary *)dictData
{
    [DSBezelActivityView removeViewAnimated:YES];

    if ([[dictData objectForKey:@"statusDescription"] isEqualToString:@"Success"])
    {
        [arrSchool removeAllObjects];
        [arrSchool addObjectsFromArray:[dictData objectForKey:@"schools"]];
        NSArray *filteredarray = [arrSchool filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(id == %@)", appDelegate.objUserLogedIn.strSchoolID]];

        if([filteredarray count]>0)
        {
            dictSelectedSchool = [filteredarray objectAtIndex:0];
            [btnSchool setTitle:[dictSelectedSchool objectForKey:@"name"] forState:UIControlStateNormal];
        }
        else
            [btnSchool setTitle:appDelegate.objUserLogedIn.strSchoolID forState:UIControlStateNormal];
    }
}

#pragma mark - ZipCode Parser
- (void)checkZipCode:(NSString *)strZipCode
{
    [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Validating zipcode..."];
    [objUpdateProfileBL checkZipCode:strZipCode];
}

- (void)ZipCodeValidatorParserFinished:(NSDictionary *)dictData
{
    if ([[dictData objectForKey:@"statusDescription"] isEqualToString:@"Success"])
    {
        [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                          withLabel:@"Fetching schools..."];

        [self getSchoolsOfZipCode:txtFieldZipCode.text];
    }
    else
    {
        [DSBezelActivityView removeViewAnimated:YES];

        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:[dictData objectForKey:@"statusDescription"] waitUntilDone:NO];
    }
}

#pragma mark - Username

- (void)checkUsername:(NSString *)strUserName
{
    [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Validating username..."];

    [objUpdateProfileBL checkUsernameExist:strUserName];
}
- (void)UsernameValidatorParserFinished:(NSDictionary *)dictData
{

    if ([[dictData objectForKey:@"statusDescription"] isEqualToString:@"Success"])
    {
        [self resignAllTextFields];
//        [txtFieldPassword becomeFirstResponder];
        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Username available." waitUntilDone:NO];
    }
    else
    {
        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:[dictData objectForKey:@"statusDescription"] waitUntilDone:NO];
    }
    [DSBezelActivityView removeViewAnimated:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
