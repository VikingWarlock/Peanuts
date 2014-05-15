//
//  BaseUIViewController.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "BaseUIViewController.h"
#import <UIImage+BlurAndDarken.h>

@interface BaseUIViewController ()
{
    UIImageView *bkImageView;
}
@end

@implementation BaseUIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BaseNaviViewController*)NavigationController
{
    return (BaseNaviViewController*)self.navigationController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}


-(void)setBackgroundImage:(UIImage *)bkimage andBlurEnable:(BOOL)enable
{
    bkImageView=[[UIImageView alloc]init];
    [self.view addSubview:bkImageView];
    [bkImageView setFrame:self.view.frame];
    if (enable) {
        self.bkImage=[bkimage darkened:0.5f andBlurredImage:16.f];
    }else
        self.bkImage=bkimage;
    
    [bkImageView setImage:self.bkImage];
  
}

-(UIImageView*)Peanut_backgroundView
{

    return bkImageView;
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

@end
