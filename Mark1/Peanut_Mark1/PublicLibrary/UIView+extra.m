//
//  UIView+extra.m
//  test demo
//
//  Created by viking warlock on 5/8/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "UIView+extra.h"

@implementation UIView (extra)

-(UIImage*)captureView
{
    CGRect rect = self.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


@end
