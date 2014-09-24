//
//  BW_Login_ViewController.m
//  Buckworm
//
//  Created by Developer on 6/10/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_Login_ViewController.h"
#import "BW_Register_ViewController.h"
#import "BWViewController.h"
#import "BWMyCouponsViewController.h"
#import "BWOfferDetailViewController.h"
#import "BW_More_ViewController.h"

@interface BW_Login_ViewController ()

@end

@implementation BW_Login_ViewController

@synthesize callBack;
@synthesize isMore;

- (void)clearMemory
{
    txtFieldUsername.delegate = nil;
    txtFieldPassword.delegate = nil;
    txtFieldUsername = nil;
    txtFieldPassword = nil;
    
    objLoginBL.callBack = nil;
    objLoginBL = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        objLoginBL = [[BW_Login_BL alloc] init];
        objLoginBL.callBack = self;
    }
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [txtFieldUsername resignFirstResponder];
    [txtFieldPassword resignFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showBackButton];
    lblBarTitle.text = @"LOGIN";
    [self screenDesigning];
}
- (void)screenDesigning
{
    float yRef = 64+50.0;
    float space = 15.0;
    UIColor *textColor = [UIColor grayColor];
    if(IS_IPHONE_5)
    {
        yRef = 64+80.0;
    }
    txtFieldUsername = [[UITextField alloc] initWithFrame:CGRectMake(20, yRef, 280, 40)];
    txtFieldUsername.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtFieldUsername.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtFieldUsername.placeholder = @"Username";
    txtFieldUsername.delegate = self;
    txtFieldUsername.returnKeyType = UIReturnKeyNext;
    txtFieldUsername.textColor = textColor;
    txtFieldUsername.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    txtFieldUsername.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:txtFieldUsername];

    yRef += txtFieldUsername.frame.size.height+space;
    
    txtFieldPassword = [[UITextField alloc] initWithFrame:CGRectMake(20, yRef, 280, 40)];
    txtFieldPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtFieldPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    txtFieldPassword.placeholder = @"Password";
    txtFieldPassword.delegate = self;
    txtFieldPassword.secureTextEntry = YES;
    txtFieldPassword.returnKeyType = UIReturnKeyDone;
    txtFieldPassword.textColor = textColor;
    txtFieldPassword.backgroundColor = textFieldBGColor;
    txtFieldPassword.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    txtFieldPassword.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:txtFieldPassword];

    yRef += txtFieldPassword.frame.size.height+space+20;
    

    UIButton *btnSignIn = [[UIButton alloc] initWithFrame:CGRectMake(90, yRef, 140, 30)];
    [btnSignIn setTitle:@"SIGN IN" forState:UIControlStateNormal];
    btnSignIn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    [btnSignIn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSignIn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    btnSignIn.backgroundColor = colorGreen;
    [btnSignIn addTarget:self action:@selector(signInClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSignIn];
    
    yRef += btnSignIn.frame.size.height+space;

    UIButton *btnForgotPassword = [[UIButton alloc] initWithFrame:CGRectMake(90, yRef, 140, 30)];
    //    btnForgotPassword.layer.borderColor = [UIColor whiteColor].CGColor;
    //    btnForgotPassword.layer.borderWidth = 0.5;
    btnForgotPassword.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [btnForgotPassword setTitleColor:colorGreen forState:UIControlStateNormal];
    [btnForgotPassword setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    btnForgotPassword.backgroundColor = [UIColor clearColor];
    [btnForgotPassword addTarget:self action:@selector(forgotPasswordClicked) forControlEvents:UIControlEventTouchUpInside];
    [btnForgotPassword setTitle:@"Forgot password?" forState:UIControlStateNormal];
    [self.view addSubview:btnForgotPassword];
    
    yRef += btnForgotPassword.frame.size.height+space;
    btnForgotPassword = nil;

    if(IS_IPHONE_5)
        yRef += btnSignIn.frame.size.height+space;

    btnSignIn = nil;

    UILabel *lblDoNotHaveAccount = [[UILabel alloc] initWithFrame:CGRectMake(20, yRef, 280, 30)];
    lblDoNotHaveAccount.text = @"Don't have an account?";
    lblDoNotHaveAccount.font = [UIFont systemFontOfSize:14.0];
    lblDoNotHaveAccount.backgroundColor = [UIColor clearColor];
    lblDoNotHaveAccount.textColor = [UIColor grayColor];
    lblDoNotHaveAccount.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lblDoNotHaveAccount];
    
    yRef += lblDoNotHaveAccount.frame.size.height+space;
    lblDoNotHaveAccount = nil;

    UIButton *btnSignUp = [[UIButton alloc] initWithFrame:CGRectMake(90, yRef, 140, 30)];
    [btnSignUp setTitle:@"SIGN UP" forState:UIControlStateNormal];
    [btnSignUp setTitleColor:textColor forState:UIControlStateNormal];
    btnSignUp.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    [btnSignUp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSignUp setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    btnSignUp.backgroundColor = colorGreen;
    [btnSignUp addTarget:self action:@selector(signUpClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSignUp];
    btnSignUp = nil;
    
//    if(isInDeveloperMode==YES)
    {
//        txtFieldUsername.text = @"ney_bw";
//        txtFieldPassword.text = @"buckworm123";
//
//        txtFieldUsername.text = @"nlanjewar@engtelegent.com";
//        txtFieldPassword.text = @"buckworm123";

        txtFieldUsername.text = @"jduffy";
//        txtFieldUsername.text = @"dks";
        txtFieldPassword.text = @"buckworm123";
    }
}
- (void)viewWillAppear:(BOOL)animate
{
    [super viewWillAppear:animate];
}

- (void)forgotPasswordClicked
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Are you sure? It will change your previous password." delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    alert.tag = 1001;
    [alert show];
    alert = nil;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1001 && buttonIndex==0)
    {
        [self forgotPassword];
    }
}

#pragma mark - Action Methods
- (void)signInClicked
{
    if([txtFieldUsername.text length]==0)
    {
        [self showAlertWithOKAndMessage:@"Please enter the username."];
    }
    else if([txtFieldPassword.text length]==0)
    {
        [self showAlertWithOKAndMessage:@"Please enter the password."];
    }
    else
    {
        // Goto Offer page after authenticat
        if(isInDeveloperMode==YES)
        {
            [self gotoOfferPage];
        }
        else
        {
            if(appDelegate.isNetAvailable)
                [self getLogin];
            else
                [self performSelectorOnMainThread:@selector(noInternetMessage) withObject:nil waitUntilDone:NO];
        }
    }
}

- (void)gotoOfferPage
{
    [txtFieldUsername resignFirstResponder];
    [txtFieldPassword resignFirstResponder];
    
    if(self.navigationController)
        [self.navigationController popViewControllerAnimated:YES];
    else
        [self dismissViewControllerAnimated:YES completion:nil];

    if([self.callBack isKindOfClass:[BWViewController class]])
    {
        if (isMore==YES) {
            BW_More_ViewController *objVC = [[BW_More_ViewController alloc] init];
            objVC.callbackToHome = self.navigationController?self:self.callBack;
            [self.callBack.navigationController pushViewController:objVC animated:YES];
            objVC = nil;
        }
        else
        {
            BWMyCouponsViewController *objVC = [[BWMyCouponsViewController alloc] init];
            [self.callBack.navigationController pushViewController:objVC animated:YES];
            objVC = nil;
        }
    }
    else if([self.callBack isKindOfClass:[BWOfferDetailViewController class]])
    {
    }
}
- (void)signUpClicked
{
    // Goto SignUp page
//    if([self.callBack isKindOfClass:[BWMyCouponsViewController class]])
    {
        BW_Register_ViewController *objVC = [[BW_Register_ViewController alloc] init];
//        [self.callBack.navigationController pushViewController:objVC animated:YES];
        [self presentViewController:objVC animated:YES completion:nil];
        objVC = nil;
    }
}

#pragma mark - Login Parser
- (void)getLogin
{
    [DSBezelActivityView newActivityViewForView:self.view
                                      withLabel:@"Connecting..."];
    [objLoginBL getLogin:txtFieldUsername.text andPassword:txtFieldPassword.text];
}
- (void)errorInParseing:(NSError *)error
{
    [DSBezelActivityView removeViewAnimated:YES];
    [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Internet connection appears to be offline." waitUntilDone:NO];
}

- (void)LoginParserFinished:(NSDictionary *)dictProfile
{        

    [DSBezelActivityView removeViewAnimated:YES];
    
    if(appDelegate.objUserLogedIn)
    {
        appDelegate.objUserLogedIn.strPassword = txtFieldPassword.text;
        [self gotoOfferPage];
    }
    else if(dictProfile && [dictProfile objectForKey:@"statusDescription"])
//        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:[dictProfile objectForKey:@"statusDescription"] waitUntilDone:NO];
//    else
        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Please enter correct username and password." waitUntilDone:NO];
}
#pragma mark - Forgot Password Parser
- (void)forgotPassword
{
    [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Sending request..."];
    [objLoginBL forgotPasswordUser:txtFieldUsername.text];
}

- (void)ForgotPasswordParserFinished:(NSDictionary *)dictData
{
    if ([[dictData objectForKey:@"statusDescription"] isEqualToString:@"Your password have been reset. Please check your email."])
        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Your new password has been generated and sent to the email associated with your account." waitUntilDone:NO];
    [DSBezelActivityView removeViewAnimated:YES];

//    NSLog(<#NSString *format, ...#>)
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.layer.borderWidth = 1.0;
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
            [txtFieldPassword becomeFirstResponder];
    }
    else
    {
        if([txtFieldPassword.text length]==0)
            [self showAlertWithOKAndMessage:@"Please enter the password."];
        else
            [txtFieldPassword resignFirstResponder];
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
