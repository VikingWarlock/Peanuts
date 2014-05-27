//
//  VKLiveBlur.m
//  test demo
//
//  Created by viking warlock on 5/8/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "VKLiveBlur.h"
#import <UIImage+BlurAndDarken.h>
#import "UIImage+extra.h"



@interface VKLiveBlur()<UIGestureRecognizerDelegate>
{
    UIImage *BackImage;
    UIPanGestureRecognizer *gesture;
    UIImageView *view;
    UIView *superView;
}
@end

@implementation VKLiveBlur
/*
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
*/

-(id)initWithBackView:(UIImage *)backgroundImage AndsuperView:(UIView *)v
{
    if(self=[super init]){
        
//    BackImage=[[backgroundImage scaleToSize:CGSizeMake(v.frame.size.width, v.frame.size.height)] darkened:0.5f andBlurredImage:20.f];
        
    BackImage=[backgroundImage  darkened:0.5f andBlurredImage:20.f];
     //   UIImageWriteToSavedPhotosAlbum(BackImage, self, nil, nil);
        
        

    view=[[UIImageView alloc]init];
    [self addSubview:view];
    superView=v;
    }

    return self;
}

-(void)setvisiableFrame:(CGRect)frame
{

    [self setFrame:frame];
    [view setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [view setImage:[self getSubImage:frame]];
 /*
    gesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(PangestureHandle:)];
    gesture.delegate=self;
    [self addGestureRecognizer:gesture];
   */
    
}


-(void)moveVisiableFrame:(CGRect)frame
{
    [view setImage: [self getSubImage:frame]];

    
}



-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}


-(void)PangestureHandle:(UIPanGestureRecognizer*)sender
{
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            
        }
            break;
         
        case UIGestureRecognizerStateChanged:
        {
            CGPoint trans=[sender translationInView:superView];
            CGRect frame=self.frame;
            frame.origin.x+=trans.x;
            frame.origin.y+=trans.y;
            
            
            
            self.frame=frame;
            
            CGRect visible=[superView convertRect:self.frame toView:superView];
            [view setImage:[self getSubImage:visible]];
    
            
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            
        }
            break;
            
        default:
            break;
    }

}


-(UIImage*)getSubImage:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(BackImage.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
