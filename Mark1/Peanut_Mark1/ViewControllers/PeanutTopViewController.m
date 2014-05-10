//
//  PeanutTopViewController.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "PeanutTopViewController.h"

@interface PeanutTopViewController ()

@end

@implementation PeanutTopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)pushTest
{
    PeanutTopViewController *a=[[PeanutTopViewController alloc]init];
    [self.NavigationController pushViewController:a animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:btn];
    [btn setFrame: CGRectMake(70, 70, 100, 100)];
    [btn addTarget:self action:@selector(pushTest) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"hello" forState:UIControlStateNormal];
       
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

@end
