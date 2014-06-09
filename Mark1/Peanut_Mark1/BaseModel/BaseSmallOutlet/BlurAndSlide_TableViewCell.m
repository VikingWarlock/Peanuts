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


@interface BlurAndSlide_TableViewCell()<UIGestureRecognizerDelegate>
{

    UIPanGestureRecognizer *gesture;
    UIImageView *Slider;
    Cell_Init_Direction init_dir;
    
    UIImage *bluredImage;
    
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
-(void)SetupWithBackImage:(UIImage *)bkImage AtIndexpath:(NSIndexPath *)indexpath AndInitPosition:(Cell_Init_Direction)position AndDelegate:(id<Delegate_BlurCellSlide>)delegate
{

    self.indexpath=indexpath;
    self.BKImage=[bkImage copy];
    [self setupLayout];
    
    
    self.Delegate_Blur=delegate;
    
    Slider=[[UIImageView alloc]init];
    [self addSubview:Slider];
    
    
    gestureEnable=YES;
    
    
    switch (position) {
        case Cell_Init_Direction_At_Left:
        {
            Slider.frame=CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
            [Slider setImage:[self getSubImage:CGRectMake(Slider.frame.origin.x, 0, self.frame.size.height, self.frame.size.height)]];
            originPoint=CGPointMake(0, 0);
            donePoint=CGPointMake(self.frame.size.width-self.frame.size.height, 0);
        }
            break;
            
        default:
        {
            Slider.frame=CGRectMake(self.frame.size.width-self.frame.size.height, 0, self.frame.size.height, self.frame.size.height);
            [Slider setImage:[self getSubImage:CGRectMake(Slider.frame.origin.x, 0, self.frame.size.height, self.frame.size.height)]];
            originPoint=CGPointMake(self.frame.size.width-self.frame.size.height, 0);
            donePoint=CGPointMake(0, 0);
        }
            break;
    }
    
    
    
    gesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(GestureHandle:)];
    gesture.delegate=self;
    [Slider addGestureRecognizer:gesture];
    [Slider setUserInteractionEnabled:YES];
    
    [self sliderConfig];


    
}

-(id)initWithBackImage:(UIImage *)bkImage AtIndexpath:(NSIndexPath *)indexpath AndInitPosition:(Cell_Init_Direction)position AndDelegate:(id<Delegate_BlurCellSlide>)delegate
{
    self=[super init];
    
    self.indexpath=indexpath;
    self.BKImage=[bkImage copy];
    [self setupLayout];
    self.Delegate_Blur=delegate;
    
    
    Slider=[[UIImageView alloc]init];
    [self addSubview:Slider];
    
    gestureEnable=YES;
    
    
    switch (position) {
        case Cell_Init_Direction_At_Left:
        {
            Slider.frame=CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
                [Slider setImage:[self getSubImage:CGRectMake(Slider.frame.origin.x, 0, self.frame.size.height, self.frame.size.height)]];
            originPoint=CGPointMake(0, 0);
            donePoint=CGPointMake(self.frame.size.width-self.frame.size.height, 0);
        }
            break;
            
        default:
        {
            Slider.frame=CGRectMake(self.frame.size.width-self.frame.size.height, 0, self.frame.size.height, self.frame.size.height);
                [Slider setImage:[self getSubImage:CGRectMake(Slider.frame.origin.x, 0, self.frame.size.height, self.frame.size.height)]];
            originPoint=CGPointMake(self.frame.size.width-self.frame.size.height, 0);
            donePoint=CGPointMake(0, 0);
        }
            break;
    }
    
    gesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(GestureHandle:)];
    gesture.delegate=self;
    [Slider addGestureRecognizer:gesture];
    
    [Slider setUserInteractionEnabled:YES];
    [self sliderConfig];
    return self;
}


-(void)setupLayout
{
    UIImageView *imgView=[[UIImageView alloc]initWithImage:self.BKImage];
    [self addSubview:imgView];
    imgView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    bluredImage=[[imgView captureView] darkened:0.5f andBlurredImage:16.f];
/*
    UIImageWriteToSavedPhotosAlbum(bluredImage, self, nil, nil);
    UIImageWriteToSavedPhotosAlbum([bluredImage getSubImage:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)], self, nil, nil);
*/
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
                
          //      NSLog(@"%f",Slider.frame.origin.x);
                
                if ((Slider.frame.origin.x>=0)&&(Slider.frame.origin.x+self.frame.size.height<=self.frame.size.width)) {
                   
                    CGRect frame=Slider.frame;
                    frame.origin.x=originPoint.x;
                    frame.origin.y=originPoint.y;
                    frame.origin.x+=X_offset;
                    Slider.frame=frame;
                    
                    [Slider setImage:[self getSubImage:CGRectMake(Slider.frame.origin.x, 0, self.frame.size.height, self.frame.size.height)]];
              //      [Slider setNeedsDisplay];
                }
            }
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            
        //    UIImageWriteToSavedPhotosAlbum([bluredImage getSubImage:CGRectMake(Slider.frame.origin.x, 0, self.frame.size.height, self.frame.size.height)], self, nil, nil);
        //    UIImageWriteToSavedPhotosAlbum([Slider captureView], self, nil, nil);
            
            startingPoint=CGPointZero;
            BOOL trigger=abs(Slider.frame.origin.x-originPoint.x)/(self.frame.size.width*1.f)>0.4f;
            if (trigger) {
                [UIView animateWithDuration:0.3f animations:^{
                    Slider.frame=CGRectMake(donePoint.x, donePoint.y, self.frame.size.height, Slider.frame.size.height);
                     [Slider setImage:[self getSubImage:CGRectMake(Slider.frame.origin.x, 0, self.frame.size.height, self.frame.size.height)]];
                } completion:^(BOOL finished) {
                    if ([self.Delegate_Blur respondsToSelector:@selector(slideHaveBeenDoneAtIndexPath:)]) {
                        
                        //[Slider setImage:[bluredImage getSubImage:CGRectMake(Slider.frame.origin.x, 0, self.frame.size.height, self.frame.size.height)]];
                        
                        [self.Delegate_Blur slideHaveBeenDoneAtIndexPath:self.indexpath];
                    }
                    
                }];
                
                
            }else
            {
            //没有达到触发距离
                [UIView animateWithDuration:0.3f animations:^{
                    Slider.frame=CGRectMake(originPoint.x, originPoint.y, self.frame.size.height, Slider.frame.size.height);
                     [Slider setImage:[self getSubImage:CGRectMake(Slider.frame.origin.x, 0, self.frame.size.height, self.frame.size.height)]];
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
 //   CGPoint trans=[gestureRecognizer translationInView:self];
    return gestureEnable;
    

}


-(void)sliderConfig
{
    [Slider clipsToBounds];
    Slider.contentMode=UIViewContentModeScaleAspectFill;
}



-(UIImage*)getSubImage:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(bluredImage.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [[UIImage imageWithCGImage:subImageRef]copy];
    UIGraphicsEndImageContext();
    
    return smallImage;
}


@end
