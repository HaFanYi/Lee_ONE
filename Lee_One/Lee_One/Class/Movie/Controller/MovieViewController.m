//
//  MovieViewController.m
//  Lee_One
//
//  Created by watchman on 2017/4/23.
//  Copyright © 2017年 Hervey. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieModel.h"
#import "MovieTableViewCell.h"
#import "MovieInfoViewController.h"
@interface MovieViewController ()
{
   BOOL isHeader;
   BOOL isFooter;
   NSInteger count;
}
@property (nonatomic, strong)NSMutableArray *data_arr;
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation MovieViewController

- (void)viewDidLoad {
    self.data_arr = [NSMutableArray arrayWithCapacity:0];
    [super viewDidLoad];
    [self setNavi];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-40) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self requestDataWithMore:0];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (isHeader==1) {
            isHeader = 0;
            [self requestDataWithMore:0];
        }
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            if (count == 0) {
                [self requestDataWithMore:0];
            }else {
                [self requestDataWithMore:count];
            }
    }];
}

#pragma mark --navigation设置
- (void)setNavi {
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.navigationItem.title = @"一个影视";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"go"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItem:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"go"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItem:)];

}
//导航条左右两侧按钮
- (void)leftBarButtonItem:(UIBarButtonItem *)sender {
    NSLog(@"myself...");
}
- (void)rightBarButtonItem:(UIBarButtonItem *)sender {
    NSLog(@"search...");
}
#pragma mark --数据请求
- (void)requestDataWithMore:(NSInteger)num {
    NSString *m_url = [NSString stringWithFormat:@"/movie/more/%ld?version=v4.0.1",num];
    NSString *url = [NSString stringWithFormat:@"%s%@",channel_url,m_url];
    if (isHeader==0) {
        [self.data_arr removeAllObjects];
        [self.tableView reloadData];
    }
    [HttpsRequest requestWithURLString:url parameters:nil type:HTTPSRequestTypeGet success:^(id responseObject) {
        NSMutableDictionary *dics = (NSMutableDictionary *)responseObject;
        NSArray *data = dics[@"data"];
        for (NSDictionary *dic in data) {
            MovieModel *model = [[MovieModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.data_arr addObject:model];
        }
        MovieModel *model = self.data_arr.lastObject;
        count = [model.id integerValue];
        isHeader = 1;
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        isHeader = 1;
        NSLog(@"%@",error);
    }];
}

#pragma mark --tableViewDelegate tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data_arr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieTableViewCell"];
    if (!cell) {
        cell = [[MovieTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MovieTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MovieModel *model = self.data_arr[indexPath.section];
    NSArray *tag_arr = model.tag_list;
    if (tag_arr.count == 0) {
         cell.typeLabel.text = [NSString stringWithFormat:@"-影视-"];
    }else {
        for (NSDictionary *dic in tag_arr) {
            cell.typeLabel.text = [NSString stringWithFormat:@"-%@-",dic[@"title"]];
        }
    }
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",model.title];
    cell.authorlLabel.text = [NSString stringWithFormat:@"文 / %@",model.author[@"user_name"]];
    [cell.img_url_view sd_setImageWithURL:[NSURL URLWithString:model.img_url] placeholderImage:[UIImage imageNamed:@""]];
    cell.forwardLabel.text = [NSString stringWithFormat:@"%@",model.forward];
    cell.subtitleLabel.text = [NSString stringWithFormat:@"——《%@》",model.subtitle];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"Y-MM-dd"];
    [formatter1 setTimeZone:timeZone];
    [formatter1 setDateFormat:@"Y-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    NSDate *post = [formatter dateFromString:[model.post_date substringToIndex:10]];
    NSString *n_date = [formatter stringFromDate:datenow];
    NSDate *new_date = [formatter dateFromString:n_date];
    NSTimeInterval new = [new_date timeIntervalSince1970];
    NSTimeInterval time = [post timeIntervalSince1970];
    NSTimeInterval current = [datenow timeIntervalSince1970];
    NSDate *post_w = [formatter1 dateFromString:model.post_date];
    NSTimeInterval p_time = [post_w timeIntervalSince1970];
    NSInteger res = (NSInteger)(new-time)/86400;
    NSInteger res1 = (NSInteger)(current-p_time)%86400;
    if (res==0) {
          res = res1/3600;
          cell.dateLabel.text = [NSString stringWithFormat:@"%ld小时前",res];
    }else {
        if (res>3) {
             [formatter setDateFormat:@"Y/MM/dd"];
             cell.dateLabel.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:post]];
        }else {
             cell.dateLabel.text = [NSString stringWithFormat:@"%ld天前",res];
        }
    }
    NSNumber *like_count = model.like_count;
    cell.like_count_label.text = [NSString stringWithFormat:@"%@",like_count];
    [cell.likeBtn addTarget:self action:@selector(likeBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.likeBtn.tag = indexPath.section;
    [cell.shareBtn addTarget:self action:@selector(shareBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.shareBtn.tag = indexPath.section;
    return  cell;
}

#pragma mark -- 点赞按钮和分享按钮
- (void)likeBtn:(UIButton *)sender {
    NSLog(@"dianzan:%ld",sender.tag);
}
- (void)shareBtn:(UIButton *)sender {
    NSLog(@"fenxiang:%ld",sender.tag);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieModel *model = self.data_arr[indexPath.section];
    MovieInfoViewController *infoView = [[MovieInfoViewController alloc]init];
    infoView.item_id = [model.item_id integerValue];
    NSArray *tag_arr = model.tag_list;
    if (tag_arr.count == 0) {
        infoView.title = [NSString stringWithFormat:@"一个影视"];
    }else {
        for (NSDictionary *dic in tag_arr) {
            infoView.nav_title = [NSString stringWithFormat:@"%@",dic[@"title"]];
        }
    }
    [infoView setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:infoView animated:YES];
    [infoView setHidesBottomBarWhenPushed:NO];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieModel *model = self.data_arr[indexPath.section];
    CGFloat t_height = [MovieTableViewCell heightForCellWithText:model.title width:kScreenW-110 font:23.0];
    CGFloat a_height = [MovieTableViewCell heightForCellWithText:model.author[@"user_name"] width:kScreenW-50 font:16.0];
    CGFloat f_height = [MovieTableViewCell heightForCellWithText:model.forward width:kScreenW-110 font:13.0];
    CGFloat s_height = [MovieTableViewCell heightForCellWithText:model.subtitle width:kScreenW-50 font:13.0];
    return t_height + a_height + f_height + s_height + 320;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat height = 0;
    if (section == (self.data_arr.count-1)) {
        height = 9;
    }else {
        height = 1;
    }
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = 0;
    if (section == 0) {
        height = 1;
    }else {
        height = 5;
    }
    return height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
