//
//  UserInfEntity.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/22/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserInfEntity : NSManagedObject

@property (nonatomic, retain) NSString * avatarPic;
@property (nonatomic, retain) id equipment;
@property (nonatomic, retain) NSNumber * followercount;
@property (nonatomic, retain) NSNumber * followingcount;
@property (nonatomic, retain) NSString * intro;
@property (nonatomic, retain) NSNumber * photocount;
@property (nonatomic, retain) NSNumber * sex;
@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) NSString * uname;
@property (nonatomic, retain) NSString * province;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * area;
@property (nonatomic, retain) NSString * login;

@end
