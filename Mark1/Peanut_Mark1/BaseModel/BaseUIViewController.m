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

    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;

    NetworkManager=[AFHTTPRequestOperationManager manager];
    
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
    bkImageView.clipsToBounds = YES;
    bkImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    //将原来的fram改为用自动布局，否则在某些情况下会出现背景不能铺满整个屏幕 @张众
    [self.view addSubview:bkImageView];
    [bkImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bkImageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bkImageView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[bkImageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bkImageView)]];
    
    if (enable) {
        self.bkImage=[bkimage darkened:0.5f andBlurredImage:16.f];
    }else
        self.bkImage=bkimage;
    
    [bkImageView setImage:self.bkImage];
    [self.view sendSubviewToBack:bkImageView];
  
}

-(UIImageView*)Peanut_backgroundView
{

    return bkImageView;
}
/*
-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationPortrait;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}
 
 */
 
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
