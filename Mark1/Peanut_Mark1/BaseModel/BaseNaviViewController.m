//
//  BaseNaviViewController.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "BaseNaviViewController.h"

@interface BaseNaviViewController ()
{
    NSMutableArray *ScreenShotArray;
    NSMutableArray *DirectionArray;
    
}

@end

@implementation BaseNaviViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init
{
    self=[super init];
    if (self) {
        ScreenShotArray=[[NSMutableArray alloc]init];
        DirectionArray=[[NSMutableArray alloc]init];
    }
    return self;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(void)PushVC:(UIViewController *)vc
{
    
    UIView *copyView=[vc.view copy];
    [self.visibleViewController.view addSubview:copyView];
    [ScreenShotArray addObject:[self.visibleViewController.view captureView]];
    [DirectionArray addObject:@"Left"];
    [copyView setFrame:CGRectOffset(copyView.frame, 320, 0)];
    
    [UIView animateWithDuration:0.3f animations:^{
        [copyView setFrame:self.visibleViewController.view.frame];
    } completion:^(BOOL finished) {
        [copyView removeFromSuperview];
        [self pushViewController:vc animated:NO];
    }];
    
}

-(void)PushVC:(UIViewController *)vc Direction:(NaivPushDir)dir
{
    
    
    [self pushViewController:vc animated:NO];
}

-(void)PopVC
{
    
    UIImage *lastscreenshot=[ScreenShotArray lastObject];
    UIImageView *preView=[[UIImageView alloc]initWithImage:lastscreenshot];
    [self.visibleViewController.view addSubview:preView];
    if ([[DirectionArray lastObject]isEqualToString:@"Left"]) {
        [preView setFrame:CGRectOffset(preView.frame, -320, 0)];
    }else
    {
        [preView setFrame:CGRectOffset(preView.frame, 0, 600)];
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        preView.frame=self.visibleViewController.view.frame;
    } completion:^(BOOL finished) {
        [self popViewControllerAnimated:NO];
        [preView removeFromSuperview];
        [ScreenShotArray delete:[ScreenShotArray lastObject]];
        [DirectionArray delete:[DirectionArray lastObject]];
        
    }];
    
}



-(void)SNS_appear
{
    Peanut_SNSPart *bottom=[[Peanut_SNSPart alloc]initWithType:BottomSMSType_Activity andData:nil AndDelegate:(id<Delegate_SNS>)self.topViewController AndTarget:self.topViewController];
    [self.view addSubview:bottom];
    
}

@end
