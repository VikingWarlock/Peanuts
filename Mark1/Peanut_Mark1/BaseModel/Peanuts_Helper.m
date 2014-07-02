//
//  Peanuts_Helper.m
//  Peanut_Mark1
//
//  Created by viking warlock on 7/2/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "Peanuts_Helper.h"

@implementation Peanuts_Helper

+(CGColorRef) getColorFromRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha
{
    CGFloat r = (CGFloat) red/255.0;
    CGFloat g = (CGFloat) green/255.0;
    CGFloat b = (CGFloat) blue/255.0;
    CGFloat a = (CGFloat) alpha/255.0;
    CGFloat components[4] = {r,g,b,a};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGColorRef color =CGColorCreate(colorSpace, components);
    CGColorSpaceRelease(colorSpace);
    
    return color;
}



@end
