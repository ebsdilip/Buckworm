//
//  BW_AddCard_ViewController.h
//  buckworm
//
//  Created by TechSunRise on 6/19/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BW_Base_ViewController.h"
#import "BW_MyCards_BL.h"

@interface BW_AddCard_ViewController : BW_Base_ViewController<BW_MyCards_BL_Delegate, UIWebViewDelegate>
{
    NSString *strAddCardURLToLoad;
    BW_MyCards_BL *objMyCardsBL;
    UIWebView *webViewAddCards;
}
@end
