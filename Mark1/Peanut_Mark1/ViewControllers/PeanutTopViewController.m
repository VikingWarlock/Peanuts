//
//  PeanutTopViewController.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "PeanutTopViewController.h"
#import "PublicLib.h"
#import "BlurAndSlide_TableViewCell.h"

#import "SquareViewController.h"
#import "MustReadViewController.h"
#import "ActivityViewController.h"


@interface PeanutTopViewController ()<UITableViewDataSource,UITableViewDelegate,Delegate_BlurCellSlide>
{
    UITableView *tableview;
    CGRect screen;
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
    
    self.NavigationController.navigationBarHidden=YES;
    
    screen=[UIScreen mainScreen].bounds;
    
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, -20, screen.size.width, screen.size.height+20) style:UITableViewStylePlain];
    
    tableview.scrollEnabled=NO;
    tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [tableview registerClass:[BlurAndSlide_TableViewCell class] forCellReuseIdentifier:@"SliderCell"];
    
    tableview.delegate=self;
    tableview.dataSource=self;
    
    [self.view addSubview:tableview];
    [self addTableviewHeadView:[UIImage imageNamed:@"pic.jpg"]];
    
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
    BlurAndSlide_TableViewCell *cell=[tableview dequeueReusableCellWithIdentifier:@"SliderCell" forIndexPath:indexPath];
    
    [cell SetupWithBackImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",indexPath.row+1]] AtIndexpath:indexPath AndInitPosition:(indexPath.row%2) AndDelegate:self];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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

-(void)addTableviewHeadView:(UIImage*)img
{
    UIImageView *imageView=[[UIImageView alloc]initWithImage:img];
    [imageView setFrame:CGRectMake(0, 0, screen.size.width, (screen.size.height)*0.618f)];
    tableview.tableHeaderView=imageView;

}

@end
