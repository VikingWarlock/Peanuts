//
//  SquareViewController.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "SquareViewController.h"
#import "imgCollectionViewController.h"

@interface SquareViewController ()

@property (nonatomic,strong) UICollectionView * collectionView;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"广场";
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.view addSubview:self.collectionView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_collectionView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_collectionView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collectionView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_collectionView)]];
    // Do any additional setup after loading the view.
}


-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 4;
        flowLayout.minimumLineSpacing = 4;
        flowLayout.itemSize = CGSizeMake(153, 153);
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);

        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    
    }
    return _collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 15;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iron.png"]]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    imgCollectionViewController * VC = [[imgCollectionViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
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
