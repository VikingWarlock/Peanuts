//
//  CoreData-Helper.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/26/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfEntity.h"


@interface CoreData_Helper : NSObject


+(void)addPhotoEntity:(NSDictionary*)parameter;

+(void)addPhotoSeriesEntity:(NSDictionary *)parameter;

+(void)addActivityEntity:(NSDictionary*)parameter;

+(void)addMustReadEntity:(NSDictionary*)parameter;

+(void)addUserInfoEntity:(NSDictionary*)parameter;

+(void)updateUserEntity:(NSString*)user_id;

+(void)updateSelfUserEntity;

+(UserInfEntity*)GetUserInfEntity:(NSString*)uid;

+(UserInfEntity*)GetSelfUserInfEntity;

+(void)updateStaticData;


@end
