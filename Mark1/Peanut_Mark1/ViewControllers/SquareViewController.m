 //
//  SquareViewController.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "SquareViewController.h"
#import "imgCollectionViewController.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "CoreData-Helper.h"
#import "PhotoSeriesEntity.h"

@interface SquareControl : UIControl
@property int feedId;
@end

@implementation SquareControl

-(id)initWithFrame:(CGRect)frame withFeedId:(int)feedId{
    self = [super initWithFrame:frame];
    if (self) {
        self.feedId = feedId;
    }
    return self;
}

@end


@interface SquareViewController (){
    int currentPage;
    NSArray * data;
}

@property (nonatomic,strong) UITableView * tableView;

@end

@implementation SquareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"广场";
    currentPage = 1;
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
//    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentifier"];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    
    __weak SquareViewController *weakSelf =self;
    [_tableView addHeaderWithCallback:^{
        [weakSelf pullDownRefreshing];
    }];
    
    [_tableView addFooterWithCallback:^{
        [weakSelf pullUpRefreshing];
    }];
    // Do any additional setup after loading the view.
    [self.tableView headerBeginRefreshing];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.allowsSelection = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(void)pullDownRefreshing{
    currentPage = 1;
    [NetworkManager POST:@"http://112.124.10.151:82/index.php?app=mobile&mod=Square&act=photo_group_list" parameters:@{@"page":[NSString stringWithFormat:@"%d",currentPage],@"count":@"20"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject valueForKey:@"info"] isEqualToString:@"success"])
        {
            NSArray * arr = [responseObject valueForKey:@"data"];
            for (NSDictionary *dic in arr) {
                [CoreData_Helper addPhotoSeriesEntity:dic];
            }
            data = [[NSArray alloc]initWithArray:[responseObject valueForKey:@"data"]];
            [_tableView reloadData];
            [_tableView headerEndRefreshing];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)pullUpRefreshing{
    [NetworkManager POST:@"http://112.124.10.151:82/index.php?app=mobile&mod=Square&act=photo_group_list" parameters:@{@"page":[NSString stringWithFormat:@"%d",++currentPage],@"count":@"20"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject valueForKey:@"info"] isEqualToString:@"success"])
        {
            NSArray * arr = [responseObject valueForKey:@"data"];
            for (NSDictionary *dic in arr) {
                [CoreData_Helper addPhotoSeriesEntity:dic];
            }
            NSMutableArray * temp = [[NSMutableArray alloc]initWithArray:data];
            [temp addObjectsFromArray:[responseObject valueForKey:@"data"]];
            data = temp;
            [_tableView reloadData];
            [_tableView footerEndRefreshing];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [_tableView footerEndRefreshing];
    }];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, (self.view.frame.size.width - 15)/2, (self.view.frame.size.width - 15)/2)];
    CGRect rect = imageView1.frame;
    rect.origin.x += rect.size.width + 5;
    UIImageView * imageView2 = [[UIImageView alloc] initWithFrame:rect];
    [imageView1 setBackgroundColor:[UIColor whiteColor]];
    [imageView2 setBackgroundColor:[UIColor whiteColor]];
    imageView1.clipsToBounds = YES;
    imageView2.clipsToBounds = YES;
    imageView1.contentMode = UIViewContentModeScaleAspectFill;
    imageView2.contentMode = UIViewContentModeScaleAspectFill;
    NSDictionary * dic1 = data[(indexPath.row+1)*2-2];
    NSDictionary * dic2 = data[(indexPath.row+1)*2-1];
    [imageView1 setImageWithURL:dic1[@"cover"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [imageView2 setImageWithURL:dic2[@"cover"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];


//    PhotoSeriesEntity * entity1 = [CoreData_Helper GetPhotoSeriesEntity:[dic1 valueForKey:@"feed_id"]];
//    PhotoSeriesEntity * entity2 = [CoreData_Helper GetPhotoSeriesEntity:[dic2 valueForKey:@"feed_id"]];
//    NSLog(@"%@",entity1.cover_url);

    [cell.contentView addSubview:imageView1];
    [cell.contentView addSubview:imageView2];
    
    SquareControl * control1 = [[SquareControl alloc]initWithFrame:imageView1.frame withFeedId:[dic1[@"feed_id"] intValue] ];
    [control1 addTarget:self action:@selector(imageTapped:) forControlEvents:UIControlEventTouchUpInside];
    SquareControl * control2 = [[SquareControl alloc]initWithFrame:imageView2.frame withFeedId:[dic2[@"feed_id"] intValue] ];
    [control2 addTarget:self action:@selector(imageTapped:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:control1];
    [cell.contentView addSubview:control2];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [data count]/2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.frame.size.width/2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)imageTapped:(SquareControl *)sender{
    [self.navigationController pushViewController:[[imgCollectionViewController alloc] initWithFeedId:sender.feedId] animated:YES];
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
