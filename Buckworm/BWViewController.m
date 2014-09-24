//
//  BWViewController.m
//  Buckworm
//
//  Created by Developer on 8/27/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "BWViewController.h"
#import "BW_AnonymousUser_DigitalCoupon_TableViewCell.h"
#import "BWOfferDetailViewController.h"
#import "BWMyCouponsViewController.h"
#import "BW_Login_ViewController.h"
#import "BW_More_ViewController.h"
#import "BWMerchentLocationViewController.h"


@interface BWViewController ()

@end

@implementation BWViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        objCatBL = [[BWCateoryOfferBL alloc] init];
        objCatBL.callBack = self;
        
        arrOffers = [[NSMutableArray alloc] init];
        arrOffersBackUp = [[NSMutableArray alloc] init];
        
        dictCatOffers = [[NSMutableDictionary alloc] init];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self screenDesigningForUpperSlider];
    [self screenDesigningForContent];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    if([arrOffers count]==0)
    {
        isSingle = YES;
        [self refreshView];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"This build is in progress" message:@"Do you want to test stacked offer functionality which is in progress." delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
//        [alert show];
//        alert = nil;
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        isSingle = NO;
        [self refreshView];
    }
    else
    {
        isSingle = YES;
        [self refreshView];
    }
}
- (void)refreshView
{
    if([arrOffers count]==0)
    {
        float off = scrlViewCategory.scrlViewCategory.contentOffset.x;
        int rem = off / 160;
        if(rem==0)
        {
            [self getOffers:@""];
        }
        else if(rem==1)
        {
            [self getOffers:@"24"];//Food & Drink
        }
        else if(rem==2)
        {
            [self getOffers:@"35"];
        }
        else if(rem==3)
        {
            [self getOffers:@"70"];
        }
        else if(rem==4)
        {
            [self getOffers:@"card%20rebate"];
        }
    }
}
- (void)screenDesigningForContent
{
    scrlViewContent = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, 320, IS_IPHONE_5?500:414)];
    scrlViewContent.scrollEnabled = NO;
    scrlViewContent.pagingEnabled = YES;
//    scrlViewContent.delegate = self;
    scrlViewContent.contentSize = CGSizeMake(320*6, 414);
    //    scrlViewContent
    scrlViewContent.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrlViewContent];
    
    
    tblCat1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, IS_IPHONE_5?500:414) style:UITableViewStyleGrouped];
    tblCat1.tag = 100;
    tblCat1.dataSource = self;
    tblCat1.delegate = self;
    tblCat1.separatorStyle = UITableViewCellSeparatorStyleNone;
    tblCat1.backgroundColor = colorTableBG;
    [scrlViewContent addSubview:tblCat1];

    tblCat2 = [[UITableView alloc] initWithFrame:CGRectMake(320, 0, 320, IS_IPHONE_5?500:414) style:UITableViewStylePlain];
    tblCat2.tag = 200;
    tblCat2.dataSource = self;
    tblCat2.delegate = self;
    tblCat2.separatorStyle = UITableViewCellSeparatorStyleNone;
    tblCat2.backgroundColor = colorTableBG;
    [scrlViewContent addSubview:tblCat2];

    tblCat3 = [[UITableView alloc] initWithFrame:CGRectMake(640, 0, 320, IS_IPHONE_5?500:414) style:UITableViewStylePlain];
    tblCat3.tag = 300;
    tblCat3.dataSource = self;
    tblCat3.delegate = self;
    tblCat3.separatorStyle = UITableViewCellSeparatorStyleNone;
    tblCat3.backgroundColor = colorTableBG;
    [scrlViewContent addSubview:tblCat3];

    tblCat4 = [[UITableView alloc] initWithFrame:CGRectMake(960, 0, 320, IS_IPHONE_5?500:414) style:UITableViewStylePlain];
    tblCat4.tag = 400;
    tblCat4.dataSource = self;
    tblCat4.delegate = self;
    tblCat4.separatorStyle = UITableViewCellSeparatorStyleNone;
    tblCat4.backgroundColor = colorTableBG;
    [scrlViewContent addSubview:tblCat4];

    tblCat5 = [[UITableView alloc] initWithFrame:CGRectMake(1280, 0, 320, IS_IPHONE_5?500:414) style:UITableViewStylePlain];
    tblCat5.tag = 500;
    tblCat5.dataSource = self;
    tblCat5.delegate = self;
    tblCat5.separatorStyle = UITableViewCellSeparatorStyleNone;
    tblCat5.backgroundColor = colorTableBG;
    [scrlViewContent addSubview:tblCat5];

    tblCat6 = [[UITableView alloc] initWithFrame:CGRectMake(1600, 0, 320, IS_IPHONE_5?500:414) style:UITableViewStylePlain];
    tblCat6.tag = 600;
    tblCat6.dataSource = self;
    tblCat6.delegate = self;
    tblCat6.separatorStyle = UITableViewCellSeparatorStyleNone;
    tblCat6.backgroundColor = colorTableBG;
    [scrlViewContent addSubview:tblCat6];

    tblCat7 = [[UITableView alloc] initWithFrame:CGRectMake(1920, 0, 320, IS_IPHONE_5?500:414) style:UITableViewStylePlain];
    tblCat7.tag = 700;
    tblCat7.dataSource = self;
    tblCat7.delegate = self;
    tblCat7.separatorStyle = UITableViewCellSeparatorStyleNone;
    tblCat7.backgroundColor = colorTableBG;
    [scrlViewContent addSubview:tblCat7];

    
    viewPanel = [[UIView alloc] initWithFrame:CGRectMake(0, IS_IPHONE_5?526:440, 320, 100)];
    viewPanel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:viewPanel];
    
    UIImageView *imgViewPenal = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 42)];
    imgViewPenal.userInteractionEnabled = YES;
    imgViewPenal.backgroundColor = [UIColor clearColor];
    imgViewPenal.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"panel" ofType:@"png"]];
    [viewPanel addSubview:imgViewPenal];
    
    UIButton *btnBuck = [[UIButton alloc] initWithFrame:CGRectMake(240, 5, 30, 30)];
    btnBuck.backgroundColor = [UIColor clearColor];
    [btnBuck setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon-bucky" ofType:@"png"]] forState:UIControlStateNormal];
    [btnBuck addTarget:self action:@selector(penalClicked) forControlEvents:UIControlEventTouchUpInside];
    [viewPanel addSubview:btnBuck];

    
    UIButton *btnProfile = [[UIButton alloc] initWithFrame:CGRectMake(0, 40, 160, 60)];
    [btnProfile setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"moreButton" ofType:@"png"]] forState:UIControlStateNormal];
    [btnProfile addTarget:self action:@selector(profileClicked) forControlEvents:UIControlEventTouchUpInside];
    [viewPanel addSubview:btnProfile];

    UIButton *btnMyCoupon = [[UIButton alloc] initWithFrame:CGRectMake(160, 40, 160, 60)];
    [btnMyCoupon setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"myOfferssButton" ofType:@"png"]] forState:UIControlStateNormal];
    [btnMyCoupon addTarget:self action:@selector(myCouponsClicked) forControlEvents:UIControlEventTouchUpInside];
    [viewPanel addSubview:btnMyCoupon];

    
}
- (void)myCouponsClicked
{
    if(appDelegate.objUserLogedIn)
    {
        BWMyCouponsViewController *objVC = [[BWMyCouponsViewController alloc] init];
        [self.navigationController pushViewController:objVC animated:YES];
        objVC = nil;
    }
    else
    {
        if(objLoginVC==nil)
            objLoginVC = [[BW_Login_ViewController alloc] init];
        objLoginVC.callBack = self;
        objLoginVC.isMore = NO;
        [self presentViewController:objLoginVC animated:YES completion:nil];
    }
}
- (void)profileClicked
{
    if(appDelegate.objUserLogedIn)
    {
        BW_More_ViewController *objVC = [[BW_More_ViewController alloc] init];
        objVC.callbackToHome = self;
        [self.navigationController pushViewController:objVC animated:YES];
        objVC = nil;
    }
    else
    {
        if(objLoginVC==nil)
            objLoginVC = [[BW_Login_ViewController alloc] init];
        objLoginVC.callBack = self;
        objLoginVC.isMore = YES;
        [self presentViewController:objLoginVC animated:YES completion:nil];
    }
}
- (void)penalClicked
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.29];
    [UIView setAnimationDelegate:nil];

    if(viewPanel.frame.origin.y==526 || viewPanel.frame.origin.y==440)
        viewPanel.frame = CGRectMake(0, IS_IPHONE_5?526-50:440-50, 320, 100);
    else
        viewPanel.frame = CGRectMake(0, IS_IPHONE_5?526:440, 320, 100);
    
    [UIView commitAnimations];
}


- (void)screenDesigningForUpperSlider
{
    float width = 160;
    float xRef = 0;
    float yRef = 0.0;
    float xSpace = 0.0;

    UIFont *fontUsed = [UIFont boldSystemFontOfSize:14.0];

    UIColor *colorButtonBG = [UIColor clearColor];
    UIColor *colorNormal = [UIColor colorWithRed:218.0/255 green:249.0/255 blue:181.0/255 alpha:1.0];
    UIColor *colorDisabled = [UIColor whiteColor];

    scrlViewCategory = [[UIScrollViewInView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
//    scrlViewCategory.contentSize = CGSizeMake(800, 44);
//    scrlViewCategory.clipsToBounds = NO;
//    scrlViewCategory.pagingEnabled = YES;
    scrlViewCategory.scrlViewCategory.delegate = self;
    scrlViewCategory.autoresizesSubviews = NO;
    scrlViewCategory.backgroundColor = colorGreen;
    [self.view addSubview:scrlViewCategory];

    viewSlide = [[UIView alloc] initWithFrame:CGRectMake(110, 52, 100, 3)];
    viewSlide.frame = CGRectMake(130, 52, 60, 3);
    viewSlide.backgroundColor = [UIColor colorWithRed:218.0/255 green:249.0/255 blue:181.0/255 alpha:1.0];
    [self.view addSubview:viewSlide];
    
    btnTab1UI = [[UIButton alloc] initWithFrame:CGRectMake(xRef, yRef, width, 44)];
    btnTab1UI.tag = 1001;
    btnTab1UI.backgroundColor = colorButtonBG;
    btnTab1UI.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnTab1UI.titleLabel.font = fontUsed;
    btnTab1UI.titleLabel.textColor = [UIColor darkGrayColor];
    btnTab1UI.titleLabel.numberOfLines = 0;
    [scrlViewCategory.scrlViewCategory addSubview:btnTab1UI];
    [btnTab1UI setTitleColor:colorNormal forState:UIControlStateNormal];
    [btnTab1UI setTitleColor:colorDisabled forState:UIControlStateDisabled];
    [btnTab1UI setTitle:@"NEARBY" forState:UIControlStateNormal];
    [btnTab1UI addTarget:self action:@selector(categoryClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    xRef += width+xSpace;
    
    btnTab2UI = [[UIButton alloc] initWithFrame:CGRectMake(xRef, yRef, width, 44)];
    btnTab2UI.tag = 1002;
    btnTab2UI.backgroundColor = colorButtonBG;
    btnTab2UI.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnTab2UI.titleLabel.font = fontUsed;
    btnTab2UI.titleLabel.textColor = [UIColor darkGrayColor];
    btnTab2UI.titleLabel.numberOfLines = 0;
    [scrlViewCategory.scrlViewCategory addSubview:btnTab2UI];
    [btnTab2UI setTitleColor:colorNormal forState:UIControlStateNormal];
    [btnTab2UI setTitleColor:colorDisabled forState:UIControlStateDisabled];
    [btnTab2UI setTitle:@"FOOD & DRINK" forState:UIControlStateNormal];
    [btnTab2UI addTarget:self action:@selector(categoryClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    xRef += width+xSpace;
    
    btnTab3UI = [[UIButton alloc] initWithFrame:CGRectMake(xRef, yRef, width, 44)];
    btnTab3UI.tag = 1003;
    btnTab3UI.backgroundColor = colorButtonBG;
    btnTab3UI.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnTab3UI.titleLabel.font = fontUsed;
    btnTab3UI.titleLabel.textColor = [UIColor darkGrayColor];
    btnTab3UI.titleLabel.numberOfLines = 0;
    [scrlViewCategory.scrlViewCategory addSubview:btnTab3UI];
    [btnTab3UI setTitleColor:colorNormal forState:UIControlStateNormal];
    [btnTab3UI setTitleColor:colorDisabled forState:UIControlStateDisabled];
    [btnTab3UI setTitle:@"CLOTHING" forState:UIControlStateNormal];
    [btnTab3UI addTarget:self action:@selector(categoryClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    xRef += width+xSpace;
    
    btnTab4UI = [[UIButton alloc] initWithFrame:CGRectMake(xRef, yRef, width, 44)];
    btnTab4UI.tag = 1004;
    btnTab4UI.backgroundColor = colorButtonBG;
    btnTab4UI.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnTab4UI.titleLabel.font = fontUsed;
    btnTab4UI.titleLabel.textColor = [UIColor darkGrayColor];
    btnTab4UI.titleLabel.numberOfLines = 0;
    [scrlViewCategory.scrlViewCategory addSubview:btnTab4UI];
    [btnTab4UI setTitleColor:colorNormal forState:UIControlStateNormal];
    [btnTab4UI setTitleColor:colorDisabled forState:UIControlStateDisabled];
    [btnTab4UI setTitle:@"SERVICES" forState:UIControlStateNormal];
    [btnTab4UI addTarget:self action:@selector(categoryClicked:) forControlEvents:UIControlEventTouchUpInside];

    xRef += width+xSpace;
    
    btnTab5UI = [[UIButton alloc] initWithFrame:CGRectMake(xRef, yRef, width, 44)];
    btnTab5UI.tag = 1005;
    btnTab5UI.backgroundColor = colorButtonBG;
    btnTab5UI.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnTab5UI.titleLabel.font = fontUsed;
    btnTab5UI.titleLabel.textColor = [UIColor darkGrayColor];
    btnTab5UI.titleLabel.numberOfLines = 0;
    [scrlViewCategory.scrlViewCategory addSubview:btnTab5UI];
    [btnTab5UI setTitleColor:colorNormal forState:UIControlStateNormal];
    [btnTab5UI setTitleColor:colorDisabled forState:UIControlStateDisabled];
    [btnTab5UI setTitle:@"ONLINE" forState:UIControlStateNormal];
    [btnTab5UI addTarget:self action:@selector(categoryClicked:) forControlEvents:UIControlEventTouchUpInside];

    xRef += width+xSpace;

    btnTab6UI = [[UIButton alloc] initWithFrame:CGRectMake(xRef, yRef, width, 44)];
    btnTab6UI.tag = 1006;
    btnTab6UI.backgroundColor = colorButtonBG;
    btnTab6UI.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnTab6UI.titleLabel.font = fontUsed;
    btnTab6UI.titleLabel.textColor = [UIColor darkGrayColor];
    btnTab6UI.titleLabel.numberOfLines = 0;
    [scrlViewCategory.scrlViewCategory addSubview:btnTab6UI];
    [btnTab6UI setTitleColor:colorNormal forState:UIControlStateNormal];
    [btnTab6UI setTitleColor:colorDisabled forState:UIControlStateDisabled];
    [btnTab6UI setTitle:@"Bthere" forState:UIControlStateNormal];
    [btnTab6UI addTarget:self action:@selector(categoryClicked:) forControlEvents:UIControlEventTouchUpInside];

    xRef += width+xSpace;
    
    btnTab7UI = [[UIButton alloc] initWithFrame:CGRectMake(xRef, yRef, width, 44)];
    btnTab7UI.tag = 1007;
    btnTab7UI.backgroundColor = colorButtonBG;
    btnTab7UI.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnTab7UI.titleLabel.font = fontUsed;
    btnTab7UI.titleLabel.textColor = [UIColor darkGrayColor];
    btnTab7UI.titleLabel.numberOfLines = 0;
    [scrlViewCategory.scrlViewCategory addSubview:btnTab7UI];
    [btnTab7UI setTitleColor:colorNormal forState:UIControlStateNormal];
    [btnTab7UI setTitleColor:colorDisabled forState:UIControlStateDisabled];
    [btnTab7UI setTitle:[@"Loyalty Offers" uppercaseString] forState:UIControlStateNormal];
    [btnTab7UI addTarget:self action:@selector(categoryClicked:) forControlEvents:UIControlEventTouchUpInside];

    
}

- (void)categoryClicked:(UIButton *)sender
{
    btnTab1UI.enabled = YES;
    btnTab2UI.enabled = YES;
    btnTab3UI.enabled = YES;
    btnTab4UI.enabled = YES;
    
//    float yRef = 66.0;
    switch (sender.tag) {
        case 1001:
        {

            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.29];
            [UIView setAnimationDelegate:nil];
            viewSlide.frame = CGRectMake(130, 52, 60, 3);
            [UIView commitAnimations];

            btnTab1UI.enabled = NO;
            break;
        }
        case 1002:
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.29];
            [UIView setAnimationDelegate:nil];
            viewSlide.frame = CGRectMake(110, 52, 100, 3);
            [UIView commitAnimations];

            btnTab2UI.enabled = NO;
        }
            break;
        case 1003:
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.29];
            [UIView setAnimationDelegate:nil];
            viewSlide.frame = CGRectMake(125, 52, 70, 3);
            [UIView commitAnimations];

            btnTab3UI.enabled = NO;
        }
            break;
        case 1004:
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.29];
            [UIView setAnimationDelegate:nil];
            viewSlide.frame = CGRectMake(127, 52, 68, 3);
            [UIView commitAnimations];

            btnTab4UI.enabled = NO;
        }
            break;
            
        case 1005:
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.29];
            [UIView setAnimationDelegate:nil];
            viewSlide.frame = CGRectMake(135, 52, 50, 3);
            [UIView commitAnimations];
            
            btnTab5UI.enabled = NO;
        }
            break;

        case 1006:
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.29];
            [UIView setAnimationDelegate:nil];
            viewSlide.frame = CGRectMake(137, 52, 46, 3);
            [UIView commitAnimations];
            
            btnTab6UI.enabled = NO;
        }
            break;

        case 1007:
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.29];
            [UIView setAnimationDelegate:nil];
            viewSlide.frame = CGRectMake(100, 52, 120, 3);
            [UIView commitAnimations];
            
            btnTab7UI.enabled = NO;
        }
            break;

        default:
            break;
    }
}

#pragma mark - Scroll delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([scrollView isEqual:scrlViewCategory.scrlViewCategory])
    {
        scrlViewContent.contentOffset = CGPointMake(2*scrlViewCategory.scrlViewCategory.contentOffset.x, scrlViewContent.contentOffset.y);
        
        int intPage = 1001+scrlViewCategory.scrlViewCategory.contentOffset.x/160;
        [self categoryClicked:(UIButton *)[self.view viewWithTag:intPage]];
    }
//    else if([scrollView isEqual:scrlViewContent])
//    {
//        scrlViewCategory.contentOffset = CGPointMake(scrlViewContent.contentOffset.y/2, scrlViewContent.contentOffset.y);
//    }
    
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2)
{

}

// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{

}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float off = scrlViewCategory.scrlViewCategory.contentOffset.x;
    int intTemp = off / 160;
    NSLog(@"intTemp=%i, intOffset=%i", intTemp, intOffset);
    if(intOffset != intTemp)
    {
        intOffset = intTemp;
        if(intOffset==0)
        {
            [self getOffers:@""];
        }
        else if(intOffset==1)
        {
            [self getOffers:@"24"];
        }
        else if(intOffset==2)
        {
            [self getOffers:@"35"];
        }
        else if(intOffset==3)
        {
            [self getOffers:@"70"];
        }
        else if(intOffset==4)
        {
            [self getOffers:@"card%20rebate"];
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
}

//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//{
//
//}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{

}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{

}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    return YES;
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{

}


#pragma mark TableView Delegate Datasource Methods
#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isSingle==YES)
    {
        if([tableView isEqual:tblCat1])
            return [arrSorted count]+[arrComingSoon count]+1;
        else
            return [arrSorted count]+[arrComingSoon count];
    }
    else
    {
        if([tableView isEqual:tblCat1])
            return [arrOffers count]+1;
        else
            return [arrOffers count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    viewHeader.backgroundColor = colorLightGrayForBG;
//    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 20)];
//    lblTitle.font = [UIFont systemFontOfSize:14.0];
//    lblTitle.textColor = [UIColor darkGrayColor];
//    lblTitle.backgroundColor = [UIColor clearColor];
//    if([arrOffers count]>1)
//        lblTitle.text = [NSString stringWithFormat:@"%i Offers available", [arrOffers count]];
//    else if([arrOffers count]==1)
//        lblTitle.text = [NSString stringWithFormat:@"%i Offer available", [arrOffers count]];
//    else
//        lblTitle.text = @"Offers not found!";
//    [viewHeader addSubview:lblTitle];
    
    return viewHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if([tableView isEqual:tblCat6])
        return 100;
    else
        return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    if([tableView isEqual:tblCat6])
        viewHeader.backgroundColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1.0];
    else
        viewHeader.backgroundColor = [UIColor clearColor];
    
    if([tableView isEqual:tblCat6])
    {
        viewHeader.frame = CGRectMake(0, 0, 320, 100);
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 100)];
        lblTitle.font = [UIFont systemFontOfSize:14.0];
        lblTitle.numberOfLines = 0;
        lblTitle.textColor = [UIColor darkGrayColor];
        lblTitle.backgroundColor = [UIColor clearColor];
        lblTitle.text = @"Coming Soon!! View user and business generated video snippets of your favorite spots!  See what's happening now and last 7 days!  Merchant video discount offers and more!";
        [viewHeader addSubview:lblTitle];
    }

    return viewHeader;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictOffer;
    NSArray *arrTemp;
    NSString *CellIdentifier;
    
    if(indexPath.row == 0 && [tableView isEqual:tblCat1])
    {
        CellIdentifier = [NSString stringWithFormat:@"Offer %@", @"0"];
    }
    else if(indexPath.row > 0 && [tableView isEqual:tblCat1])
    {
        if(isSingle==YES)
        {
            if([arrSorted count]>indexPath.row-1)
            {
                arrTemp = [dictSorted objectForKey:[arrSorted objectAtIndex:indexPath.row-1]];
                dictOffer = [arrTemp lastObject];
            }
            else
            {
                dictOffer = [arrComingSoon objectAtIndex:indexPath.row-1-[arrSorted count]];
            }
        }
        else
            dictOffer = [arrOffers objectAtIndex:indexPath.row-1];
        CellIdentifier = [NSString stringWithFormat:@"Offer %@", [dictOffer objectForKey:@"id"]];
    }
    else
    {
        if(isSingle==YES)
        {
            if([arrSorted count]>indexPath.row)
            {
                arrTemp = [dictSorted objectForKey:[arrSorted objectAtIndex:indexPath.row]];
                dictOffer = [arrTemp lastObject];
            }
            else
            {
                dictOffer = [arrComingSoon objectAtIndex:indexPath.row-[arrSorted count]];
            }
        }
        else
        {
            dictOffer = [arrOffers objectAtIndex:indexPath.row];
        }
        CellIdentifier = [NSString stringWithFormat:@"Offer %@", [dictOffer objectForKey:@"id"]];
    }
    BW_AnonymousUser_DigitalCoupon_TableViewCell *cell = (BW_AnonymousUser_DigitalCoupon_TableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        @autoreleasepool {
            cell = [[BW_AnonymousUser_DigitalCoupon_TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.strImagePath = strImagePath;
        }
    }
    
    
    if(indexPath.row == 0 && [tableView isEqual:tblCat1])
    {
        [cell hideAll];
        UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
        viewHeader.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imgViewSearchBG = [[UIImageView alloc] init];
        imgViewSearchBG.frame = CGRectMake(0, 0, 320, 45);
        imgViewSearchBG.backgroundColor = [UIColor clearColor];
        imgViewSearchBG.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"searchBG" ofType:@"png"]];
        [viewHeader addSubview:imgViewSearchBG];

        UILabel *lblSearch = [[UILabel alloc] init];
        lblSearch.frame = CGRectMake(40, 0, 200, 44);
        lblSearch.textColor = [UIColor lightGrayColor];
        lblSearch.backgroundColor = [UIColor clearColor];
        lblSearch.font = [UIFont boldSystemFontOfSize:20];
        lblSearch.text = @"Search";
        [viewHeader addSubview:lblSearch];

        imgViewSearchBG = [[UIImageView alloc] init];
        imgViewSearchBG.frame = CGRectMake(0, 45, 320, 158);
        imgViewSearchBG.backgroundColor = [UIColor clearColor];
        imgViewSearchBG.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg" ofType:@"png"]];
        [viewHeader addSubview:imgViewSearchBG];
        
        UIButton *btnGlob = [[UIButton alloc] initWithFrame:CGRectMake(320-44, 0, 44, 45)];
        [btnGlob addTarget:self action:@selector(showMerchants) forControlEvents:UIControlEventTouchUpInside];
        [btnGlob setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"globe" ofType:@"png"]] forState:UIControlStateNormal];
        btnGlob.backgroundColor = [UIColor clearColor];
        [viewHeader addSubview:btnGlob];
        
        for (int i=0; i<6; i++) {
            
            UIButton *btnIcon = [[UIButton alloc] initWithFrame:CGRectMake(30+((i<3)?i*105:(i-3)*105), i<3?50:120, 50, 50)];
            btnIcon.tag = 1001+i;
            [btnIcon addTarget:self action:@selector(iconClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btnIcon setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"blankIcon" ofType:@"png"]] forState:UIControlStateNormal];
            btnIcon.backgroundColor = [UIColor clearColor];
            [viewHeader addSubview:btnIcon];
        }
        [cell addSubview:viewHeader];
    }
    else //if(indexPath.row > 0 && [tableView isEqual:tblCat1])
    {
        cell.btnOfferList.tag = 1000+indexPath.row;
        [cell.btnOfferList addTarget:self action:@selector(selectOfferClicked:) forControlEvents:UIControlEventTouchUpInside];

        if(isSingle==YES)
        {
            cell.isSingle = YES;
            cell.arrOffers = [[NSMutableArray alloc] initWithArray:arrTemp];
        }
        [cell setParameter:dictOffer];
    }
    cell.backgroundColor = colorTableBG;
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}
- (void)showMerchants
{
    BWMerchentLocationViewController *objMapVC = [[BWMerchentLocationViewController  alloc] init];
    self.title = objMapVC.title;
    [self.navigationController pushViewController:objMapVC animated:YES];
    objMapVC = nil;
}

- (void)iconClicked:(UIButton *)sender
{
    if(sender.tag == 1001)
        [self getOffers:@"24"];
    else if(sender.tag == 1002)
        [self getOffers:@""];
    else if(sender.tag == 1003)
        [self getOffers:@"31"];
    else if(sender.tag == 1004)//Loyalty Offer
    {
//        [self getOffers:@"40"];
        [arrSorted removeAllObjects];
        [arrComingSoon removeAllObjects];
        [arrOffers removeAllObjects];
        [tblCat1 reloadData];
    }
    else if(sender.tag == 1005)
    {
        [self showAlertWithOKAndMessage:@"Coming Soon!! View user and business generated video snippets of your favorite spots!  See what's happening now and last 7 days!  Merchant video discount offers and more!"];
//        [self getOffers:@"41"];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dictOffer;
    if(indexPath.row > 0 && [tableView isEqual:tblCat1])
    {
        if(isSingle==YES)
        {
            if([arrSorted count]>indexPath.row-1)
            {
                NSArray *arrTemp = [dictSorted objectForKey:[arrSorted objectAtIndex:indexPath.row-1]];
                dictOffer = [arrTemp lastObject];
            }
            else
            {
                dictOffer = [arrComingSoon objectAtIndex:indexPath.row-1-[arrSorted count]];
            }
        }
        else
        {
            dictOffer = [arrOffers objectAtIndex:indexPath.row-1];
        }
        NSString *strOfferType = [dictOffer objectForKey:@"offer_master_type"]?[dictOffer objectForKey:@"offer_master_type"]:@"";
        if([[strOfferType lowercaseString] isEqualToString:@"digital"] || [[strOfferType lowercaseString] isEqualToString:@"card rebate"] || [[strOfferType lowercaseString] isEqualToString:@"purchase"])
        {
            BW_AnonymousUser_DigitalCoupon_TableViewCell *cell = (BW_AnonymousUser_DigitalCoupon_TableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            BWOfferDetailViewController *objVC = [[BWOfferDetailViewController alloc] init];
            objVC.strImagePath = strImagePath;
            objVC.dictOffer = dictOffer;
            objVC.intType = Digital;
            objVC.intStatus = tagAvailable;
            objVC.imageOffer = [cell getImageOfCell];
            [appDelegate.navController pushViewController:objVC animated:YES];
            objVC = nil;
        }
        else if([[strOfferType lowercaseString] isEqualToString:@"comingsoon"])
        {
//            imgViewComingSoon.hidden = NO;
//            lblOfferType.text = @"Coming Soon";
        }

    }
    else
    {
        if(isSingle==YES)
        {
            if([arrSorted count]>indexPath.row)
            {
                NSArray *arrTemp = [dictSorted objectForKey:[arrSorted objectAtIndex:indexPath.row]];
                dictOffer = [arrTemp lastObject];
            }
            else
            {
                dictOffer = [arrComingSoon objectAtIndex:indexPath.row-[arrSorted count]];
            }
        }
        else
        {
            dictOffer = [arrOffers objectAtIndex:indexPath.row];
        }
        NSString *strOfferType = [dictOffer objectForKey:@"offer_master_type"]?[dictOffer objectForKey:@"offer_master_type"]:@"";
        if([[strOfferType lowercaseString] isEqualToString:@"digital"] || [[strOfferType lowercaseString] isEqualToString:@"card rebate"] || [[strOfferType lowercaseString] isEqualToString:@"purchase"])
        {
            
            BW_AnonymousUser_DigitalCoupon_TableViewCell *cell = (BW_AnonymousUser_DigitalCoupon_TableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            BWOfferDetailViewController *objVC = [[BWOfferDetailViewController alloc] init];
            objVC.strImagePath = strImagePath;
            objVC.dictOffer = dictOffer;
            objVC.intType = Digital;
            objVC.intStatus = tagAvailable;
            objVC.imageOffer = [cell getImageOfCell];
            [appDelegate.navController pushViewController:objVC animated:YES];
            objVC = nil;
        }
        else if([[strOfferType lowercaseString] isEqualToString:@"comingsoon"])
        {
            //            imgViewComingSoon.hidden = NO;
            //            lblOfferType.text = @"Coming Soon";
        }
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictOffer;
    if(indexPath.row == 0 && [tableView isEqual:tblCat1])
    {
    }
    else if(indexPath.row > 0 && [tableView isEqual:tblCat1])
    {
        if(isSingle==YES)
        {
            if([arrSorted count]>indexPath.row-1)
            {
                NSArray *arrTemp = [dictSorted objectForKey:[arrSorted objectAtIndex:indexPath.row-1]];
                dictOffer = [arrTemp lastObject];
            }
            else
            {
                dictOffer = [arrComingSoon objectAtIndex:indexPath.row-1-[arrSorted count]];
            }
        }
        else
        {
            dictOffer = [arrOffers objectAtIndex:indexPath.row-1];
        }
    }
    else
    {
        if(isSingle==YES)
        {
            if([arrSorted count]>indexPath.row)
            {
                NSArray *arrTemp = [dictSorted objectForKey:[arrSorted objectAtIndex:indexPath.row]];
                dictOffer = [arrTemp lastObject];
            }
            else
            {
                dictOffer = [arrComingSoon objectAtIndex:indexPath.row-[arrSorted count]];
            }
        }
        else
        {
            dictOffer = [arrOffers objectAtIndex:indexPath.row];
        }
    }

    [(BW_AnonymousUser_DigitalCoupon_TableViewCell *)cell showOfferImage:dictOffer];
}

#pragma mark - WISHWORM
- (void)selectOfferClicked:(UIButton *)sender
{
//    dictSelectedWishworm = nil;
//    dictSelectedWishworm = [[dictMerchants objectForKey:[arrMerchantKey objectAtIndex:sender.tag-1000]] objectForKey:@"offer"];
//    
//    canWish=NO;
//    NSArray *arrDesc = [dictSelectedWishworm objectForKey:@"offer_desc"];
//    if(arrDesc && [arrDesc count]>0)
//    {
//        NSDictionary *dictDesc = [arrDesc objectAtIndex:0];
//        canWish=[[dictDesc objectForKey:@"can_wish"] integerValue]==1?YES:NO;
//    }
//    
//    NSArray *arrOption = [dictSelectedWishworm objectForKey:@"options"];
//    [arrMerchantOffer removeAllObjects];
//    [arrMerchantOffer addObjectsFromArray:arrOption];
    
    [self showOfferList:sender.tag-1000];
}

- (void)showOfferList:(NSInteger)intTag
{
    if(pickerOffer==nil)
    {
        pickerOffer = [[UIPickerView alloc] init];
        //        pickerOffer.tag = tagIam;
        pickerOffer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.9];
        pickerOffer.frame = CGRectMake(0, 600, 320, 200);
        pickerOffer.showsSelectionIndicator = YES;
        pickerOffer.delegate = self;
        pickerOffer.dataSource = self;
        [self.view addSubview:pickerOffer];
        UITapGestureRecognizer *myGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerTapped:)];
        [pickerOffer addGestureRecognizer:myGR];
        
        btnPicketDone = [[UIButton alloc] initWithFrame:CGRectMake(320, IS_IPHONE_5?282:200, 77, 25)];
        [btnPicketDone setTitle:@"Done" forState:UIControlStateNormal];
        [btnPicketDone addTarget:self action:@selector(btnDoneClicked:) forControlEvents:UIControlEventTouchUpInside];
        btnPicketDone.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
        [btnPicketDone setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"btn_unselected_bg" ofType:@"png"]] forState:UIControlStateNormal];
        [btnPicketDone setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"btn_selected_bg" ofType:@"png"]] forState:UIControlStateHighlighted];
        [btnPicketDone setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"btn_selected_bg" ofType:@"png"]] forState:UIControlStateSelected];
        [self.view addSubview:btnPicketDone];
    }
    btnPicketDone.tag = intTag+5000;
    
    [pickerOffer reloadComponent:0];
//    if([arrMerchantOffer count]>0)
//    {
//        NSDictionary *dictOffer = [arrMerchantOffer objectAtIndex:0];
//        strOfferSelected = [NSString stringWithFormat:@"$%@ OFF %@", [dictOffer objectForKey:@"discount"], [dictSelectedWishworm objectForKey:@"maxSavings"]];
//        strNumberOfPeople = [dictOffer objectForKey:@"person_range"];
//        strDiscountDays = [dictOffer objectForKey:@"discount_days"];
//        
//        [pickerOffer selectRow:0 inComponent:0 animated:YES];
//    }
    
    [pickerOffer removeFromSuperview];
    [btnPicketDone removeFromSuperview];
    [self.view addSubview:pickerOffer];
    [self.view addSubview:btnPicketDone];
    
    if(pickerOffer.frame.origin.y>=600)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.29];
        [UIView setAnimationDelegate:nil];
        if(IS_IPHONE_5)
        {
            btnPicketDone.frame = CGRectMake(228, 282, 77, 25);
            pickerOffer.frame = CGRectMake(0, 282, 320, 180);
        }
        else
        {
            btnPicketDone.frame = CGRectMake(228, 200, 77, 25);
            pickerOffer.frame = CGRectMake(0, 200, 320, 180);
        }
        [UIView commitAnimations];
    }
    else
    {
        [self hideOfferPicker];
    }
}
- (void)hideOfferPicker
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.29];
    [UIView setAnimationDelegate:nil];
    btnPicketDone.frame = CGRectMake(320, IS_IPHONE_5?282:200, 77, 25);
    pickerOffer.frame = CGRectMake(0, 600, 320, 180);
    [UIView commitAnimations];
    
}

// target method

-(void)pickerTapped:(id)sender
{
    // your code
}
- (void)btnDoneClicked:(UIButton *)sender
{
    [self hideOfferPicker];
    
//    if([strOfferSelected isEqualToString:@"Make a wish for an offer"])
//    {
//        BW_WishwormOffer_TableViewCell *cell = (BW_WishwormOffer_TableViewCell *)[tblMerchents cellForRowAtIndexPath:[NSIndexPath indexPathForItem:sender.tag-5000 inSection:0]];
//        
//        BW_MakeAWishForAnOffer_ViewController *objVC = [[BW_MakeAWishForAnOffer_ViewController alloc] init];
//        objVC.imgMerchant = [cell getImageOfMerchant];
//        objVC.dictSelectedWishworm = dictSelectedWishworm;
//        [self.callbackToHome.navigationController pushViewController:objVC animated:YES];
//        objVC = nil;
//    }
//    else
//    {
//        [DSBezelActivityView newActivityViewForView:appDelegate.navController.view
//                                          withLabel:@"Selecting option..."];
//        NSDictionary *dictOffer = [arrMerchantOffer objectAtIndex:sender.tag-5000];
//        [objWishOperationBL selectAnOption:[dictOffer objectForKey:@"option_id"]];
//    }
}
- (void)wishwormOperationsParserFinished:(NSDictionary *)dictOffers
{
//    [DSBezelActivityView removeViewAnimated:YES];
//    if([[dictOffers objectForKey:@"statusDescription"] isEqualToString:@"Success"])
//    {
//        BW_WishwormOffer_TableViewCell *cell = (BW_WishwormOffer_TableViewCell *)[tblMerchents cellForRowAtIndexPath:[NSIndexPath indexPathForItem:btnPicketDone.tag-5000 inSection:0]];
//        
//        BW_MerchantOfferDetail_ViewController *objVC = [[BW_MerchantOfferDetail_ViewController alloc] init];
//        objVC.callBackTabBar = self.callbackToHome;
//        objVC.strAccountToken = appDelegate.objUserLogedIn.strAccessToken;
//        objVC.strOfferType = strOfferSelected;
//        objVC.strNumberOfPeople = strNumberOfPeople;
//        objVC.strDiscountDays = strDiscountDays;
//        objVC.dictOfferDetails = dictSelectedWishworm;
//        objVC.imgOffer = [cell getImageOfMerchant];
//        [self.callbackToHome.navigationController pushViewController:objVC animated:YES];
//        objVC = nil;
//    }
//    else
//    {
//        [self performSelectorOnMainThread:@selector(showAlertWithOKAndMessage:) withObject:@"Error in selecting option." waitUntilDone:NO];
//    }
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
//    if(canWish)
//        return [arrMerchantOffer count]+1;
//    else
//        return [arrMerchantOffer count];
    return 0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    NSString *strTitle;
//    if([arrMerchantOffer count]>row)
//    {
//        NSDictionary *dictOffer = [arrMerchantOffer objectAtIndex:row];
//        strTitle = [NSString stringWithFormat:@"%@ - %@%% discount - save $%@ - %@", [dictOffer objectForKey:@"person_range"], [dictOffer objectForKey:@"discount"], [dictOffer objectForKey:@"discount"], [dictOffer objectForKey:@"discount_days"]];
//    }
//    else
//    {
//        strTitle = @"Make a wish for an offer";
//    }
    UILabel *lblForRow = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 50)];
    lblForRow.textAlignment = NSTextAlignmentCenter;
    lblForRow.textColor = [UIColor darkGrayColor];
    lblForRow.numberOfLines = 0;
    lblForRow.text = strTitle;
    return lblForRow;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    if([arrMerchantOffer count]>row)
//    {
//        NSDictionary *dictOffer = [arrMerchantOffer objectAtIndex:row];
//        strOfferSelected = [NSString stringWithFormat:@"$%@ OFF %@", [dictOffer objectForKey:@"discount"], [dictSelectedWishworm objectForKey:@"maxSavings"]];
//        strNumberOfPeople = [dictOffer objectForKey:@"person_range"];
//        strDiscountDays = [dictOffer objectForKey:@"discount_days"];
//    }
//    else
//    {
//        strOfferSelected = @"Make a wish for an offer";
//    }
}

#pragma mark - Paresr
- (void)getOffers:(NSString *)strCat
{
    NSArray *arrTemp = nil;
    
    if([strCat length]>0)
    {
        arrTemp = [dictCatOffers objectForKey:strCat];
        strCatID = strCat;
    }
    else
    {
        arrTemp = [dictCatOffers objectForKey:@"NearBy"];
        strCatID = @"NearBy";
    }
    if(arrTemp && [arrTemp count]>0)
    {
        [arrOffers removeAllObjects];
        [arrOffers addObjectsFromArray:arrTemp];
        [arrOffersBackUp removeAllObjects];
        [arrOffersBackUp addObjectsFromArray:arrTemp];
        
        if(isSingle==YES)
            [self filterOffers];
        
        float off = scrlViewCategory.scrlViewCategory.contentOffset.x;
        int rem = off / 160;
        
        if(rem==0)
            [tblCat1 reloadData];
        else if(rem==1)
            [tblCat2 reloadData];
        else if(rem==2)
            [tblCat3 reloadData];
        else if(rem==3)
            [tblCat4 reloadData];
        else if(rem==4)
            [tblCat5 reloadData];
        else if(rem==5)
            [tblCat6 reloadData];
        else if(rem==6)
            [tblCat7 reloadData];
        
    }
    else
    {
        [DSBezelActivityView newActivityViewForView:self.view
                                          withLabel:@"Loading..."];
        [objCatBL getOfferOfCategory:strCatID andType:@""];
    }
}

- (void)categoryOfferParserFinished:(NSDictionary *)dictOffers
{
    strImagePath = [dictOffers objectForKey:@"imagePath"];
    [arrOffers removeAllObjects];
    [arrOffers addObjectsFromArray:[dictOffers objectForKey:@"offers"]];
    [arrOffersBackUp removeAllObjects];
    [arrOffersBackUp addObjectsFromArray:[dictOffers objectForKey:@"offers"]];

    [dictCatOffers setObject:[dictOffers objectForKey:@"offers"] forKey:strCatID];
    
    if(isSingle==YES)
        [self filterOffers];

    float off = scrlViewCategory.scrlViewCategory.contentOffset.x;
    int rem = off / 160;

    if(rem==0)
        [tblCat1 reloadData];
    else if(rem==1)
        [tblCat2 reloadData];
    else if(rem==2)
        [tblCat3 reloadData];
    else if(rem==3)
        [tblCat4 reloadData];
    else if(rem==4)
        [tblCat5 reloadData];
    else if(rem==5)
        [tblCat6 reloadData];
    else if(rem==6)
        [tblCat7 reloadData];

    [DSBezelActivityView removeViewAnimated:YES];

    NSLog(@"dictOffers - %@", dictOffers);
}

- (void)filterOffers
{
    arrSorted = nil;
    arrComingSoon = nil;
    dictSorted = nil;

    arrSorted = [[NSMutableArray alloc] init];
    arrComingSoon = [[NSMutableArray alloc] init];
    dictSorted = [[NSMutableDictionary alloc] init];
    
    NSMutableArray *arrTemp;
    for (int i=0; i<[arrOffers count]; i++)
    {
        @autoreleasepool {
            NSDictionary *dictOffer = [arrOffers objectAtIndex:i];

            NSString *strOfferType = [dictOffer objectForKey:@"offer_master_type"]?[dictOffer objectForKey:@"offer_master_type"]:@"";
            if(![[strOfferType lowercaseString] isEqualToString:@"comingsoon"])
            {
                NSString *strKey = [dictOffer objectForKey:@"merchant_id"];
                
                arrTemp = [dictSorted objectForKey:strKey];
                if(arrTemp ==nil)
                {
                    arrTemp=[[NSMutableArray alloc]init];
                    [arrTemp addObject:dictOffer];
                    [dictSorted setObject:arrTemp forKey:strKey];
                    arrTemp = nil;
                }
                else {
                    [arrTemp addObject:dictOffer];
                }
            }
            else {
                [arrComingSoon addObject:dictOffer];
            }
            dictOffer = nil;
        }
    }

    [arrSorted addObjectsFromArray:[dictSorted allKeys]];
    [arrSorted sortedArrayUsingSelector:@selector(compare:)];
    
    [arrOffers removeAllObjects];

    for (int i=0; i<[arrSorted count]; i++) {
        NSString *strKey = [arrSorted objectAtIndex:i];
        NSArray *arrMerchant = [dictSorted objectForKey:strKey];
        
        if([arrMerchant count]>0)
        {
            NSDictionary *dictMerchantOffer = [arrMerchant lastObject];
            [arrOffers addObject:dictMerchantOffer];
        }
    }
}
- (void)errorInParseing:(NSError *)error
{
    [DSBezelActivityView removeViewAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

