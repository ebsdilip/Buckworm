//
//  UINavigationBar+CustomImage.m
//  Buckworm
//
//  Created by Developer on 6/10/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "UINavigationBar+CustomImage.h"

@implementation UINavigationBar (CustomImage)

- (void) setBackgroundImage:(UIImage*)image
{
    if (image == NULL) return;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, 320, 44);
    [self insertSubview:imageView atIndex:0];
    imageView = nil;
}

- (void) clearBackgroundImage
{
    NSArray *subviews = [self subviews];
    for (int i=0; i<[subviews count]; i++)
    {
        if ([[subviews objectAtIndex:i]  isMemberOfClass:[UIImageView class]])
        {
            [[subviews objectAtIndex:i] removeFromSuperview];
        }
    }
}

@end
