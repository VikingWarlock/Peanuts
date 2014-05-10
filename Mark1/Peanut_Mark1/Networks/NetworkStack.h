//
//  NetworkStack.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkStack : NSObject

+(NetworkStack*)PublicObject;

-(BOOL)isRequesting;

-(void)AddRequestToStack:(NSURL*)url AndParameter:(NSDictionary*)parameter;

-(void)reloadRequest;


@end
