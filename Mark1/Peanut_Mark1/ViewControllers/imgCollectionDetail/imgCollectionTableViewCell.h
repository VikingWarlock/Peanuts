//
//  imgCollectionTableViewCell.h
//  Peanut_Mark1
//
//  Created by 马君 on 14-5-13.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Delegate_imgCell <NSObject>

-(void)praiseBtnClickAtCell:(UITableViewCell*)cell;
-(void)commentBtnClickAtIndexPath:(NSIndexPath *)indexPath;
-(void)shareBtnClickAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface imgCollectionTableViewCell : UITableViewCell{
    NSInteger praiseCount;
    NSInteger commentCount;
    NSInteger shareCount;
}

@property (nonatomic,strong) UIImageView * imgView;
@property (nonatomic,strong) UILabel * titleLabel;
//@property (nonatomic,strong) UIButton * detailBtn;
@property (nonatomic,strong) UIButton * praiseBtn;
@property (nonatomic,strong) UIButton * commentBtn;
@property (nonatomic,strong) UIButton * shareBtn;
@property (nonatomic,strong) NSIndexPath *currentIndexPath;
@property (nonatomic,assign)id<Delegate_imgCell>delegate;



-(void)setConstraintsWithBool:(BOOL)isFirstRow;
-(void)removeConstraintWithBool:(BOOL)isFirstRow;;
-(void)setCommentBtnTitle:(NSInteger)count;
-(void)setPraiseBtnTitle:(NSInteger)count;
-(void)setShareBtnTitle:(NSInteger)count;


//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier atIndexPath:(NSIndexPath *)indexPath;

@end
