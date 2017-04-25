//
//  MovieInfoViewController.m
//  Lee_One
//
//  Created by watchman on 2017/4/25.
//  Copyright © 2017年 Hervey. All rights reserved.
//

#import "MovieInfoViewController.h"

@interface MovieInfoViewController ()

@end

@implementation MovieInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavi];
    self.view.backgroundColor = [UIColor grayColor];
    NSLog(@"%ld",self.item_id);
    UIView *views = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH-114, kScreenW, 50)];
    [self.view addSubview:views];
    views.backgroundColor = [UIColor whiteColor];
    [self requestAllData];
}

#pragma mark --navigation设置
- (void)setNavi {
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.navigationItem.title = self.title;
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

//请求全部数据
- (void)requestAllData {
    NSString *story = [NSString stringWithFormat:@"/%ld?version=v4.0.1",self.item_id];
    NSString *detail_url = [NSString stringWithFormat:@"%s%@",movie_detail_url,story];
    [HttpsRequest requestWithURLString:detail_url parameters:nil type:HTTPSRequestTypeGet success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        
    }];
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
