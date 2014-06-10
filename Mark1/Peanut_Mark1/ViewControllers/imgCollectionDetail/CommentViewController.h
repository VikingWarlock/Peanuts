//
//  CommentViewController.h
//  Peanut_Mark1
//
//  Created by 马君 on 14-5-13.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"
#import "CommentTableViewCell.h"
#import "PublishCommentTableViewCell.h"
#import "ImgBottomView.h"


@protocol Delegate_commentVC <NSObject>

-(void)DidPublishOneComment;
//-(void)ShouldChangeToShareVC;
@end

@interface CommentViewController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate,Delegate_CommentCell,Delegate_publishCommentCell,Delegate_imgBottomView>

@property(nonatomic,assign) id<Delegate_commentVC>delegate;

- (id)initWithFeedId:(NSInteger)feedId;
//- (id)initWithGroupFeedId:(NSInteger)feedId;

@end
