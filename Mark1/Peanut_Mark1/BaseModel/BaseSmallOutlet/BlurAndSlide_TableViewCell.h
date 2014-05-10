//
//  BlurAndSlide_TableViewCell.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, Cell_Init_Direction) {
    Cell_Init_Direction_At_Right=0,
    Cell_Init_Direction_At_Left
};


@protocol Delegate_BlurCellSlide <NSObject>

@optional
-(void)slideHaveBeenDoneAtIndexPath:(NSIndexPath*)indexpath;
//滑动完成后做的事情

@end

@interface BlurAndSlide_TableViewCell : UITableViewCell

@property(nonatomic,weak)id<Delegate_BlurCellSlide> Delegate_Blur;
@property(nonatomic,strong)NSIndexPath* indexpath;
@property(nonatomic,strong)UIImage *BKImage;




-(id)initWithBackImage:(UIImage*)bkImage AtIndexpath:(NSIndexPath*)indexpath AndInitPosition:(Cell_Init_Direction)position AndDelegate:(id<Delegate_BlurCellSlide>)delegate;

-(void)SetupWithBackImage:(UIImage*)bkImage AtIndexpath:(NSIndexPath*)indexpath AndInitPosition:(Cell_Init_Direction)position AndDelegate:(id<Delegate_BlurCellSlide>)delegate;



@end
