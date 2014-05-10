//
//  NSString+extra.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "NSString+extra.h"

@implementation NSString (extra)

-(NSString*)PeanutString
{
    NSString *str=NSLocalizedString(self, @"");
    if ([str length]<=0) {
        return self;
    }else
        return [str copy];

}

@end
