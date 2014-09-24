//
//  BW_More_ViewController.m
//  Buckworm
//
//  Created by Developer on 6/10/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_More_ViewController.h"
#import "BW_MoreDetails_ViewController.h"
#import "BW_MyCards_ViewController.h"
#import "BW_UpdateProfile_ViewController.h"

@interface BW_More_ViewController ()

@end

@implementation BW_More_ViewController

@synthesize callbackToHome;

- (void)clearMemory
{
    tblMoreOptions.delegate = nil;
    tblMoreOptions.dataSource = nil;
    tblMoreOptions = nil;
    arrOptions = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBackButton];
    lblBarTitle.text = @"MORE";

    if(appDelegate.objUserLogedIn==nil)
        arrOptions = [[NSArray alloc] initWithObjects:@"Privacy Policy", @"Feedback", @"Contact Us", @"Help", nil];
    else
        arrOptions = [[NSArray alloc] initWithObjects:@"Privacy Policy", @"Feedback", @"Update Profile", @"Contact Us", @"Help", @"My Cards", @"Signout", nil];

    [self screenDesigning];
}

- (void)screenDesigning
{
    tblMoreOptions = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, 372+22)];
    tblMoreOptions.backgroundColor = [UIColor whiteColor];
    tblMoreOptions.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tblMoreOptions.delegate = self;
    tblMoreOptions.dataSource = self;
    [self.view addSubview:tblMoreOptions];
    
}


#pragma mark -
#pragma mark TableView Delegate Datasource Methods
#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrOptions count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *viewFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    UILabel *lblVersion = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 20)];
    lblVersion.text = versionNumber;
    lblVersion.font = [UIFont systemFontOfSize:14.0];
    lblVersion.adjustsFontSizeToFitWidth = YES;
    lblVersion.textColor = [UIColor darkGrayColor];
    lblVersion.backgroundColor = [UIColor clearColor];
    [viewFooter addSubview:lblVersion];

    viewFooter.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1.0];
    return viewFooter;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    viewHeader.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1.0];
    
//    UILabel *lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    lblHeader.text = @"More";
//    lblHeader.textAlignment = NSTextAlignmentCenter;
//    lblHeader.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
//    lblHeader.textColor = [UIColor orangeColor];
//    lblHeader.backgroundColor = [UIColor clearColor];
//    [viewHeader addSubview:lblHeader];
//    lblHeader = nil;
    
    return viewHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"jobsite";
    
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        @autoreleasepool {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    }

    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.text = [arrOptions objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;

    if(indexPath.row==6 && appDelegate.objUserLogedIn)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = [UIColor orangeColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:24];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    else if(appDelegate.objUserLogedIn==nil && indexPath.row==5)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = [UIColor orangeColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:24];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    else
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(appDelegate.objUserLogedIn)
    {
        //Privacy Policy
        if(indexPath.row==0)
        {
            BW_MoreDetails_ViewController *objVC = [[BW_MoreDetails_ViewController alloc] init];
            objVC.intCategoryID = indexPath.row;
            objVC.title = [arrOptions objectAtIndex:indexPath.row];
            if(callbackToHome)
                [self.callbackToHome.navigationController pushViewController:objVC animated:YES];
            else
                [self.navigationController pushViewController:objVC animated:YES];
            objVC = nil;
        }
        else if(indexPath.row==1)//Feedback
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Feedback" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Problem", @"Suggestion", @"Praise", @"Question", nil];
            alert.tag = 1000;
            [alert show];
            alert = nil;
        }//Update Profile
        else if(indexPath.row==2)//Update Profile
        {
            BW_UpdateProfile_ViewController *objVC = [[BW_UpdateProfile_ViewController alloc] init];
            if(callbackToHome)
                [self.callbackToHome.navigationController pushViewController:objVC animated:YES];
            else
                [self.navigationController pushViewController:objVC animated:YES];
            
            objVC = nil;
        }
        else if (indexPath.row==3)// Contact Us
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Contact Us" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send Email", @"Call Us", nil];
            alert.tag = 2000;
            [alert show];
            alert = nil;
        }
        else if(indexPath.row == 4)//Help
        {
            BW_MoreDetails_ViewController *objVC = [[BW_MoreDetails_ViewController alloc] init];
            objVC.intCategoryID = indexPath.row;
            objVC.title = [arrOptions objectAtIndex:indexPath.row];
            if(callbackToHome)
                [self.callbackToHome.navigationController pushViewController:objVC animated:YES];
            else
                [self.navigationController pushViewController:objVC animated:YES];
            objVC = nil;
        }
        else if(indexPath.row == 5)// My Cards
        {
            if(appDelegate.objUserLogedIn)
            {
                BW_MyCards_ViewController *objVC = [[BW_MyCards_ViewController alloc] init];
                if(callbackToHome)
                    [self.callbackToHome.navigationController pushViewController:objVC animated:YES];
                else
                    [self.navigationController pushViewController:objVC animated:YES];
                objVC = nil;
            }
            else
            {
                appDelegate.objUserLogedIn = nil;
                if(callbackToHome)
                    [self.callbackToHome.navigationController popToRootViewControllerAnimated:YES];
                else
                    [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
        else if (indexPath.row==6)
        {
            appDelegate.objUserLogedIn = nil;
            if(callbackToHome)
                [self.callbackToHome.navigationController popToRootViewControllerAnimated:YES];
            else
                [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
    else //Annonymous User
    {
        if(indexPath.row==0)
        {
            BW_MoreDetails_ViewController *objVC = [[BW_MoreDetails_ViewController alloc] init];
            objVC.intCategoryID = indexPath.row;
            objVC.title = [arrOptions objectAtIndex:indexPath.row];
            if(callbackToHome)
                [self.callbackToHome.navigationController pushViewController:objVC animated:YES];
            else
                [self.navigationController pushViewController:objVC animated:YES];
            objVC = nil;
        }
        else if(indexPath.row==1)//Feedback
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Feedback" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Problem", @"Suggestion", @"Praise", @"Question", nil];
            alert.tag = 1000;
            [alert show];
            alert = nil;
        }//Update Profile
        else if(indexPath.row==2)// Contact Us
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Contact Us" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send Email", @"Call Us", nil];
            alert.tag = 2000;
            [alert show];
            alert = nil;
        }
        else if (indexPath.row==3)//Help
        {
            BW_MoreDetails_ViewController *objVC = [[BW_MoreDetails_ViewController alloc] init];
            objVC.intCategoryID = indexPath.row;
            objVC.title = [arrOptions objectAtIndex:indexPath.row];
            if(callbackToHome)
                [self.callbackToHome.navigationController pushViewController:objVC animated:YES];
            else
                [self.navigationController pushViewController:objVC animated:YES];
            objVC = nil;
        }
        else if (indexPath.row==4)
        {
            appDelegate.objUserLogedIn = nil;
            if(callbackToHome)
                [self.callbackToHome.navigationController popToRootViewControllerAnimated:YES];
            else
                [self.navigationController popToRootViewControllerAnimated:YES];
        }

    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1000)
    {
        NSString *strSubject = @"";
        
        if (buttonIndex==1)
            strSubject = @"Problem";
        else if (buttonIndex==2)
            strSubject = @"Suggestion";
        else if (buttonIndex==3)
            strSubject = @"Praise";
        else if (buttonIndex==4)
            strSubject = @"Question";
        
        if (buttonIndex>0 && [MFMailComposeViewController canSendMail])
        {
            MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
            mailer.mailComposeDelegate = self;
            [mailer setSubject:[NSString stringWithFormat:@"Buckworm : %@", strSubject]];
            [mailer setToRecipients:[NSArray arrayWithObjects:feedbackEmailId1, nil]];
            NSString *emailBody = @" ";
            
            [mailer setMessageBody:emailBody isHTML:NO];
            if(callbackToHome)
                [self.callbackToHome presentViewController:mailer animated:YES completion:nil];
            else
                [self presentViewController:mailer animated:YES completion:nil];
        }
    }
    else if(alertView.tag == 2000)
    {
        if (buttonIndex==1)
        {
            if ([MFMailComposeViewController canSendMail])
            {
                MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
                mailer.mailComposeDelegate = self;
                [mailer setSubject:@"Buckworm : Contact Us"];
                [mailer setToRecipients:[NSArray arrayWithObjects:contactUsEmailId1, nil]];
                NSString *emailBody = @" ";
                
                [mailer setMessageBody:emailBody isHTML:NO];
                if(callbackToHome)
                    [self.callbackToHome presentViewController:mailer animated:YES completion:nil];
                else
                    [self presentViewController:mailer animated:YES completion:nil];
            }
            
        }
        else if(buttonIndex==2)
        {
            NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@", contactUsPhone]];
            
            if ([[UIApplication sharedApplication] canOpenURL:phoneUrl])
            {
                [[UIApplication sharedApplication] openURL:phoneUrl];
            }
            else
            {
                UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [calert show];
                calert = nil;
            }
        }
    }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    // Remove the mail view
    if(callbackToHome)
        [self.callbackToHome dismissViewControllerAnimated:YES completion:nil];
    else
        [self dismissViewControllerAnimated:YES completion:nil];
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
