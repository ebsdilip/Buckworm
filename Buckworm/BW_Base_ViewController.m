//
//  BW_Base_ViewController.m
//  Buckworm
//
//  Created by Developer on 6/10/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BW_Base_ViewController.h"

@interface BW_Base_ViewController ()

@end

@implementation BW_Base_ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.autoresizesSubviews = NO;

    appDelegate = (BWAppDelegate *)[UIApplication sharedApplication].delegate;
    

    UIImage *image = [UIImage imageNamed:@"Logo1.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    self.navigationItem.titleView = imageView;
    image = nil;
    imageView = nil;
    
//    self.view.backgroundColor = [UIColor colorWithRed:83.0/255 green:207.0/255 blue:184.0/255 alpha:1.0];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)showBackButton
{
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    viewHeader.backgroundColor = colorGreen;
    [self.view addSubview:viewHeader];
    
    UIButton *btnChangeLocation = [[UIButton alloc] initWithFrame:CGRectMake(10, 27, 50, 30)];
//    [btnChangeLocation setTitle:@"Back" forState:UIControlStateNormal];
    [btnChangeLocation setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnChangeLocation.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [btnChangeLocation addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnChangeLocation];
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 22, 40, 40)];
    btnBack.backgroundColor = [UIColor clearColor];
    [btnBack setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon-arrow" ofType:@"png"]] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    btnBack = nil;

    lblBarTitle =[[UILabel alloc] initWithFrame:CGRectMake(60, 27, 200, 30)];
    lblBarTitle.font = [UIFont boldSystemFontOfSize:18.0];
    lblBarTitle.textAlignment = NSTextAlignmentCenter;
    lblBarTitle.adjustsFontSizeToFitWidth = YES;
    lblBarTitle.backgroundColor = [UIColor clearColor];
    lblBarTitle.textColor = [UIColor whiteColor];
    lblBarTitle.text = @"";
    [self.view addSubview:lblBarTitle];
}
- (void)backButtonClicked
{
    if(self.navigationController)
        [self.navigationController popViewControllerAnimated:YES];
    else
        [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animate
{
    [super viewWillAppear:animate];

}

- (void)showAlertWithOKAndMessage:(NSString *)strMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:strMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    alert = nil;

}

- (void)noInternetMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internet error!" message:@"No internet available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    alert = nil;
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
