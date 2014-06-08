//
//  NetworkRequest.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/12/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef NS_ENUM(NSInteger, Method_NetworkRequest) {
    Method_Post=0,
    Method_Get
};


@interface NetworkRequest : NSManagedObject

@property (nonatomic, retain) id requestParameter;
@property (nonatomic, retain) NSNumber * requestPosition;
@property (nonatomic, retain) NSString * requestUrl;
@property (nonatomic, retain) id requestSucceed;
@property (nonatomic, retain) NSNumber * requestMethod;

@end
