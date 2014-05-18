//
//  PeanutTopViewController.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "PeanutTopViewController.h"
#import "PublicLib.h"
//#import "BlurAndSlide_TableViewCell.h"
#import "BlurTableViewCell_mark1.h"

#import "SquareViewController.h"
#import "MustReadViewController.h"
#import "ActivityViewController.h"
#import "imgCollectionViewController.h"


@interface PeanutTopViewController ()<UITableViewDataSource,UITableViewDelegate,Delegate_BlurCellSlide>
{
    UITableView *tableview;
    CGRect screen;
    UIColor *backGroundImageColor;
    NSIndexPath *havebeenSlide;
    
}


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



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%f\n\n\n\n",self.view.frame.origin.y);
    havebeenSlide=nil;
    
    
    screen=[UIScreen mainScreen].bounds;
    
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, -62, screen.size.width, screen.size.height+62) style:UITableViewStylePlain];
    
    tableview.scrollEnabled=NO;
    tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
  //  [tableview registerClass:[BlurAndSlide_TableViewCell class] forCellReuseIdentifier:@"SliderCell"];
    
    [tableview registerClass:[BlurTableViewCell_mark1 class] forCellReuseIdentifier:@"mark1Cell"];
    
    
    tableview.delegate=self;
    tableview.dataSource=self;
    
    [self.view addSubview:tableview];
    [self addTableviewHeadView:[UIImage imageNamed:@"pic.jpg"]];
    
    [self.view setNeedsDisplay];
    
    [self.NavigationController SNS_appear];
    
     /*
    UIImageWriteToSavedPhotosAlbum([[self.view getClipView:CGRectMake(0, 0, 320, 100)]captureView ], self, nil, nil);
    
    backGroundImageColor=[[[self.view getClipView:CGRectMake(0, 0, 320, 40)] captureView]averageColor];
    */
    //[self.NavigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: backGroundImageColor}];
    
//    [self reset_NavigationBar];

    
    // Do any additional setup after loading the view.
}

-(void)reset_NavigationBar
{
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    [[self.NavigationController navigationBar]setBarTintColor:[UIColor clearColor]];
    [[self.NavigationController navigationBar]setTranslucent:YES];
    [self.NavigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.NavigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    [self.NavigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    self.navigationItem.title=@"花生米";
    [self.NavigationController.navigationBar setTintColor:[UIColor whiteColor]];

    
 //   UIImageWriteToSavedPhotosAlbum([[self.Peanut_backgroundView getClipView:CGRectMake(0, 0, 320, 100)]captureView ], self, nil, nil);
    
    backGroundImageColor=[[[self.view getClipView:CGRectMake(0, 0, 320, 40)] captureView]averageColor];
    
    
    [self.NavigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: backGroundImageColor==nil?[UIColor whiteColor]:[backGroundImageColor invertedColor]}];
    
    
    UIBarButtonItem *userButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:nil];
    
    
    UIBarButtonItem *searchButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:nil];

    
    [[self navigationItem]setLeftBarButtonItem:userButton];
    [[self navigationItem]setRightBarButtonItem:searchButton];
    

}

-(void)setNavigationBarForOther
{
    [[self.NavigationController navigationBar]setTranslucent:NO];
    [[self.NavigationController navigationBar]setBarTintColor:[UIColor redColor]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated
{
 //   self.NavigationController.navigationBarHidden=YES;
    
    [super viewDidAppear:animated];
    [self reset_NavigationBar];
}

-(void)viewDidDisappear:(BOOL)animated
{
//    self.NavigationController.navigationBarHidden=NO;
    [super viewDidDisappear:animated];
    [self setNavigationBarForOther];
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



#pragma Tableview Datasource && delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (screen.size.height)*(1-0.618)/3.0f;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //BlurAndSlide_TableViewCell *cell=[tableview dequeueReusableCellWithIdentifier:@"SliderCell" forIndexPath:indexPath];
    BlurTableViewCell_mark1 *cell=[tableview dequeueReusableCellWithIdentifier:@"mark1Cell" forIndexPath:indexPath];
    
    [cell SetupWithBackImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",indexPath.row+1]] AtIndexpath:indexPath AndInitPosition:(indexPath.row%2) AndDelegate:self];
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (havebeenSlide!=nil) {
        return;
    }
    
    BlurTableViewCell_mark1 *cell=(BlurTableViewCell_mark1*)[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:NO];
    switch (indexPath.row) {
        case 0:
        {
            SquareViewController *vc=[[SquareViewController alloc]init];
//            [self.NavigationController PushVC:vc];
            [self.NavigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 1:
        {
            ActivityViewController *vc=[[ActivityViewController alloc]init];
            [self.NavigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 2:
        {
            MustReadViewController *vc=[[MustReadViewController alloc]init];
            [self.NavigationController pushViewController:vc animated:YES];
        
        }
            break;
            
        default:
            break;
    }
    

}


-(void)slideHaveBeenDoneAtIndexPath:(NSIndexPath *)indexpath
{
    BlurTableViewCell_mark1 *cell=(BlurTableViewCell_mark1*)[tableview cellForRowAtIndexPath:indexpath];
    imgCollectionViewController *vc=[[imgCollectionViewController alloc]init];
    [cell backToOriginWithAnimate:NO];
    havebeenSlide=nil;
    [self.NavigationController pushViewController:vc animated:YES];
}


-(BOOL)SlideCouldBegin:(NSIndexPath *)indexpath
{
    if (havebeenSlide==nil) {
        return YES;
    }else
    {
        if (havebeenSlide==indexpath) {
            return YES;
        }
    }
    
    return NO;
    
}

-(void)ThisCellHaveBeenSlide:(NSIndexPath *)indexpath
{

    havebeenSlide=indexpath;
    
}

-(void)ThisCellHaveBeenReleased:(NSIndexPath *)indexpath
{
    if (havebeenSlide==indexpath) {
        havebeenSlide=nil;
    }
}

-(void)addTableviewHeadView:(UIImage*)img
{
    UIImageView *imageView=[[UIImageView alloc]initWithImage:img];
    [imageView setFrame:CGRectMake(0, 0, screen.size.width, (screen.size.height)*0.618f)];
    tableview.tableHeaderView=imageView;

}

@end
