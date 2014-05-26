//
//  PhotoInfoEntity.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/22/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PhotoInfoEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * comment_count;
@property (nonatomic, retain) NSString * descriptions;
@property (nonatomic, retain) NSNumber * dig_count;
@property (nonatomic, retain) NSString * feed_id;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSNumber * is_report;
@property (nonatomic, retain) NSNumber * publish_time;
@property (nonatomic, retain) NSNumber * recommend_count;
@property (nonatomic, retain) NSString * recomment_content;
@property (nonatomic, retain) NSNumber * repost_count;
@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) NSString * group_feed_id;
@property (nonatomic, retain) NSString * local_path;
@property (nonatomic, retain) NSManagedObject *details;

@end
