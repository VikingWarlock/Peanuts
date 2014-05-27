//
//  StaticDataManager.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/27/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "StaticDataManager.h"

static StaticDataManager * shared;

/*
static NSMutableArray *ActivityList;
static NSMutableArray *SquareList;
static NSMutableArray *MustReadList;
static NSMutableArray *HomePageList;
*/



@implementation StaticDataManager
{
    NSMutableArray *ActivitiesList;
    NSMutableArray *SquareList;
    NSMutableArray *MustReadList;
    NSMutableDictionary *HomePageList;

}

+(StaticDataManager*)sharedObject
{
    if (shared==nil) {
        shared=[[StaticDataManager alloc]init];
    }
        
    return shared;
    
}

+(void)refreshStaticData
{
    
    
    

}

-(void)updateHomePageData:(NSDictionary *)array
{
    HomePageList=[NSMutableDictionary dictionaryWithDictionary:array];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Home Page Hase Been Update" object:nil];
    
}

-(NSDictionary*)FetchHomePage
{
    return  HomePageList;
}


@end
