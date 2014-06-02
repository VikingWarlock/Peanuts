//
//  NSDictionary+extra.m
//  Peanut_Mark1
//
//  Created by viking warlock on 6/2/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "NSDictionary+extra.h"

@implementation NSDictionary (extra)

-(NSString*)StringForKey:(NSString *)key
{
    if ([self objectForKey:key]) {
        return [self objectForKey:key];
    }else
        return @"null";


}

@end
