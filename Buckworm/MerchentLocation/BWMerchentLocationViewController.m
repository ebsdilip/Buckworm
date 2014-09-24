//
//  BWMerchentLocationViewController.m
//  buckworm
//
//  Created by TechSunRise on 8/5/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BWMerchentLocationViewController.h"
#import "TechSunRiseMKAnnotation.h"
#import "BWMercentLocationDetailViewController.h"
#import "CustomMKAnnotationView.h"

@interface BWMerchentLocationViewController ()

@end

@implementation BWMerchentLocationViewController

//@synthesize currentLocationPoint;
//@synthesize locationManager;

- (void)clearMemory
{
    objMerchentLocBL.callBack = nil;
    objMerchentLocBL = nil;
    _mapView = nil;
    _mapView.delegate = nil;
    arrLocations = nil;
    
//    locationManager.delegate = nil;
//    locationManager = nil;
//    currentLocationPoint = nil;;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        IsLOGO = YES;
        intMapType = 1;
        objMerchentLocBL = [[BW_MerchentLocation_BL alloc] init];
        objMerchentLocBL.callBack = self;
        
        arrLocations = [[NSMutableArray alloc] init];
        arrComingSoon = [[NSMutableArray alloc] init];
        arrBackUp = [[NSMutableArray alloc] init];
        arrPins = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    [self screenDesign];
}

- (void)screenDesign
{
    [self showBackButton];
    lblBarTitle.text = @"Merchant";
    
    btnRedPins = [[UIButton alloc] initWithFrame:CGRectMake(8, 70, 70, 34)];
    btnRedPins.backgroundColor = colorGreen;
    btnRedPins.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    btnRedPins.titleLabel.textColor = [UIColor whiteColor];
    btnRedPins.layer.cornerRadius = 5.0;
    //    [btnRedPins setTitle:@"Red" forState:UIControlStateNormal];
    [btnRedPins setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pin" ofType:@"png"]] forState:UIControlStateNormal];
    [btnRedPins addTarget:self action:@selector(showRedPins) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRedPins];
    
    
    btnViewLogo = [[UIButton alloc] initWithFrame:CGRectMake(86, 70, 70, 34)];
    btnViewLogo.backgroundColor = colorGreen;
    btnViewLogo.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    btnViewLogo.titleLabel.textColor = [UIColor whiteColor];
    btnViewLogo.layer.cornerRadius = 5.0;
    [btnViewLogo setImage:nil forState:UIControlStateNormal];
    [btnViewLogo setTitle:@"Logo" forState:UIControlStateNormal];
    [btnViewLogo addTarget:self action:@selector(showLogos) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnViewLogo];
    
    btnViewOffer = [[UIButton alloc] initWithFrame:CGRectMake(164, 70, 70, 34)];
    btnViewOffer.backgroundColor = colorGreen;
    btnViewOffer.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    btnViewOffer.titleLabel.textColor = [UIColor whiteColor];
    btnViewOffer.layer.cornerRadius = 5.0;
    [btnViewOffer setImage:nil forState:UIControlStateNormal];
    [btnViewOffer setTitle:@"Offers" forState:UIControlStateNormal];
    [btnViewOffer addTarget:self action:@selector(showOffer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnViewOffer];
    
    btnRedoSearch = [[UIButton alloc] initWithFrame:CGRectMake(240, 70, 70, 34)];
    btnRedoSearch.backgroundColor = colorGreen;
    btnRedoSearch.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    btnRedoSearch.titleLabel.textColor = [UIColor whiteColor];
    btnRedoSearch.layer.cornerRadius = 5.0;
    [btnRedoSearch setTitle:@"Search" forState:UIControlStateNormal];
    [btnRedoSearch addTarget:self action:@selector(btnRedoSearchClicked) forControlEvents:UIControlEventTouchUpInside];
    
    imgViewSearchBG = [[UIImageView alloc] init];
    imgViewSearchBG.frame = CGRectMake(0, 64, 320, 45);
    imgViewSearchBG.userInteractionEnabled = YES;
    imgViewSearchBG.backgroundColor = [UIColor clearColor];
    imgViewSearchBG.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"searchBG" ofType:@"png"]];
    [self.view addSubview:imgViewSearchBG];
    
    txtFieldSearch = [[UITextField alloc] init];
    txtFieldSearch.frame = CGRectMake(40, 0, 240, 44);
    txtFieldSearch.returnKeyType = UIReturnKeySearch;
    txtFieldSearch.delegate = self;
    txtFieldSearch.clearsOnBeginEditing = YES;
    txtFieldSearch.textColor = [UIColor lightGrayColor];
    txtFieldSearch.backgroundColor = [UIColor clearColor];
    txtFieldSearch.font = [UIFont boldSystemFontOfSize:20];
    txtFieldSearch.text = @"category or name";
    [imgViewSearchBG addSubview:txtFieldSearch];
    
    btnSearch = [[UIButton alloc] initWithFrame:CGRectMake(320-44, 0, 44, 45)];
    [btnSearch addTarget:self action:@selector(btnSearchClicked) forControlEvents:UIControlEventTouchUpInside];
    [btnSearch setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"searchIcon" ofType:@"png"]] forState:UIControlStateNormal];
    btnSearch.backgroundColor = [UIColor clearColor];
    [imgViewSearchBG addSubview:btnSearch];
    
//    //Getting the screen size
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    float height = screenRect.size.height-64;
//    float width = screenRect.size.width;
//    
//    // alloc and set frame
//	_mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 64, width, height)];
//    _mapView.showsUserLocation = YES;// YES if want to show current location on map
//	[_mapView setDelegate:self];
//	[self.view addSubview:_mapView];
//    
//    [_mapView setZoomEnabled:YES];
//	[_mapView setScrollEnabled:YES];
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"Standard", @"Hybrid", @"Satellite", nil];
    
    segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    [segmentedControl addTarget:self action:@selector(segmentControlerChanged:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBordered;
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.frame = CGRectMake(10, IS_IPHONE_5?520:400, 300, 30);
    //    [_mapView addSubview:segmentedControl];
    [self.view addSubview:segmentedControl];
    
}
- (void)showRedPins
{
    intMapType = 1;

    for (int i=0; i<[arrPins count]; i++)
    {
        CustomMKAnnotationView *pinView = [arrPins objectAtIndex:i];

        UILabel *lblTitle = (UILabel *)[pinView viewWithTag:1111];
        if(lblTitle)
            [lblTitle removeFromSuperview];
        pinView.image = nil;
        pinView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pin" ofType:@"png"]];
    }
}
- (void)showLogos
{
    intMapType = 2;
    
    for (int i=0; i<[arrPins count]; i++)
    {
        CustomMKAnnotationView *pinView = [arrPins objectAtIndex:i];
        
        TechSunRiseMKAnnotation *myAnnotation = (TechSunRiseMKAnnotation *)pinView.annotation;
        
        UILabel *lblTitle = (UILabel *)[pinView viewWithTag:1111];
        if(lblTitle)
            [lblTitle removeFromSuperview];
        pinView.image = nil;
        [pinView showImage:myAnnotation.strImageUrlOffer];
    }
}
- (void)showOffer
{
    intMapType = 3;
    
    for (int i=0; i<[arrPins count]; i++)
    {
        CustomMKAnnotationView *pinView = [arrPins objectAtIndex:i];
        
        TechSunRiseMKAnnotation *myAnnotation = (TechSunRiseMKAnnotation *)pinView.annotation;
        pinView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pinGreen" ofType:@"png"]];
        UILabel *lblTitle = (UILabel *)[pinView viewWithTag:1111];
        if(lblTitle==nil)
        {
            lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
            [pinView addSubview:lblTitle];
        }
        lblTitle.tag = 1111;
        lblTitle.font = [UIFont boldSystemFontOfSize:12.0];
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.backgroundColor = [UIColor clearColor];
        lblTitle.textAlignment = NSTextAlignmentCenter;
        lblTitle.numberOfLines = 0;
        lblTitle.text = myAnnotation.strText;
    }
}

- (void)btnRedoSearchClicked
{
    [imgViewSearchBG removeFromSuperview];
    [self.view addSubview:imgViewSearchBG];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.29];
    [UIView setAnimationDelegate:nil];
    imgViewSearchBG.frame = CGRectMake(0, 64, 320, 45);
    [UIView commitAnimations];
}
- (void)btnSearchClicked
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[c] %@ OR category contains[c] %@", txtFieldSearch.text, txtFieldSearch.text];
    NSArray *filteredarray =[arrBackUp filteredArrayUsingPredicate:predicate];

    [arrLocations removeAllObjects];
    [arrLocations addObjectsFromArray:([txtFieldSearch.text length]>0)?filteredarray:arrBackUp];
    [self showAnnotationOnMap];
    
    [txtFieldSearch resignFirstResponder];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.29];
    [UIView setAnimationDelegate:nil];
    imgViewSearchBG.frame = CGRectMake(320, 64, 320, 45);
    [UIView commitAnimations];
}
- (void)viewDidAppear:(BOOL)animated
{
    if([arrLocations count]==0)
        [self getLocation];
}






- (void)segmentControlerChanged:(UISegmentedControl *)segControl
{
    switch (segControl.selectedSegmentIndex) {
        case 0:
            [_mapView setMapType:MKMapTypeStandard];
            break;
        case 1:
            [_mapView setMapType:MKMapTypeHybrid];
            break;
        case 2:
            [_mapView setMapType:MKMapTypeSatellite];
            break;
        default:
            break;
    }
}

#pragma mark - Parser
- (void)getLocation
{
    NSString *strLat = [NSString stringWithFormat:@"%f", appDelegate.currentLocationPoint.coordinate.latitude];
    NSString *strLong = [NSString stringWithFormat:@"%f", appDelegate.currentLocationPoint.coordinate.longitude];
    
    [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
                                      withLabel:@"Fetching locations..."];
    [objMerchentLocBL getMerchantsOfLat:strLat andLong:strLong];
    
}
- (void)errorInParseing:(NSError *)error
{
    [DSBezelActivityView removeViewAnimated:YES];
    NSLog(@"error = %@", error);
}

- (void)MerchentLocationParserFinished:(NSDictionary *)dictOffers
{
    [DSBezelActivityView removeViewAnimated:YES];
    //    NSLog(@"dictOffers = %@", dictOffers);
    strImagePathO = [dictOffers objectForKey:@"gmapImagePath"];
    strImagePathO = [strImagePathO stringByReplacingOccurrencesOfString:@"///" withString:@"//"];
    
    strImagePathL = [dictOffers objectForKey:@"logoImagePath"];
    strImagePathL = [strImagePathL stringByReplacingOccurrencesOfString:@"///" withString:@"//"];
    
    [arrLocations removeAllObjects];
    [arrLocations addObjectsFromArray:[dictOffers objectForKey:@"merchants"]];
    [arrComingSoon removeAllObjects];
    [arrComingSoon addObjectsFromArray:[dictOffers objectForKey:@"comingSoonMerchants"]];
    [self showAnnotationOnMap];
    [arrBackUp removeAllObjects];
    [arrBackUp addObjectsFromArray:arrLocations];
}
- (void)showAnnotationOnMap
{
    
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView removeFromSuperview];
    _mapView = nil;
    _mapView.delegate = nil;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    float height = screenRect.size.height-64;
    float width = screenRect.size.width;
    
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 64, width, height)];
    _mapView.showsUserLocation = YES;// YES if want to show current location on map
	[_mapView setDelegate:self];
	[self.view addSubview:_mapView];
    
    
    [btnRedPins removeFromSuperview];
    [self.view addSubview:btnRedPins];
    [btnRedoSearch removeFromSuperview];
    [self.view addSubview:btnRedoSearch];
    [btnViewOffer removeFromSuperview];
    [btnViewLogo removeFromSuperview];
    [self.view addSubview:btnViewOffer];
    [self.view addSubview:btnViewLogo];
    [segmentedControl removeFromSuperview];
    [self.view addSubview:segmentedControl];
    
    // run the loop to get all location
    for (int i=0; i<[arrLocations count]; i++)
    {
        NSMutableDictionary *dictTemp = (NSMutableDictionary *)[arrLocations objectAtIndex:i];
        NSArray *arrTemp = [dictTemp objectForKey:@"location"];
        NSDictionary *dictLocation = [arrTemp lastObject];
        // Fetch the Latitude, Longitude, Title, SubTitle
        
        float Lat = [[dictLocation objectForKey:@"latitude"] floatValue];
        float Long = [[dictLocation objectForKey:@"longitude"] floatValue];
        NSString *strTitle = [dictTemp objectForKey:@"name"];
        NSString *strText = [dictTemp objectForKey:@"gmap_text"];
        NSString *strSubTitle = [dictLocation objectForKey:@"location"];
        NSString *strURLImageOffer = [dictTemp objectForKey:@"gmap_image"];
        NSString *strURLImageLogo = [dictTemp objectForKey:@"logo"];
        
        // set MKCoordinateRegion center and span
        MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
        region.center.latitude = Lat;
        region.center.longitude = Long;
        region.span.longitudeDelta = 0.2f;
        region.span.latitudeDelta = 0.2;
        [_mapView setRegion:region animated:YES];// Set Region to the map
        
        TechSunRiseMKAnnotation *ann = [[TechSunRiseMKAnnotation alloc] init];
        ann.title = strTitle;
        ann.subtitle = strSubTitle;
        ann.strText = strText;
        ann.strImageUrlLogo = [NSString stringWithFormat:@"%@%@", strImagePathL, strURLImageLogo];
        ann.strImageUrlOffer = [NSString stringWithFormat:@"%@%@", strImagePathO, strURLImageOffer];
        ann.coordinate = region.center;
        [_mapView addAnnotation:ann];
    }
    [self zoomToFitMapAnnotations:_mapView];
}
#pragma mark- MKMapView Delegate viewForAnnotation
-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
	CustomMKAnnotationView *pinView = nil;
    if(annotation != _mapView.userLocation)
	{
		static NSString *defaultPinID = @"com.TechSunRise.pin";
		pinView = (CustomMKAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        
		if (pinView == nil)
        {
            pinView = [[CustomMKAnnotationView alloc]
                       initWithAnnotation:annotation reuseIdentifier:defaultPinID];
            pinView.callBack = self;
            pinView.strImagePath = strImagePathO;
        }
//        pinView.pinColor = MKPinAnnotationColorRed;

        TechSunRiseMKAnnotation *myAnnotation = (TechSunRiseMKAnnotation *)annotation;
        if(intMapType==1)
        {
            UILabel *lblTitle = (UILabel *)[pinView viewWithTag:1111];
            if(lblTitle)
                [lblTitle removeFromSuperview];
            pinView.image = nil;
            pinView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pin" ofType:@"png"]];

        }
        else if(intMapType==2)
        {
            if(pinView.image==nil)
                [pinView showImage:myAnnotation.strImageUrlOffer];
        }
        else
        {
            pinView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pinGreen" ofType:@"png"]];
            UILabel *lblTitle = (UILabel *)[pinView viewWithTag:1111];
            if(lblTitle==nil)
                lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
            lblTitle.tag = 1111;
            lblTitle.font = [UIFont boldSystemFontOfSize:12.0];
            lblTitle.textColor = [UIColor whiteColor];
            lblTitle.backgroundColor = [UIColor clearColor];
            lblTitle.textAlignment = NSTextAlignmentCenter;
            lblTitle.numberOfLines = 0;
            lblTitle.text = myAnnotation.strText;
            [pinView addSubview:lblTitle];
        }

        // Creating a UIButton for rightCalloutAccessoryView
        UIButton *btnRoute = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        btnRoute.backgroundColor = [UIColor clearColor];
//        [btnRoute setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"i" ofType:@"png"]] forState:UIControlStateNormal];
        // Add a target Action for this button
        [btnRoute addTarget:self action:@selector(openDirectionHandlerForSelected:) forControlEvents:UIControlEventTouchUpInside];
        // Setting Title of button to identify the selected annotation
        [btnRoute setTitle:[NSString stringWithFormat:@"%@~%@", annotation.title, annotation.subtitle] forState:UIControlStateNormal];
        
        // set view for rightCalloutAccessoryView btnRoute
        pinView.rightCalloutAccessoryView = btnRoute;

        // Show callout
        pinView.canShowCallout = YES;
        if(pinView!=nil && ![arrPins containsObject:pinView])
            [arrPins addObject:pinView];
    }
	else
    {
        //For Current Location just show a Message
		[_mapView.userLocation setTitle:@"I am here"];
	}
	return pinView;
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{

}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
}

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView
{
}
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{

}
- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
}

- (void)openDirectionHandlerForSelected:(UIButton *)sender
{
    //Get the current title of the sender to identify the pin selected
    
    NSArray *arrTemp = [[sender currentTitle] componentsSeparatedByString:@"~"];
    NSString *Title;
    NSString *SubTitle;

    if([arrTemp count]>=2)
    {
        Title = [arrTemp objectAtIndex:0];
        SubTitle = [arrTemp objectAtIndex:1];
    }
    int i=0;
    
    for (i=0; i<[arrLocations count]; i++)
    {
        NSMutableDictionary *dictTemp = (NSMutableDictionary *)[arrLocations objectAtIndex:i];
        NSArray *arrTemp = [dictTemp objectForKey:@"location"];
        NSDictionary *dictLocation = [arrTemp lastObject];

        // Fetch the Latitude, Longitude, Title, SubTitle
        NSString *strTitle = [dictTemp objectForKey:@"name"];
        NSString *strSubTitle = [dictLocation objectForKey:@"location"];
        
        // Check Title is equal to the selected annotation's title
        if([Title isEqualToString:strTitle] && [SubTitle isEqualToString:strSubTitle])
        {
            if([[dictTemp objectForKey:@"is_published"] integerValue]==1)
            {
            BWMercentLocationDetailViewController *objMerchantDetailVC = [[BWMercentLocationDetailViewController alloc] init];
            objMerchantDetailVC.title = strTitle;
            objMerchantDetailVC.dictLocation = dictLocation;
            [self.navigationController pushViewController:objMerchantDetailVC animated:YES];
            objMerchantDetailVC = nil;
            break;
            }
            else
            {
            
            }
        }
    }
//    for (i=0; i<[arrComingSoon count]; i++)
//    {
//        NSMutableDictionary *dictLocation = (NSMutableDictionary *)[arrComingSoon objectAtIndex:i];
//        
//        // Fetch the Latitude, Longitude, Title, SubTitle
//        NSString *strTitle = [dictLocation objectForKey:@"title"];
//        NSString *strSubTitle = [dictLocation objectForKey:@"location"];
//
//        // Check Title is equal to the selected annotation's title
//        if([Title isEqualToString:strTitle] && [SubTitle isEqualToString:strSubTitle])
//        {
//            BWMercentLocationDetailViewController *objMerchantDetailVC = [[BWMercentLocationDetailViewController alloc] init];
//            objMerchantDetailVC.title = strTitle;
//            objMerchantDetailVC.dictLocation = dictLocation;
//            objMerchantDetailVC.strImageURL = [dictLocation objectForKey:@"offer_image"];
//            [self.navigationController pushViewController:objMerchantDetailVC animated:YES];
//            objMerchantDetailVC = nil;
//            break;
//        }
//    }

}
- (void)zoomToFitMapAnnotations:(MKMapView *)mapView {
    if ([mapView.annotations count] == 0) return;
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    for(id<MKAnnotation> annotation in mapView.annotations) {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
    }
    
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1;
    
    // Add a little extra space on the sides
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1;
    
    region = [mapView regionThatFits:region];
    [mapView setRegion:region animated:YES];
    mapView = nil;
}

#pragma mark - UITextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{

}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
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
    [self btnSearchClicked];
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
