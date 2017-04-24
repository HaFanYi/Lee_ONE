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
@interface MovieViewController ()
@property (nonatomic, strong)NSMutableArray *data_arr;
@property (nonatomic, strong)UITableView *tableView;
@end

@implementation MovieViewController

- (void)viewDidLoad {
    self.data_arr = [NSMutableArray arrayWithCapacity:0];
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self requestData];
}

- (void)requestData {
    NSString *m_url = [NSString stringWithFormat:@"/movie/more/%d",0];
    NSString *url = [NSString stringWithFormat:@"%s%@",channel_url,m_url];
    [HttpsRequest requestWithURLString:url parameters:nil type:HTTPSRequestTypeGet success:^(id responseObject) {
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dic in data) {
            MovieModel *model = [[MovieModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.data_arr addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

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
    NSString *sub = [model.subtitle substringFromIndex:3];
    cell.subtitleLabel.text = [NSString stringWithFormat:@"——《%@》",sub];
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
          cell.dateLabel.text = [NSString stringWithFormat:@"%ld天前",res];
    }
    return  cell;
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
    return 1;
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
