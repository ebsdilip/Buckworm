//
//  BWDigitalCouponFeedbackView.m
//  buckworm
//
//  Created by Developer on 8/14/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BWDigitalCouponFeedbackView.h"
#import "BW_DigitalCouponDownloaded_ViewController.h"
#import "BWAppDelegate.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@implementation BWDigitalCouponFeedbackView

@synthesize strMerchantID;
@synthesize callBack;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [txtViewComment resignFirstResponder];
    [txtFieldDolar resignFirstResponder];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:viewBox];
    
    if(point.x>00 && point.x<270 && point.y>126 && point.y<162)
    {
        if(point.x>30)
            rating = (point.x-20)/50;
        else
            rating = -1;
        
        rating+=1;
        
        imgStar1.hidden = YES;
        imgStar2.hidden = YES;
        imgStar3.hidden = YES;
        imgStar4.hidden = YES;
        imgStar5.hidden = YES;
        
        switch (rating) {
            case 1:
                imgStar1.hidden = NO;
                break;
                
            case 2:
                imgStar1.hidden = NO;
                imgStar2.hidden = NO;
                break;
                
            case 3:
                imgStar1.hidden = NO;
                imgStar2.hidden = NO;
                imgStar3.hidden = NO;
                break;
                
            case 4:
                imgStar1.hidden = NO;
                imgStar2.hidden = NO;
                imgStar3.hidden = NO;
                imgStar4.hidden = NO;
                break;
                
            case 5:
                imgStar1.hidden = NO;
                imgStar2.hidden = NO;
                imgStar3.hidden = NO;
                imgStar4.hidden = NO;
                imgStar5.hidden = NO;
                break;
                
            default:
                break;
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:viewBox];
    
    if(point.x>00 && point.x<270 && point.y>126 && point.y<162)
    {
        if(point.x>30)
            rating = (point.x-20)/50;
        else
            rating = -1;
        
        rating+=1;
        
        imgStar1.hidden = YES;
        imgStar2.hidden = YES;
        imgStar3.hidden = YES;
        imgStar4.hidden = YES;
        imgStar5.hidden = YES;
        
        switch (rating) {
            case 1:
                imgStar1.hidden = NO;
                break;
                
            case 2:
                imgStar1.hidden = NO;
                imgStar2.hidden = NO;
                break;
                
            case 3:
                imgStar1.hidden = NO;
                imgStar2.hidden = NO;
                imgStar3.hidden = NO;
                break;
                
            case 4:
                imgStar1.hidden = NO;
                imgStar2.hidden = NO;
                imgStar3.hidden = NO;
                imgStar4.hidden = NO;
                break;
                
            case 5:
                imgStar1.hidden = NO;
                imgStar2.hidden = NO;
                imgStar3.hidden = NO;
                imgStar4.hidden = NO;
                imgStar5.hidden = NO;
                break;
                
            default:
                break;
        }
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        rating = -1;
        objFeedbackBL = [[BW_Feedback_BL alloc] init];
        objFeedbackBL.callBack = self;
        [self screenDesigning];
    }
    return self;
}

- (void)screenDesigning
{
    viewBox = [[UIView alloc] initWithFrame:CGRectMake(10, IS_IPHONE_5?64:20, 300, 449)];
    viewBox.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"feedBackBG" ofType:@"png"]]];
    
    txtFieldDolar = [[UITextField alloc] initWithFrame:CGRectMake(87, 238, 140, 30)];
    txtFieldDolar.delegate = self;
    txtFieldDolar.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:17.0];
    txtFieldDolar.placeholder = @"Pre-Purchase Amount";
    txtFieldDolar.returnKeyType = UIReturnKeyNext;
    txtFieldDolar.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    txtFieldDolar.backgroundColor = [UIColor clearColor];
    //    txtFieldLoc.font = [UIFont systemFontOfSize:50.0];
    [viewBox addSubview:txtFieldDolar];
    
    txtViewComment = [[UITextView alloc] initWithFrame:CGRectMake(20, 296, 260, 38)];
    txtViewComment.delegate = self;
    txtViewComment.font = [UIFont systemFontOfSize:10.0];
    txtViewComment.backgroundColor = [UIColor clearColor];
    [viewBox addSubview:txtViewComment];

    UIButton *btnNoThanks = [[UIButton alloc] initWithFrame:CGRectMake(15, 344, 270, 43)];
    btnNoThanks.backgroundColor = [UIColor clearColor];
    [btnNoThanks addTarget:self action:@selector(noThanksClicked) forControlEvents:UIControlEventTouchUpInside];
    [btnNoThanks setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"btnNoThanks" ofType:@"png"]] forState:UIControlStateNormal];
    [viewBox addSubview:btnNoThanks];

    UIButton *btnOK = [[UIButton alloc] initWithFrame:CGRectMake(15, 392, 270, 43)];
    btnOK.backgroundColor = [UIColor clearColor];
    [btnOK addTarget:self action:@selector(okClicked) forControlEvents:UIControlEventTouchUpInside];
    [btnOK setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"btnOK" ofType:@"png"]] forState:UIControlStateNormal];
    [viewBox addSubview:btnOK];
    
    [self addSubview:viewBox];
    
    imgStar1 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 126, 37, 36)];
    imgStar1.backgroundColor = [UIColor clearColor];
    imgStar1.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"starGold" ofType:@"png"]];
    [viewBox addSubview:imgStar1];

    imgStar2 = [[UIImageView alloc] initWithFrame:CGRectMake(80, 126, 37, 36)];
    imgStar2.backgroundColor = [UIColor clearColor];
    imgStar2.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"starGold" ofType:@"png"]];
    [viewBox addSubview:imgStar2];

    imgStar3 = [[UIImageView alloc] initWithFrame:CGRectMake(130, 126, 37, 36)];
    imgStar3.backgroundColor = [UIColor clearColor];
    imgStar3.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"starGold" ofType:@"png"]];
    [viewBox addSubview:imgStar3];

    imgStar4 = [[UIImageView alloc] initWithFrame:CGRectMake(180, 126, 37, 36)];
    imgStar4.backgroundColor = [UIColor clearColor];
    imgStar4.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"starGold" ofType:@"png"]];
    [viewBox addSubview:imgStar4];

    imgStar5 = [[UIImageView alloc] initWithFrame:CGRectMake(230, 126, 37, 36)];
    imgStar5.backgroundColor = [UIColor clearColor];
    imgStar5.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"starGold" ofType:@"png"]];
    [viewBox addSubview:imgStar5];

    imgStar1.hidden = YES;
    imgStar2.hidden = YES;
    imgStar3.hidden = YES;
    imgStar4.hidden = YES;
    imgStar5.hidden = YES;

}

- (void)noThanksClicked
{
    [self removeFromSuperview];
    [self.callBack.navigationController popViewControllerAnimated:YES];

}

- (void)okClicked
{
    if([txtFieldDolar.text length]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter \"Pre-Purcahse Amount\"." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
    }
    else if([txtViewComment.text length]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter comment." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
    }
    else
    {
        [self sendFeedback:[NSString stringWithFormat:@"%i", rating<0?0:rating] ammount:txtFieldDolar.text comment:txtViewComment.text];
    }
}

- (void)sendFeedback:(NSString *)strRating ammount:(NSString *)strAmmount comment:(NSString *)strComment
{
    NSMutableDictionary *dictFeedback = [[NSMutableDictionary alloc] init];
    [dictFeedback setObject:strMerchantID forKey:@"ID"];
    [dictFeedback setObject:strAmmount forKey:@"Ammount"];
    [dictFeedback setObject:strComment forKey:@"Comment"];
    [dictFeedback setObject:strRating forKey:@"Rating"];
    
    BWAppDelegate *appDelegate = (BWAppDelegate *)[UIApplication sharedApplication].delegate;
    
    [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Sending feedback..."];
    [objFeedbackBL sendFeedback:dictFeedback];
    
    
}
- (void)feedbackParserFinished:(NSDictionary *)dictData
{
    [self removeFromSuperview];
    [DSBezelActivityView removeViewAnimated:YES];
    
    if([[dictData objectForKey:@"statusDescription"] isEqualToString:@"Success"])
    {
        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Thank you for the feedback." waitUntilDone:NO];
        [self.callBack.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        //        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Offer did not redeemed." waitUntilDone:NO];
    }
    
}
- (void)errorInParseing:(NSError *)error
{
    [DSBezelActivityView removeViewAnimated:YES];
    [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Internet connection appears to be offline." waitUntilDone:NO];
}


- (void)showAlertWithOKAndMessage:(NSString *)strMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:strMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    alert = nil;
    
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    viewBox.frame = CGRectMake(10, IS_IPHONE_5?-90:-175, 300, 449);
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    viewBox.frame = CGRectMake(10, IS_IPHONE_5?64:20, 300, 449);
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(string.length==0 && txtFieldDolar.text.length==1)
        txtFieldDolar.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:17.0];
    else
        txtFieldDolar.font = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:24.0];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if(txtViewComment.text.length==0)
        [txtViewComment becomeFirstResponder];
    return YES;
}

#pragma mark - UITextView

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    viewBox.frame = CGRectMake(10, IS_IPHONE_5?-90:-175, 300, 449);

}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    viewBox.frame = CGRectMake(10, IS_IPHONE_5?64:20, 300, 449);
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{

}

- (void)textViewDidChangeSelection:(UITextView *)textView
{

}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0)
{
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0)
{
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
