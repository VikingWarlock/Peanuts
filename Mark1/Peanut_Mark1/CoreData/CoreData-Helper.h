//
//  CoreData-Helper.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/26/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "PhotoInfoEntity.h"
#import "PhotoSeriesEntity.h"
#import "UserInfEntity.h"
#import "ActivityEntity.h"
#import "MustReadEntity.h"
#import "PhotoDetailEntity.h"


@interface CoreData_Helper : NSObject


+(void)addPhotoEntity:(NSDictionary*)parameter;

+(void)addPhotoSeriesEntity:(NSDictionary *)parameter;

+(void)addActivityEntity:(NSDictionary*)parameter;

+(void)addMustReadEntity:(NSDictionary*)parameter;

+(void)addUserInfoEntity:(NSDictionary*)parameter;


+(void)updateUserEntity:(NSString*)user_id;

+(void)updateSelfUserEntity;

+(PhotoInfoEntity*)GetPhotoEntity:(NSString*)feed_id;

+(PhotoSeriesEntity*)GetPhotoSeriesEntity:(NSString*)feed_id;

+(ActivityEntity*)GetActivityEntity:(NSString*)feed_id;

+(MustReadEntity*)GetMustReadEntity:(NSString*)feed_id;

+(UserInfEntity*)GetUserInfEntity:(NSString*)uid;

+(UserInfEntity*)GetSelfUserInfEntity;

+(void)updateStaticData;



+(NSString *)DateFromTimestamp:(NSString *)beginTimestamp endTimestamp:(NSString *)endTimestamp;

+(NSString *)TimeFromTimestamp:(NSString *)beginTimestamp endTimestamp:(NSString *)endTimestamp;

+(NSString *)DateAndTimeFromTimestamp:(NSString *)beginTimestamp endTimestamp:(NSString *)endTimestamp;


@end
