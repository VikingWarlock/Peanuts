//
//  NetworkStack.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//


#import "NetworkStack.h"
#import <AFNetworking.h>
#import <AFHTTPRequestOperation.h>



static NetworkStack *shared;

@interface NetworkStack()
{
    BOOL nowRequesting;
    NSMutableArray *RequestList;
    
}

@end


@implementation NetworkStack

-(id)init
{
    self=[super init];
    nowRequesting=NO;
    RequestList=[[NSMutableArray alloc]init];
    return self;
    
}

+(NetworkStack*)PublicObject
{
    if (shared==nil)
        shared=[[NetworkStack alloc]init];
    
    
    return shared;
    
}


-(BOOL)isRequesting
{
    return nowRequesting;
}


-(void)AddRequestToStack:(NSURL *)url AndParameter:(NSDictionary *)parameter
{
    
    
}

-(void)reloadRequest
{
    if ([RequestList count]>0) {
        
    }else
    {
        
    }
}



#pragma private method

-(void)post
{
    
}
@end
