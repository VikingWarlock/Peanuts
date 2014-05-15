//
//  imgCollectionViewController.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "imgCollectionViewController.h"
#import <UIImage+BlurAndDarken.h>
#import "imgCollectionTableViewCell.h"
#import "CommentViewController.h"


@interface imgCollectionViewController (){
    UIButton * praiseBtn;
    UIButton * commentBtn;
    UIButton * shareBtn;
}

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UIView * bottomView;

@end

/**
 *
 *UITableView+extra里面两个方法可以快速的达到avatar的效果😳
 *
 *
 */



@implementation imgCollectionViewController

static NSString * cellIdentifier = @"cellIdentifier";

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
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setBackgroundImage:[UIImage imageNamed:@"1.png"] andBlurEnable:YES];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
    
    // Do any additional setup after loading the view.
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor whiteColor];
        [_tableView setBackgroundColor:[UIColor clearColor]];

//        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
//        imgView.image = [[UIImage imageNamed:@"1.png"] darkened:0.6 andBlurredImage:16.f];
//        _tableView.tableHeaderView = imgView;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
        [_tableView.tableHeaderView setBackgroundColor:[UIColor clearColor]];
   
        UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, _tableView.tableHeaderView.frame.size.height - 20, 60, 17)];
        nameLabel.text = @"aaaaa";
        nameLabel.textColor = [UIColor whiteColor];
        
        CGRect rect = nameLabel.frame;
        rect.origin.x = nameLabel.frame.origin.x + nameLabel.frame.size.width + 20;
        rect.size.width = 100;
        UILabel * timeLabel = [[UILabel alloc] initWithFrame:rect];
        timeLabel.text = @"2014-05-13";
        timeLabel.textColor = [UIColor whiteColor];
        
        [_tableView updateWithAvatar:[UIImage imageNamed:@"iron.png"] And_X_Offset:30.0 AndSize:CGSizeMake(70, 70)];

        
        [_tableView.tableHeaderView addSubview:nameLabel];
        [_tableView.tableHeaderView addSubview:timeLabel];
        
    }
    return _tableView;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width,50)];
        [_bottomView setBackgroundColor:[UIColor whiteColor]];
        _bottomView.alpha = 0.7;
        
        praiseBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, (self.view.frame.size.width - 20)/3, _bottomView.frame.size.height)];
        praiseBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 35, 10, 35);
        [praiseBtn setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
        [praiseBtn setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateHighlighted];
        [praiseBtn setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateSelected];
        [praiseBtn addTarget:self action:@selector(praiseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CGRect rect = praiseBtn.frame;
        rect.origin.x += rect.size.width;
        commentBtn = [[UIButton alloc] initWithFrame:rect];
        commentBtn.contentEdgeInsets = praiseBtn.contentEdgeInsets;
        [commentBtn setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
        [commentBtn setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateHighlighted];
        [commentBtn setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateSelected];
        [commentBtn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        rect.origin.x += rect.size.width;
        shareBtn = [[UIButton alloc] initWithFrame:rect];
        shareBtn.contentEdgeInsets = praiseBtn.contentEdgeInsets;
        [shareBtn setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
        [shareBtn setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateHighlighted];
        [shareBtn setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateSelected];
        [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_bottomView addSubview:praiseBtn];
        [_bottomView addSubview:commentBtn];
        [_bottomView addSubview:shareBtn];
    }
    return _bottomView;
}

-(void)praiseBtnClick:(UIButton *)sender{
    
}

-(void)commentBtnClick:(UIButton *)sender{
    CommentViewController * VC = [[CommentViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)shareBtnClick:(UIButton *)sender{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 500.0;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    imgCollectionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[imgCollectionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (indexPath.row == 0) {
        CGRect rect = cell.imgView.frame;
        rect.origin.y += 30;
        cell.imgView.frame = rect;
    }
    cell.imgView.image = [UIImage imageNamed:@"pic.jpg"];
    cell.titleLabel.text = @"001";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
