//
//  ActivityEntity.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/22/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ActivityEntity : NSManagedObject

@property (nonatomic, retain) NSString * feed_id;
@property (nonatomic, retain) NSString * cover_url;
@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) NSNumber * publish_time;
@property (nonatomic, retain) NSNumber * comment_count;
@property (nonatomic, retain) NSNumber * dig_count;
@property (nonatomic, retain) NSNumber * repost_count;
@property (nonatomic, retain) NSNumber * is_repost;
@property (nonatomic, retain) NSNumber * begin_time;
@property (nonatomic, retain) NSNumber * end_time;
@property (nonatomic, retain) NSNumber * fee_limit;
@property (nonatomic, retain) NSNumber * member_audit;
@property (nonatomic, retain) NSNumber * credit_limit;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * descriptions;
@property (nonatomic, retain) NSString * avatar_original_url;
@property (nonatomic, retain) NSString * avatar_big_url;
@property (nonatomic, retain) NSString * avatar_small_url;
@property (nonatomic, retain) NSString * avatar_tiny_url;
@property (nonatomic, retain) NSString * avatar_middle_url;
@property (nonatomic, retain) NSNumber * personNum_limit;
@property (nonatomic, retain) NSNumber * activityType;
@property (nonatomic, retain) NSNumber * isCurrent;
@property (nonatomic, retain) id image_path_array;

@end
