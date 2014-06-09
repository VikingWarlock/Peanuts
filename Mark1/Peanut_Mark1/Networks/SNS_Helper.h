//
//  SNS_Helper.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/16/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNS_Helper : NSObject


-(void)sendLike:(id)PhotoSeriesID Like:(BOOL)like;

-(void)sendCommentTo:(id)UserID WithMessage:(NSString*)comment InWhichPhoto:(id)PhotoSeriesID;

-(void)sendForwardAbout:(id)PhotoSeriesID withMessage:(NSString*)message;




@end
