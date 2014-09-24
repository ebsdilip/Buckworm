//
//  UIScrollViewInView.m
//  Buckworm
//
//  Created by Developer on 8/27/14.
//  Copyright (c) 2014 Engtelegent. All rights reserved.
//

#import "UIScrollViewInView.h"

@implementation UIScrollViewInView

@synthesize scrlViewCategory;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
        scrlViewCategory = [[UIScrollView alloc] initWithFrame:CGRectMake(80, 0, 160, 64)];
        scrlViewCategory.contentSize = CGSizeMake(1120, 44);
        scrlViewCategory.clipsToBounds = NO;
        scrlViewCategory.pagingEnabled = YES;
//        scrlViewCategory.delegate = self;
        scrlViewCategory.showsHorizontalScrollIndicator = NO;
        scrlViewCategory.autoresizesSubviews = NO;
        scrlViewCategory.backgroundColor = colorGreen;
        [self addSubview:scrlViewCategory];
    }
    return self;
}
-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    UIView* child = nil;
    if ((child = [super hitTest:point withEvent:event]) == self)
    	return scrlViewCategory;
    return child;
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
