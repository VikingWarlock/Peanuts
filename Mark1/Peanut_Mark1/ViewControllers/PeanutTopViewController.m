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
#import "ActivityDetailViewController.h"
#import "MustReaddetialViewController.h"

#import "SelfUser_ViewController.h"

#import <UIImageView+WebCache.h>
#import "StaticDataManager.h"

#import "Peanut_PhotoBroswer.h"


@interface PeanutTopViewController ()<UITableViewDataSource,UITableViewDelegate,Delegate_BlurCellSlide>
{
    UITableView *tableview;
    CGRect screen;
    UIColor *backGroundImageColor;
    NSIndexPath *havebeenSlide;
    
    NSMutableDictionary *downloadedImage;
    
    UIImageView *HeadimageView;
    NSArray *IndexList;
    
    SDImageCache *ImageCache;
    
}


@end

@implementation PeanutTopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        ImageCache=[[SDImageCache alloc] initWithNamespace:@"HomePageImageCache"];
    }
    return self;
}


-(void)updateHomePageImage
{
    
    NSDictionary *array=[[StaticDataManager sharedObject]FetchHomePage];
    [self AddDownloadTask:[array objectForKey:@"cover"] AndMark:@"cover"];
    [self AddDownloadTask:[array objectForKey:@"square"] AndMark:@"square"];
    [self AddDownloadTask:[array objectForKey:@"activity"] AndMark:@"activity"];
    [self AddDownloadTask:[array objectForKey:@"daily"] AndMark:@"daily"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%f\n\n\n\n",self.view.frame.origin.y);
    havebeenSlide=nil;

    IndexList=@[@"square",@"activity",@"daily"];
    downloadedImage =[[NSMutableDictionary alloc]init];
    
    
    [self prepareDownloadedImageMark:@"cover"];
    [self prepareDownloadedImageMark:@"square"];
    [self prepareDownloadedImageMark:@"activity"];
    [self prepareDownloadedImageMark:@"daily"];
    
    
    
    
    screen=[UIScreen mainScreen].bounds;
    
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, -64, screen.size.width, screen.size.height+64) style:UITableViewStylePlain];
    
    tableview.scrollEnabled=NO;
    tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
  //  [tableview registerClass:[BlurAndSlide_TableViewCell class] forCellReuseIdentifier:@"SliderCell"];
    
    [tableview registerClass:[BlurTableViewCell_mark1 class] forCellReuseIdentifier:@"mark1Cell"];
    
    
    tableview.delegate=self;
    tableview.dataSource=self;
    
    [self.view addSubview:tableview];
    
    
    if ([[downloadedImage allKeys]containsObject:@"cover"]) {
        [self addTableviewHeadView:[downloadedImage objectForKey:@"cover"]];
        [self.NavigationController.navigationBar setTintColor:[UIColor whiteColor]];

    }else
    {
        [self addTableviewHeadView:[UIImage imageNamed:@"placeholder.png"]];
        [self.NavigationController.navigationBar setTintColor:[UIColor blackColor]];
    }
    
    
    
    [self.view setNeedsDisplay];
    
    
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

    

    backGroundImageColor=[[[self.view getClipView:CGRectMake(0, 0, 320, 40)] captureView]averageColor];
    
    
    [self.NavigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: backGroundImageColor==nil?[UIColor whiteColor]:[backGroundImageColor invertedColor]}];
    
    
    UIBarButtonItem *userButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(LeftButton)];
    
    
    UIBarButtonItem *searchButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:nil];

    
    [[self navigationItem]setLeftBarButtonItem:userButton];
    [[self navigationItem]setRightBarButtonItem:searchButton];
    
    
    

}

-(void)LeftButton
{
    SelfUser_ViewController *vc=[[SelfUser_ViewController alloc]init];
    [vc setBackgroundImage:[self.view captureView] andBlurEnable:YES];
    [self.NavigationController pushViewController:vc animated:YES];
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


-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateHomePageImage) name:@"Home Page Hase Been Update" object:nil];
    
    if (self.NavigationController.navigationBarHidden) {
        [self reset_NavigationBar];
    }else
    {
    [self reset_NavigationBar];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Home Page Hase Been Update" object:nil];
    
    [super viewWillDisappear:animated];
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
    BlurTableViewCell_mark1 *cell=[tableview dequeueReusableCellWithIdentifier:@"mark1Cell" forIndexPath:indexPath];
    
    NSString *name=[IndexList objectAtIndex:indexPath.row];
    if ([downloadedImage objectForKey:name]!=nil) {
        [cell SetupWithBackImage:[downloadedImage objectForKey:name] AtIndexpath:indexPath AndInitPosition:(indexPath.row%2) AndDelegate:self];
    }else
    {
    [cell SetupWithBackImage:[UIImage imageNamed:@"placeholder.png"] AtIndexpath:indexPath AndInitPosition:(indexPath.row%2) AndDelegate:self];
    }
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
    NSString*index=[IndexList objectAtIndex:indexpath.row];
    NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:index];
    NSURL *bkUrl=[NSURL URLWithString:[dic objectForKey:@"cover"]];
    
    BaseUIViewController *vc;
    
    switch (indexpath.row) {
        case 0:
        {
            int feed_id=[[dic objectForKey:@"feed_id"]intValue];
            vc=[[imgCollectionViewController alloc]initWithFeedId:feed_id bgImageUrl:bkUrl];
        }
            break;
        case 1:
            vc=[[ActivityDetailViewController alloc]init];
            break;
        case 2:
        {
            NSString *feed_id=[dic objectForKey:@"feed_id"];
            vc=[[MustReaddetialViewController alloc]initWithFeedId:feed_id];
        }
            break;
        default:
            break;
    }
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
    
    if (HeadimageView) {
        [HeadimageView setImage:img];
    }else
    {
    HeadimageView=[[UIImageView alloc]initWithImage:img];
    [HeadimageView setFrame:CGRectMake(0, 0, screen.size.width, (screen.size.height)*0.618f)];
        tableview.tableHeaderView=HeadimageView;
    }
}


#pragma ImageDownloader

-(void)AddDownloadTask:(NSDictionary*)dic AndMark:(NSString*)mark
{

    SDWebImageManager *manager=[SDWebImageManager sharedManager];
    if ([mark isEqualToString:@"cover"]) {
        
    }else
    {
        [[NSUserDefaults standardUserDefaults]setObject:dic forKey:mark];
    }
    
    [manager downloadWithURL:[NSURL URLWithString:[dic objectForKey: @"cover"]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        nil;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
        [downloadedImage setObject:image forKey:mark];
        [ImageCache storeImage:image forKey:mark toDisk:YES];
        if ([mark isEqualToString:@"cover"]) {
            [self addTableviewHeadView:image];
            [self.NavigationController.navigationBar setTintColor:[UIColor whiteColor]];
        }else
        [tableview reloadData];
        //TODO 这个地方使用缓存的图片，还是会调用多次reloadData
    }];

}

-(void)prepareDownloadedImageMark:(NSString*)mark
{
        UIImage*image=[ImageCache imageFromDiskCacheForKey:mark];
    if (image!=nil) {
        [downloadedImage setObject:image forKey:mark];
    }
}


@end
