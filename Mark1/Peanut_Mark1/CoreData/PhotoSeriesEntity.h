//
//  PhotoSeriesEntity.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/22/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PhotoSeriesEntity : NSManagedObject

@property (nonatomic, retain) NSString * addr;
@property (nonatomic, retain) NSNumber * comment_count;
@property (nonatomic, retain) NSString * cover_url;
@property (nonatomic, retain) NSString * descriptions;
@property (nonatomic, retain) NSNumber * dig_count;
@property (nonatomic, retain) NSString * feed_id;
@property (nonatomic, retain) id images;
@property (nonatomic, retain) NSNumber * is_report;
@property (nonatomic, retain) NSNumber * publish_time;
@property (nonatomic, retain) NSString * recommend_content;
@property (nonatomic, retain) NSNumber * recommend_count;
@property (nonatomic, retain) NSNumber * repost_count;
@property (nonatomic, retain) NSString * topic;
@property (nonatomic, retain) NSString * uid;

@end
