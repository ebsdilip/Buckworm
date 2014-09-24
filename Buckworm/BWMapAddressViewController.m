//
//  BWMapAddressViewController.m
//  Buckworm
//
//  Created by iLabours on 8/28/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BWMapAddressViewController.h"
#import "TechSunRiseMKAnnotation.h"

@interface BWMapAddressViewController ()

@end

@implementation BWMapAddressViewController

@synthesize dictLocation;
@synthesize strTitle;

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
    [self screenDesign];
}
- (void)screenDesign
{
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    viewHeader.backgroundColor = colorGreen;
    [self.view addSubview:viewHeader];
    
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 22, 40, 40)];
    [btnBack setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon-arrow" ofType:@"png"]] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBack];
    btnBack = nil;

    UILabel *lblHeaderTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 200, 40)];
    lblHeaderTitle.textAlignment = NSTextAlignmentCenter;
    lblHeaderTitle.font = [UIFont boldSystemFontOfSize:16.0];
    lblHeaderTitle.numberOfLines = 2;
    lblHeaderTitle.textColor = [UIColor whiteColor];
    lblHeaderTitle.backgroundColor = [UIColor clearColor];
//    dictLocation
    lblHeaderTitle.text = strTitle;
    //@"Robust IT";
    [self.view addSubview:lblHeaderTitle];

    //Getting the screen size
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    float height = screenRect.size.height-68;
    float width = screenRect.size.width;
    
    // alloc and set frame
	_mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 64, width, height)];
    _mapView.showsUserLocation = YES;// YES if want to show current location on map
//	[_mapView setDelegate:self];
	[self.view addSubview:_mapView];
    
    [_mapView setZoomEnabled:YES];
	[_mapView setScrollEnabled:YES];
    
    [self showAnnotationOnMap];
}
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)showAnnotationOnMap
{
    // run the loop to get all location
    // Fetch the Latitude, Longitude, Title, SubTitle
    float Lat = [[dictLocation objectForKey:@"lat"] floatValue];
    float Long = [[dictLocation objectForKey:@"lng"] floatValue];
//    NSString *strTitle = [dictLocation objectForKey:@"Title"];
//    NSString *strSubTitle = [dictLocation objectForKey:@"Subtitle"];
    
    // set MKCoordinateRegion center and span
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = Lat;
    region.center.longitude = Long;
    region.span.longitudeDelta = 0.2f;
    region.span.latitudeDelta = 0.2;
    [_mapView setRegion:region animated:YES];// Set Region to the map
    
    TechSunRiseMKAnnotation *ann = [[TechSunRiseMKAnnotation alloc] init];
//    ann.title = strTitle;
//    ann.subtitle = strSubTitle;
    ann.coordinate = region.center;
    [_mapView addAnnotation:ann];
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
