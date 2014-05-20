//
//  RequestPackage.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/19/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "RequestPackage.h"
#import <AFNetworking.h>
#import <AFHTTPRequestOperation.h>



static RequestPackage * PublicObject;

@implementation RequestPackage



+(RequestPackage*)shareObject
{
    if (PublicObject==nil) {
        PublicObject=[[RequestPackage alloc]init];
    }
    return PublicObject;
}


-(id)init
{
    self=[super init];
    if (self) {
        //init code here
    }
    return self;
}


-(BOOL)Logout
{
    NSString *passphare=[[NSUserDefaults standardUserDefaults]decryptedValueForKey:USER_Token];
    
    
    
    return NO;
}

@end
