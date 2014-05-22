//
//  PhotoDetailEntity.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/22/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PhotoDetailEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * iso;
@property (nonatomic, retain) NSString * brand;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSNumber * focus;
@property (nonatomic, retain) NSString * aperture;
@property (nonatomic, retain) NSString * speed;
@property (nonatomic, retain) NSString * compensation;
@property (nonatomic, retain) NSNumber * shot_time;
@property (nonatomic, retain) NSString * camera;

@end
