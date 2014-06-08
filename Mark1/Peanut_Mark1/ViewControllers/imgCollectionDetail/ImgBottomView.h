//
//  ImgBottomView.h
//  Peanut_Mark1
//
//  Created by 马君 on 14-5-25.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommentViewController;
@class ShareViewController;

@protocol Delegate_imgBottomView <NSObject>

-(void)bottomCommentBtnClick;
-(void)bottomShareBtnClick;

@end

@interface ImgBottomView : UIView

@property (nonatomic,strong)UIButton * praiseBtn;
@property (nonatomic,strong)UIButton * commentBtn;
@property (nonatomic,strong)UIButton * shareBtn;
@property (nonatomic,strong)ShareViewController * shareVC;
@property (nonatomic,strong)CommentViewController * commentVC;
@property (nonatomic,assign)id<Delegate_imgBottomView>delegate;

- (id)initWithGroupFeedId:(NSInteger)feedId;

@end
