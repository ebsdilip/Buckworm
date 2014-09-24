//
//  BW_Register_ViewController.m
//  Buckworm
//
//  Created by Developer on 6/10/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_Register_ViewController.h"

#define tagSchool 10001
#define tagIam 10002

@interface BW_Register_ViewController ()

@end

@implementation BW_Register_ViewController

- (void)clearMemory
{
    objSignUpBL.callBack = nil;
    objSignUpBL = nil;
    
    objLoginBL.callBack = nil;
    objLoginBL = nil;
    
    scrlView = nil;
    
    txtFieldUsername.delegate = nil;
    txtFieldEmailAddress.delegate = nil;
    txtFieldPassword.delegate = nil;
    txtFieldConfirmPassword.delegate = nil;

    txtFieldUsername = nil;
    txtFieldEmailAddress = nil;
    txtFieldPassword = nil;
    txtFieldConfirmPassword = nil;

    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        objSignUpBL = [[BW_SignUp_BL alloc] init];
        objSignUpBL.callBack = self;
        
        objLoginBL = [[BW_Login_BL alloc] init];
        objLoginBL.callBack = self;
        
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
    [txtFieldEmailAddress resignFirstResponder];
    [txtFieldPassword resignFirstResponder];
    [txtFieldConfirmPassword resignFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self screenDesignForSimpleSignUp];
    [self showBackButton];
    lblBarTitle.text = @"SIGN UP";

}

- (void)screenDesignForSimpleSignUp
{
    scrlView = [[UIScrollView alloc] init];
    scrlView.backgroundColor = [UIColor clearColor];
    scrlView.frame = CGRectMake(0, 64, 320, 320);
    scrlView.contentSize = CGSizeMake(320, 500);
    scrlView.pagingEnabled = YES;
//    scrlView.scrollEnabled = NO;
    [self.view addSubview:scrlView];

    float yRef = 20.0;
    float space = 0.0;
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    lblTitle.text = @"Sign Up";
    lblTitle.font = [UIFont boldSystemFontOfSize:18];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:0.5];
    lblTitle.textColor = [UIColor darkGrayColor];
    [self.view addSubview:lblTitle];

    UILabel *lblUsername = [[UILabel alloc] initWithFrame:CGRectMake(20, yRef, 100, 30)];
    lblUsername.text = @"Username";
    lblUsername.font = [UIFont boldSystemFontOfSize:14.0];
    lblUsername.backgroundColor = [UIColor clearColor];
    lblUsername.textColor = [UIColor darkGrayColor];
    [scrlView addSubview:lblUsername];
    yRef += lblUsername.frame.size.height+space;
    lblUsername = nil;
    
    txtFieldUsername = [[UITextField alloc] initWithFrame:CGRectMake(20, yRef, 280, 30)];
    txtFieldUsername.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtFieldUsername.placeholder = @"";
    txtFieldUsername.font = [UIFont systemFontOfSize:14.0];
    txtFieldUsername.delegate = self;
    txtFieldUsername.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtFieldUsername.returnKeyType = UIReturnKeyNext;
    txtFieldUsername.textColor = [UIColor grayColor];
    txtFieldUsername.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    txtFieldUsername.layer.borderColor = [UIColor whiteColor].CGColor;
    [scrlView addSubview:txtFieldUsername];
    
    yRef += txtFieldUsername.frame.size.height+space+20;
    
    UILabel *lblEmail = [[UILabel alloc] initWithFrame:CGRectMake(20, yRef, 280, 30)];
    lblEmail.textColor = [UIColor darkGrayColor];
    lblEmail.text = @"Email Address";
    lblEmail.font = [UIFont boldSystemFontOfSize:14.0];
    lblEmail.backgroundColor = [UIColor clearColor];
    [scrlView addSubview:lblEmail];
    yRef += lblEmail.frame.size.height+space;
    lblEmail = nil;
    
    txtFieldEmailAddress = [[UITextField alloc] initWithFrame:CGRectMake(20, yRef, 280, 30)];
    txtFieldEmailAddress.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtFieldEmailAddress.placeholder = @"";
    txtFieldEmailAddress.font = [UIFont systemFontOfSize:13.0];
    txtFieldEmailAddress.delegate = self;
    txtFieldEmailAddress.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtFieldEmailAddress.returnKeyType = UIReturnKeyNext;
    txtFieldEmailAddress.keyboardType = UIKeyboardTypeEmailAddress;
    txtFieldEmailAddress.textColor = [UIColor grayColor];
    txtFieldEmailAddress.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    txtFieldEmailAddress.layer.borderColor = [UIColor whiteColor].CGColor;
    [scrlView addSubview:txtFieldEmailAddress];
    
    yRef += txtFieldEmailAddress.frame.size.height+space+20;
    
    UILabel *lblPassword = [[UILabel alloc] initWithFrame:CGRectMake(20, yRef, 280, 30)];
    lblPassword.textColor = [UIColor darkGrayColor];
    lblPassword.text = @"Password";
    lblPassword.font = [UIFont boldSystemFontOfSize:14.0];
    lblPassword.backgroundColor = [UIColor clearColor];
    [scrlView addSubview:lblPassword];
    yRef += lblPassword.frame.size.height+space;
    lblPassword = nil;
    
    txtFieldPassword = [[UITextField alloc] initWithFrame:CGRectMake(20, yRef, 280, 30)];
    txtFieldPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtFieldPassword.placeholder = @"";
    txtFieldPassword.font = [UIFont systemFontOfSize:14.0];
    txtFieldPassword.delegate = self;
    txtFieldPassword.secureTextEntry = YES;
    txtFieldPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtFieldPassword.returnKeyType = UIReturnKeyNext;
    txtFieldPassword.textColor = [UIColor grayColor];
    txtFieldPassword.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    txtFieldPassword.layer.borderColor = [UIColor whiteColor].CGColor;
    [scrlView addSubview:txtFieldPassword];
    
    yRef += txtFieldPassword.frame.size.height+space+20;
    
    UILabel *lblConfirmPassword1 = [[UILabel alloc] initWithFrame:CGRectMake(20, yRef, 280, 30)];
    lblConfirmPassword1.textColor = [UIColor darkGrayColor];
    lblConfirmPassword1.text = @"Confirm Password";
    lblConfirmPassword1.font = [UIFont boldSystemFontOfSize:14.0];
    lblConfirmPassword1.backgroundColor = [UIColor clearColor];
    [scrlView addSubview:lblConfirmPassword1];
    yRef += lblConfirmPassword1.frame.size.height+space;
    lblConfirmPassword1 = nil;
    
    txtFieldConfirmPassword = [[UITextField alloc] initWithFrame:CGRectMake(20, yRef, 280, 30)];
    txtFieldConfirmPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtFieldConfirmPassword.placeholder = @"";
    txtFieldConfirmPassword.font = [UIFont systemFontOfSize:14.0];
    txtFieldConfirmPassword.delegate = self;
    txtFieldConfirmPassword.secureTextEntry = YES;
    txtFieldConfirmPassword.returnKeyType = UIReturnKeyDone;
    txtFieldConfirmPassword.textColor = [UIColor grayColor];
    txtFieldConfirmPassword.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    txtFieldConfirmPassword.layer.borderColor = [UIColor whiteColor].CGColor;
    [scrlView addSubview:txtFieldConfirmPassword];
    
    yRef = 330;
    
    if(self.navigationController)
    {
        UIBarButtonItem *btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        
        btnSpace.width = [BWAppDelegate isCurrentVersionBelongToiOS7]?110:120;
        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"SUBMIT" style:UIBarButtonItemStyleBordered target:self action:@selector(submitProfile)];
        
        [self setToolbarItems:[NSArray arrayWithObjects:btnSpace, anotherButton, nil] animated:YES];
    }
    else
    {
        UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(160, 44+370, 140, 40)];
        [btnCancel setTitle:@"CANCEL" forState:UIControlStateNormal];
        [btnCancel addTarget:self action:@selector(cancelRegistration) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnCancel];

        UIButton *btnSubmit = [[UIButton alloc] initWithFrame:CGRectMake(20, 44+370, 140, 40)];
        [btnSubmit setTitle:@"SUBMIT" forState:UIControlStateNormal];
        [btnSubmit addTarget:self action:@selector(submitProfile) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnSubmit];
        
        btnSubmit.layer.borderColor = [UIColor whiteColor].CGColor;
        btnSubmit.layer.borderWidth = 1.0;

        btnCancel.layer.borderColor = [UIColor whiteColor].CGColor;
        btnCancel.layer.borderWidth = 1.0;

        [btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnCancel setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        btnCancel.backgroundColor = colorGreen;

        [btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnSubmit setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        btnSubmit.backgroundColor = colorGreen;

        btnSubmit.titleLabel.font = [UIFont systemFontOfSize:14.0];
        btnCancel.titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        lblTitle.frame = CGRectMake(0, 0, 320, 50);
        
        btnSubmit = nil;
        btnCancel = nil;
    }
    lblTitle = nil;
}
- (void)cancelRegistration
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)submitProfile
{
    //username=abcxyz&email=abc%40ex ample.com&password=a12345678&f irst=ab&dob=2001­01­01&user_type =S&zipcode=00501&schoolid=19743
    //    NSString *postString = [NSString stringWithFormat:@"username=%@&email=%@&password=%@", strUserName, strEmailID, strPassword];
    //    NSLog(@"postString = %@", postString);

    if([txtFieldUsername.text length]==0)
    {
        [self showAlertWithOKAndMessage:@"Please enter the username."];
    }
    else if([txtFieldPassword.text length]==0)
    {
        [self showAlertWithOKAndMessage:@"Please enter the password."];
    }
    else if([txtFieldConfirmPassword.text length]==0)
    {
        [self showAlertWithOKAndMessage:@"Please enter confirm password."];
    }
    else if(![txtFieldConfirmPassword.text isEqualToString:txtFieldPassword.text])
    {
        [self showAlertWithOKAndMessage:@"password and confirm password not matched"];
    }
    else
    {
        NSString *str_email=txtFieldEmailAddress.text;
        NSString *emailEx =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailExPredicate =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailEx];
        BOOL emailValidation = [emailExPredicate evaluateWithObject:str_email];
        
        if (emailValidation)
        {
            NSString *postString = [NSString stringWithFormat:@"username=%@&email=%@&password=%@", txtFieldUsername.text, txtFieldEmailAddress.text, txtFieldPassword.text];
            [self getSignUp:postString];
        }
        else
        {
            [self showAlertWithOKAndMessage:@"Please enter valid email id."];
        }
    }
    
}
#pragma Mark - Parser SignUp
- (void)getSignUp:(NSString *)strDataString
{
    [DSBezelActivityView newActivityViewForView:self.view
                                      withLabel:@"Please wait..."];
    
    [objSignUpBL signUpUser:strDataString];
}
- (void)errorInParseing:(NSError *)error
{
    [DSBezelActivityView removeViewAnimated:YES];
    [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Internet connection appears to be offline." waitUntilDone:NO];
}
- (void)SignUpParserFinished:(NSDictionary *)dictProfile
{
    [DSBezelActivityView removeViewAnimated:YES];
    NSLog(@"signUp = %@", dictProfile);
    if(dictProfile)
    {
        NSString *strMsg = [dictProfile objectForKey:@"statusDescription"];        
        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:strMsg waitUntilDone:NO];
    }
//    if(appDelegate.objUserLogedIn)
//        [self gotoOfferPage];
//    else
//        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Please enter correct username and password." waitUntilDone:NO];
}

#pragma mark - Login Parser
- (void)getLogin
{
    [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Connecting..."];
    [objLoginBL getLogin:txtFieldUsername.text andPassword:txtFieldPassword.text];
}
- (void)LoginParserFinished:(NSDictionary *)dictProfile
{
    [DSBezelActivityView removeViewAnimated:YES];
    
    if(appDelegate.objUserLogedIn)
        [self gotoOfferPage];
    else
        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Please enter correct username and password." waitUntilDone:NO];
}

- (void)gotoOfferPage
{
    [self resignAllTextFields];
    
//    UIViewController *objVC = [[UIViewController alloc] init];
//    [self.navigationController pushViewController:objVC animated:YES];
//    objVC = nil;
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.layer.borderWidth = 1.0;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:nil];

    if([textField isEqual:txtFieldPassword])
    {
        scrlView.contentOffset = CGPointMake(0, 180);
    }
    else if([textField isEqual:txtFieldConfirmPassword])
    {
        scrlView.contentOffset = CGPointMake(0, 200);
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
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:txtFieldUsername])
    {
        if([txtFieldUsername.text length]==0)
            [self showAlertWithOKAndMessage:@"Please enter the username."];
        else
            [txtFieldEmailAddress becomeFirstResponder];
    }
    else if([textField isEqual:txtFieldEmailAddress])
    {
        NSString *str_email=txtFieldEmailAddress.text;
        NSString *emailEx =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailExPredicate =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailEx];
        BOOL emailValidation = [emailExPredicate evaluateWithObject:str_email];
        
        if (emailValidation)
            [txtFieldPassword becomeFirstResponder];
        else
            [self showAlertWithOKAndMessage:@"Please enter valid email id."];
    }
    else if ([textField isEqual:txtFieldPassword])
    {
        if([txtFieldPassword.text length]==0)
            [self showAlertWithOKAndMessage:@"Please enter the password."];
        else
            [txtFieldConfirmPassword becomeFirstResponder];
    }
    else if([textField isEqual:txtFieldConfirmPassword])
    {
        if([txtFieldConfirmPassword.text length]==0)
            [self showAlertWithOKAndMessage:@"Please enter confirm password."];
        else
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationDelegate:nil];
            [txtFieldConfirmPassword resignFirstResponder];
            scrlView.contentOffset = CGPointMake(0, 0);
            [UIView commitAnimations];
        }
    }
    return YES;
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
