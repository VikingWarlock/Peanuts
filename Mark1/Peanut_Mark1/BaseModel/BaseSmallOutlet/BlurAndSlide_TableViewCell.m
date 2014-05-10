//
//  BlurAndSlide_TableViewCell.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "BlurAndSlide_TableViewCell.h"
#import <UIImage+BlurAndDarken.h>
#import "UIImage+extra.h"

#define SliderWidth 60.f
//小划块宽度

@interface BlurAndSlide_TableViewCell()<UIGestureRecognizerDelegate>
{

    UIPanGestureRecognizer *gesture;
    UIView *Slider;
    Cell_Init_Direction init_dir;
    
    CGPoint startingPoint;
    CGPoint originPoint;
    CGPoint donePoint;
    BOOL gestureEnable;

    
}
@end


@implementation BlurAndSlide_TableViewCell
/*
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
*/


-(id)initWithBackImage:(UIImage *)bkImage AtIndexpath:(NSIndexPath *)indexpath AndInitPosition:(Cell_Init_Direction)position AndDelegate:(id<Delegate_BlurCellSlide>)delegate
{
    self=[super init];
    
    self.indexpath=indexpath;
    self.image=[bkImage copy];
    self.Delegate_Blur=delegate;
    
    Slider=[[UIView alloc]init];
    [self addSubview:Slider];
    
    gestureEnable=YES;
    
    
    switch (position) {
        case Cell_Init_Direction_At_Left:
        {
            Slider.frame=CGRectMake(0, 0, SliderWidth, self.frame.size.height);
            originPoint=CGPointMake(0, 0);
            donePoint=CGPointMake(self.frame.size.width-SliderWidth, 0);
        }
            break;
            
        default:
        {
            Slider.frame=CGRectMake(self.frame.size.width-SliderWidth, 0, SliderWidth, self.frame.size.height);
            originPoint=CGPointMake(self.frame.size.width-SliderWidth, 0);
            donePoint=originPoint=CGPointMake(0, 0);
        }
            break;
    }
    
    gesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(GestureHandle:)];
    gesture.delegate=self;
    [Slider addGestureRecognizer:gesture];
    
    
    
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)GestureHandle:(UIPanGestureRecognizer*)sender
{
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
                startingPoint=[sender locationInView:self];
        }
            break;
        case  UIGestureRecognizerStateChanged:
        {
            CGPoint trans=[sender translationInView:self];
            
            if ((abs(trans.x)>abs(trans.y)*3)) {
                
                CGFloat X_offset=[sender locationInView:self].x - startingPoint.x;
            
                if (Slider.frame.origin.x+X_offset>0&&Slider.frame.origin.x+X_offset+SliderWidth<=self.frame.size.width) {
                    Slider.frame=CGRectOffset(Slider.frame, X_offset, 0);
                }
            }
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            startingPoint=CGPointZero;
            BOOL trigger=abs(Slider.frame.origin.x-originPoint.x)/(self.frame.size.width*1.f)>0.4f;
            if (trigger) {
                [UIView animateWithDuration:0.3f animations:^{
                    Slider.frame=CGRectMake(donePoint.x, donePoint.y, SliderWidth, Slider.frame.size.height);

                } completion:^(BOOL finished) {
                    if ([self.Delegate_Blur respondsToSelector:@selector(slideHaveBeenDoneAtIndexPath:)]) {
                        [self.Delegate_Blur slideHaveBeenDoneAtIndexPath:self.indexpath];
                    }
                    
                }];
                
                
            }else
            {
            //没有达到触发距离
                [UIView animateWithDuration:0.3f animations:^{
                    Slider.frame=CGRectMake(originPoint.x, originPoint.y, SliderWidth, Slider.frame.size.height);
                    
                } completion:^(BOOL finished) {
                    
                    
                }];
                
                
            
            }
            
        }
            break;
        // blow equal state ended;
        default:
            break;
    }
    
}

-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint trans=[gestureRecognizer translationInView:self];
    return gestureEnable &&( abs(trans.x)>abs(trans.y)*3 );
    

}


@end
