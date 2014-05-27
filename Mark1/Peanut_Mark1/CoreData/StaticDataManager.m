//
//  StaticDataManager.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/27/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "StaticDataManager.h"

static StaticDataManager * shared;
static NSMutableArray *ActivityList;
static NSMutableArray *SquareList;
static NSMutableArray *MustReadList;



@implementation StaticDataManager


+(StaticDataManager*)sharedObject
{
    if (shared==nil) {
        shared=[[StaticDataManager alloc]init];
    }
        
    return shared;
    
}




@end
