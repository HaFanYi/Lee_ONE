//
//  MovieInfoViewController.m
//  Lee_One
//
//  Created by watchman on 2017/4/25.
//  Copyright © 2017年 Hervey. All rights reserved.
//

#import "MovieInfoViewController.h"
#import "MovieStoryModel.h"
#import "MovieDetailModel.h"
#import "MovieCommentModel.h"
#import "MovieDetailHeaderView.h"
@interface MovieInfoViewController ()
@property (nonatomic,strong)NSMutableArray *detailArr;
@property (nonatomic,strong)UIScrollView *scrollView;
@end

@implementation MovieInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailArr = [NSMutableArray arrayWithCapacity:0];
    [self setNavi];
    [self requestAllData];
     [self setBasicView];
}

#pragma mark --navigation设置
- (void)setNavi {
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.navigationItem.title = self.nav_title;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"go"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItem:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"go"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItem:)];
    
}
//导航条左右两侧按钮
- (void)leftBarButtonItem:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightBarButtonItem:(UIBarButtonItem *)sender {
    NSLog(@"share...");
}
#pragma mark --基本设置
- (void)setBasicView {
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64)];
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.scrollView];
    UIView *bottom_view = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH-114, kScreenW, 50)];
    [self.view addSubview:bottom_view];
    bottom_view.backgroundColor = [UIColor whiteColor];

}
//请求全部数据
- (void)requestAllData {
    NSString *story = [NSString stringWithFormat:@"/%ld?version=v4.0.1",self.item_id];
    NSString *detail_url = [NSString stringWithFormat:@"%s%@",movie_detail_url,story];
    [HttpsRequest requestWithURLString:detail_url parameters:nil type:HTTPSRequestTypeGet success:^(id responseObject) {
        MovieDetailModel *detailM = [[MovieDetailModel alloc]init];
        NSDictionary *dic = responseObject[@"data"];
        [detailM setValuesForKeysWithDictionary:dic];
        [self.detailArr addObject:detailM];
        MovieDetailHeaderView *headView = [[MovieDetailHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 200) data:self.detailArr];
        [self.scrollView addSubview:headView];
        [self requestStoryData];
        NSLog(@"%@",self.detailArr);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)requestStoryData {
    NSLog(@"%ld",self.detailArr.count);
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
