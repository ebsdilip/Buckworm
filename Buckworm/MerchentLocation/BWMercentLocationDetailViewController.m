//
//  BWMercentLocationDetailViewController.m
//  buckworm
//
//  Created by TechSunRise on 8/5/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BWMercentLocationDetailViewController.h"
#import "BW_MerchantLocationOffer_TableViewCell.h"
#import "BWOfferDetailViewController.h"

@interface BWMercentLocationDetailViewController ()

@end

@implementation BWMercentLocationDetailViewController

@synthesize dictLocation;
@synthesize strImageURL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        arrOffers = [[NSMutableArray alloc] init];
        objMerchentLocBL = [[BW_MerchentLocation_BL alloc] init];
        objMerchentLocBL.callBack = self;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 500)];
    viewBG.backgroundColor = [UIColor clearColor];
    viewBG.layer.shadowColor = [UIColor grayColor].CGColor;
    viewBG.layer.masksToBounds = NO;
    viewBG.layer.shadowOffset = CGSizeMake(-0, 1);
    viewBG.layer.shadowRadius = 1;
    viewBG.layer.shadowOpacity = 1.0;
    [self.view addSubview:viewBG];
    
//    UIImage *imgTemp = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DirectionIcon" ofType:@"png"]];
//    btnRoot = [[UIBarButtonItem alloc] initWithImage:imgTemp style:UIBarButtonItemStylePlain target:self action:@selector(showRoot)];
//    imgTemp = nil;
//    btnRoot.tag = 1005;
//    self.navigationItem.rightBarButtonItem = btnRoot;

    [self screenDesign];
    [self showBackButton];
    lblBarTitle.text = [self.title uppercaseString];
    
    UIButton *btnDirection = [[UIButton alloc] initWithFrame:CGRectMake(280, 26, 32, 32)];
    btnDirection.tag = 1005;
    btnDirection.backgroundColor = [UIColor clearColor];
    [btnDirection setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DirectionIcon" ofType:@"png"]] forState:UIControlStateNormal];
    [btnDirection addTarget:self action:@selector(showRoot) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDirection];

}

- (void)viewDidAppear:(BOOL)animated
{
    if([arrOffers count]==0)
        [self getMerchantDetails];
}

- (void)showRoot
{
    float Lat = [[dictLocation objectForKey:@"latitude"] floatValue];
    float Long = [[dictLocation objectForKey:@"longitude"] floatValue];
    NSString *strTitle = [dictLocation objectForKey:@"name"];
    if(strTitle==nil || [strTitle length]==0)
        strTitle = self.title;
    NSString *strSubTitle = [dictLocation objectForKey:@"location"];

    CLLocationCoordinate2D destination = CLLocationCoordinate2DMake(Lat, Long);
    
    //allocating the MKPlacemark of destination location
    MKPlacemark *placemark = [[MKPlacemark alloc]initWithCoordinate:destination addressDictionary:nil];
    // allocating the MKMapItem with MKPlacemark to open the Map
    MKMapItem * item = [[MKMapItem alloc]initWithPlacemark:placemark];
    item.name = [NSString stringWithFormat:@"%@ : %@", strTitle, strSubTitle];
    
    // Preaparing the launchOptions dictionary for predefined keyes MKLaunchOptionsDirectionsModeKey and MKLaunchOptionsMapTypeKey
    NSDictionary *launchOptions = @{
                                    
                                    MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking,
                                    
                                    MKLaunchOptionsMapTypeKey:@(MKMapTypeSatellite)
                                    };
    //This method will open the Map with the opttions given by launchOptions
    [item openInMapsWithLaunchOptions:launchOptions];
}

- (void)screenDesign
{
    self.view.backgroundColor = [UIColor whiteColor];

    if(strImageURL)
    {
        imgViewMerchant = [[UIImageView alloc] initWithFrame:CGRectMake(10, 4, 80, 72)];
        imgViewMerchant.backgroundColor = [UIColor clearColor];
        imgViewMerchant.layer.borderWidth = 1.0;
        imgViewMerchant.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [viewBG addSubview:imgViewMerchant];
        
        indicator1=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator1.hidesWhenStopped=YES;
        indicator1.center = imgViewMerchant.center;
        [viewBG addSubview:indicator1];
        [indicator1 startAnimating];

//        NSString *strImageURL = [NSString stringWithFormat:@"%@/%@", strImagePath, [dictOffer objectForKey:@"offer_image"]];
        strImageURL = [strImageURL stringByReplacingOccurrencesOfString:@"\\" withString:@"%5C"];   //Replace \ by %5C
        strImageURL = [strImageURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        if([strImageURL length]>5 && [[strImageURL substringToIndex:4] isEqualToString:@"http"])
        {
            if(![indicator1 isAnimating])
                [indicator1 startAnimating];
            
            @synchronized(self) {
                if ([[NSThread currentThread] isCancelled]) return;
                
                [_thread1 cancel];	//Cell! Stop what you were doing!
                _thread1 = nil;
                
                // We need to download the image, get it in a seperate thread!
                _thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(downloadImage:) object:strImageURL];
                [_thread1 start];
            }
        }
        else
        {
            if(imgViewMerchant.image == nil)
            {
                imgViewMerchant.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"maoIcon" ofType:@"png"]];
            }
            [indicator1 stopAnimating];
        }

        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, 200, 40)];
        lblTitle.font = [UIFont boldSystemFontOfSize:17.0];
        lblTitle.numberOfLines = 2;
        lblTitle.textColor = [UIColor darkGrayColor];
        lblTitle.backgroundColor = [UIColor clearColor];
        [viewBG addSubview:lblTitle];
        
        lblTitle.text = [dictLocation objectForKey:@"name"];
        if(lblTitle.text==nil || [lblTitle.text length]==0)
            lblTitle.text = [dictLocation objectForKey:@"title"];
        
        UILabel *lblLocation = [[UILabel alloc] initWithFrame:CGRectMake(100, 45, 200, 30)];
        lblLocation.font = [UIFont systemFontOfSize:12.0];
        lblLocation.numberOfLines = 2;
        lblLocation.textColor = [UIColor darkGrayColor];
        lblLocation.backgroundColor = [UIColor clearColor];
        [viewBG addSubview:lblLocation];
        lblLocation.text = [dictLocation objectForKey:@"location"];

    }
    else
    {
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 40)];
        lblTitle.font = [UIFont boldSystemFontOfSize:18.0];
        lblTitle.numberOfLines = 2;
        lblTitle.textColor = [UIColor darkGrayColor];
        lblTitle.backgroundColor = [UIColor clearColor];
        [viewBG addSubview:lblTitle];
        
        lblTitle.text = [dictLocation objectForKey:@"name"];
        if(lblTitle.text==nil || [lblTitle.text length]==0)
            lblTitle.text = [dictLocation objectForKey:@"title"];
        
        UILabel *lblLocation = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, 300, 30)];
        lblLocation.font = [UIFont systemFontOfSize:12.0];
        lblLocation.numberOfLines = 2;
        lblLocation.textColor = [UIColor darkGrayColor];
        lblLocation.backgroundColor = [UIColor clearColor];
        [viewBG addSubview:lblLocation];
        lblLocation.text = [dictLocation objectForKey:@"location"];
    }
}
- (void)downloadImage:(NSString *)strURL
{
    [NSThread sleepForTimeInterval:0.2]; // Why sleep? Because if we are scrolling fast the thread will be canceled and we don't want to start downloading.
    
    if (![[NSThread currentThread] isCancelled])
    {
        NSString *strImgURL = strURL;
        
        NSError *error = nil;
        NSURL *url = [NSURL URLWithString:strImgURL];
        UIImage *img;
        if(url)
        {
            NSData *imageData = [[NSData alloc] initWithContentsOfURL:url options:3 error:&error];
            if(!error){
                img = [UIImage imageWithData:imageData];
                if(img)
                    imgViewMerchant.image = img;
                else
                    imgViewMerchant.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mapIcon" ofType:@"png"]];
            }
            else {
                img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mapIcon" ofType:@"png"]];
            }
            imageData = nil;
            url = nil;
        }
        else {
            img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mapIcon" ofType:@"png"]];
        }
        @synchronized(self) {
            if (![[NSThread currentThread] isCancelled]) {
                imgViewMerchant.image = img;
                [indicator1 stopAnimating];
            }
        }
        img = nil;
        strImgURL = nil;
    }
}
#pragma mark - Parser
- (void)getMerchantDetails
{
    [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Fetching locations..."];
    [objMerchentLocBL getMerchantsDetails:[dictLocation objectForKey:@"id"]];
}
- (void)MerchentDetailParserFinished:(NSDictionary *)dictOffers
{
    [arrOffers removeAllObjects];
    [arrOffers addObjectsFromArray:[dictOffers objectForKey:@"offers"]];
    
    strImagePath = [dictOffers objectForKey:@"imagePath"];
    
    [DSBezelActivityView removeViewAnimated:YES];
    NSLog(@"dictOffers = %@", dictOffers);
    
    [self showOffers];
}

- (void)errorInParseing:(NSError *)error
{
    [DSBezelActivityView removeViewAnimated:YES];
}

- (void)showOffers
{
    tblOffers = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, 320, IS_IPHONE_5?414:328)];
    tblOffers.delegate = self;
    tblOffers.dataSource = self;
    tblOffers.backgroundColor = colorTableBG;
    [viewBG addSubview:tblOffers];
    [tblOffers reloadData];
    
}
#pragma mark TableView Delegate Datasource Methods
#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrOffers count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 224;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    viewHeader.backgroundColor = colorLightGrayForBG;
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 20)];
    lblTitle.font = [UIFont boldSystemFontOfSize:14.0];
    lblTitle.textColor = [UIColor darkGrayColor];
    lblTitle.backgroundColor = [UIColor clearColor];
    if([arrOffers count]>1)
        lblTitle.text = [NSString stringWithFormat:@"%i Offers available", [arrOffers count]];
    else if([arrOffers count]==1)
        lblTitle.text = [NSString stringWithFormat:@"%i Offer available", [arrOffers count]];
    else
        lblTitle.text = @"Offers not found!";
    [viewHeader addSubview:lblTitle];

    return viewHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    viewHeader.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1.0];
    
    return viewHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictOffer = [arrOffers objectAtIndex:indexPath.row];
    NSString *CellIdentifier = [NSString stringWithFormat:@"Offer %@", [dictOffer objectForKey:@"id"]];
    
    BW_MerchantLocationOffer_TableViewCell *cell = (BW_MerchantLocationOffer_TableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        @autoreleasepool {
            cell = [[BW_MerchantLocationOffer_TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.strImagePath = strImagePath;
        }
    }
    
    cell.backgroundColor = [UIColor clearColor];
    [cell setParameter:dictOffer];
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dictOffer = [arrOffers objectAtIndex:indexPath.row];;
    BW_MerchantLocationOffer_TableViewCell *cell = (BW_MerchantLocationOffer_TableViewCell *)[tableView cellForRowAtIndexPath:indexPath];

    BWOfferDetailViewController *objVC = [[BWOfferDetailViewController alloc] init];
    objVC.strImagePath = [NSString stringWithFormat:@"%@/%@", strImagePath, [dictOffer objectForKey:@"offer_image"]];
    objVC.dictOffer = dictOffer;
//    objVC.strAccountToken = appDelegate.objUserLogedIn.strAccessToken;
    objVC.dictLocation =dictLocation;
    objVC.imageOffer = [cell getImageOfCell];
    [self.navigationController pushViewController:objVC animated:YES];
    objVC = nil;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
