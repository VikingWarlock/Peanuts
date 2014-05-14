//
//  BlurTableViewCell_mark1.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/14/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "BlurTableViewCell_mark1.h"
#import <UIImage+BlurAndDarken.h>

@interface BlurTableViewCell_mark1()

@end


@implementation BlurTableViewCell_mark1
{
    UIPanGestureRecognizer *gesture;
    UIView *Slider;
    UIImageView *imageInSlider;
    Cell_Init_Direction init_dir;
    
    UIImage *bluredImage;
    
    CGPoint startingPoint;
    CGPoint originPoint;
    CGPoint donePoint;
    BOOL gestureEnable;
}


-(void)SetupWithBackImage:(UIImage *)bkImage AtIndexpath:(NSIndexPath *)indexpath AndInitPosition:(Cell_Init_Direction)position AndDelegate:(id<Delegate_BlurCellSlide>)delegate
{
    
    self.indexpath=indexpath;
    self.BKImage=[bkImage copy];
    [self setupLayout];
    
    
    self.Delegate_Blur=delegate;
    
    Slider=[[UIView alloc]init];
    
    imageInSlider=[[UIImageView alloc]initWithImage:bluredImage];
    Slider.clipsToBounds=YES;
    [self addSubview:Slider];
    [Slider addSubview:imageInSlider];

    [Slider setBackgroundColor:[UIColor lightGrayColor]];
    
    gestureEnable=YES;
    
    
    switch (position) {
        case Cell_Init_Direction_At_Left:
        {
            Slider.frame=CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
           // [Slider setImage:[self getSubImage:CGRectMake(Slider.frame.origin.x, 0, self.frame.size.height, self.frame.size.height)]];
            
            originPoint=CGPointMake(0, 0);
            donePoint=CGPointMake(self.frame.size.width-self.frame.size.height, 0);
        }
            break;
            
        default:
        {
            Slider.frame=CGRectMake(self.frame.size.width-self.frame.size.height, 0, self.frame.size.height, self.frame.size.height);
       //     [Slider setImage:[self getSubImage:CGRectMake(Slider.frame.origin.x, 0, self.frame.size.height, self.frame.size.height)]];
            
            originPoint=CGPointMake(self.frame.size.width-self.frame.size.height, 0);
            donePoint=CGPointMake(0, 0);
        }
            break;
    }
    
 //   CGRect frame=Slider.frame;
    [imageInSlider sizeToFit];
    imageInSlider.clipsToBounds=YES;
    [imageInSlider setFrame:CGRectMake(-Slider.frame.origin.x, 0, self.frame.size.width, self.frame.size.height)];
    
    
    gesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(GestureHandle:)];
    gesture.delegate=self;
    [Slider addGestureRecognizer:gesture];
    [Slider setUserInteractionEnabled:YES];
    
    [self sliderConfig];
    
    
    
}


/*

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
        //    [Slider setImage:[self getSubImage:CGRectMake(Slider.frame.origin.x, 0, self.frame.size.height, self.frame.size.height)]];
            originPoint=CGPointMake(0, 0);
            donePoint=CGPointMake(self.frame.size.width-self.frame.size.height, 0);
        }
            break;
            
        default:
        {
            Slider.frame=CGRectMake(self.frame.size.width-self.frame.size.height, 0, self.frame.size.height, self.frame.size.height);
    //        [Slider setImage:[self getSubImage:CGRectMake(Slider.frame.origin.x, 0, self.frame.size.height, self.frame.size.height)]];
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

*/
 
-(void)setupLayout
{
    UIImageView *imgView=[[UIImageView alloc]initWithImage:self.BKImage];
    [self addSubview:imgView];
    imgView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    bluredImage=[self.BKImage darkened:0.5f andBlurredImage:18.f];
    
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
                                
                if ((Slider.frame.origin.x>=0)&&(Slider.frame.origin.x+self.frame.size.height<=self.frame.size.width)) {
                    
                    CGRect frame=Slider.frame;
                    frame.origin.x=originPoint.x;
                    frame.origin.y=originPoint.y;
                    frame.origin.x+=X_offset;
                    Slider.frame=frame;
                    imageInSlider.frame=CGRectMake(-Slider.frame.origin.x, 0, imageInSlider.frame.size.width, imageInSlider.frame.size.height);
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
                    Slider.frame=CGRectMake(donePoint.x, donePoint.y, self.frame.size.height, Slider.frame.size.height);
                    
                    imageInSlider.frame=CGRectMake(-donePoint.x, 0, self.frame.size.width, self.frame.size.height);

        //            [Slider setImage:[self getSubImage:CGRectMake(Slider.frame.origin.x, 0, self.frame.size.height, self.frame.size.height)]];
                } completion:^(BOOL finished) {
                    if ([self.Delegate_Blur respondsToSelector:@selector(slideHaveBeenDoneAtIndexPath:)]) {
                        
                        [self.Delegate_Blur slideHaveBeenDoneAtIndexPath:self.indexpath];
                    }
                    
                }];
                
                
            }else
            {
                //没有达到触发距离
                [UIView animateWithDuration:0.3f animations:^{
                    Slider.frame=CGRectMake(originPoint.x, originPoint.y, self.frame.size.height, Slider.frame.size.height);
                    imageInSlider.frame=CGRectMake(-originPoint.x, 0, self.frame.size.width, self.frame.size.height);
               
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
