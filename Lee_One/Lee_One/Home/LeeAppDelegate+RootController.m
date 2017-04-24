//
//  LeeAppDelegate+RootController.m
//  qiongyou--mirror
//
//  Created by watchman on 2017/4/8.
//  Copyright © 2017年 Hervey. All rights reserved.
//

#import "LeeAppDelegate+RootController.h"
#import "MovieViewController.h"
@interface AppDelegate ()<RDVTabBarControllerDelegate,UIScrollViewDelegate,UITabBarControllerDelegate>
@end

@implementation AppDelegate (RootController)
- (void)setRootViewController
{
    if ([LUserDefault objectForKey:@"isOne"])
    {//不是第一次安装
//        [self checkBlack];
        [self setRoot];
        
    }
    else
    {
//        UIViewController *emptyView = [[ UIViewController alloc ]init ];
//        self. window .rootViewController = emptyView;
//        [self createLoadingScrollView];
        [self setRoot];
    }
}

- (void)setRoot
{
    UINavigationController * navc = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    navc.navigationBar.barTintColor = [UIColor whiteColor];
    
    navc.navigationBar.shadowImage = [[UIImage alloc] init];
    [navc.navigationBar setTranslucent:NO];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [navc.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    navc.navigationBar.tintColor = [UIColor whiteColor];
    self.window.rootViewController = navc;
}




#pragma mark - Windows
- (void)setTabbarController
{
    
    
    MovieViewController *movie = [[MovieViewController alloc]init];
    //    UINavigationController *schoolNav = [[UINavigationController alloc]initWithRootViewController:school];
    
//    AboutChildViewController *child  = [[AboutChildViewController alloc]init];
    //    UINavigationController *chidNav = [[UINavigationController alloc]initWithRootViewController:child];
    
//    CommuntiyViewController *edu = [[CommuntiyViewController alloc]init];
    //    UINavigationController *eduNav = [[UINavigationController alloc]initWithRootViewController:edu];
    
//    SZCourseListViewController *courseList = [[SZCourseListViewController alloc]init];
    //    UINavigationController *courseListNav = [[UINavigationController alloc]initWithRootViewController:courseList];
    
//    AboutMeViewController *about = [[AboutMeViewController alloc]init];
    //    UINavigationController *aboutNav = [[UINavigationController alloc]initWithRootViewController:about];
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[movie]];
    self.viewController = tabBarController;
    tabBarController.delegate = self;
    [self customizeTabBarForController:tabBarController];
}

- (void)tabBarController:(RDVTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[MovieViewController class]])
    {
        tabBarController.navigationItem.title = @"影视";
    }
//    if ([viewController isKindOfClass:[AboutChildViewController class]])
//    {
//        tabBarController.navigationItem.title = @"学员动态";
//    }
//    if ([viewController isKindOfClass:[CommuntiyViewController class]])
//    {
//        tabBarController.navigationItem.title = @"发现";
//    }
//    if ([viewController isKindOfClass:[CourseViewController class]])
//    {
//        tabBarController.navigationItem.title = @"课程";
//    }
//    if ([viewController isKindOfClass:[AboutMeViewController class]])
//    {
//        tabBarController.navigationItem.title = @"我";
//    }
}

/*
 自定义tabbar
 */
- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController
{
    
    UIImage *finishedImage = [DIYTool createImageWithColor:[UIColor whiteColor]];
    UIImage *unfinishedImage = [DIYTool createImageWithColor:[UIColor whiteColor]];
//    NSArray *tabBarItemImages = @[@"tpo_tab_home",@"tpo_tab_found",@"tab_children",@"tpo_tab_course",@"tpo_tab_user"];
//    NSArray *selectedImages = @[@"tpo_tab_home_pre",@"tpo_tab_found_pre",@"tab_children_pre",@"tpo_tab_course_pre",@"tpo_tab_user_pre"];
//    
    //    NSArray *tabBarItemImages = @[@"tab_home",@"tab_Community",@"-child-dynamic.png",@"tab_relation",@"tab_me"];
    //    NSArray *selectedImages = @[@"tab_home_pre",@"tab_Community_pre",@"-child-dynamic.png",@"tab_relation_pre",@"tab_me_pre"];
    
    
    NSInteger index = 0;
    [[tabBarController tabBar] setTranslucent:YES];
    for (RDVTabBarItem *item in [[tabBarController tabBar] items])
    {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
//        UIImage *selectedimage = [UIImage imageNamed:[selectedImages objectAtIndex:index]];
//        UIImage *unselectedimage = [UIImage imageNamed:[tabBarItemImages objectAtIndex:index]];
        //        item.imagePositionAdjustment = UIOffsetMake(0, -5);
        [item setFinishedSelectedImage:nil withFinishedUnselectedImage:nil];
        NSDictionary *unseleAtrr = @{
                                     NSFontAttributeName: [UIFont systemFontOfSize:11],
                                     NSForegroundColorAttributeName: VTColor(65, 85, 129),
                                     };
        NSDictionary *seleAtrr = @{
                                   NSFontAttributeName: [UIFont systemFontOfSize:11],
                                   NSForegroundColorAttributeName: Main_Color,
                                   };
        [item setUnselectedTitleAttributes:unseleAtrr];
        [item setSelectedTitleAttributes:seleAtrr];
        
        [item setTitle:@[@"影视"][index]];
        index++;
    }
}
- (void)setAppWindows
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
//    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
}
#pragma mark - 引导页
- (void)createLoadingScrollView
{//引导页
    UIScrollView *sc = [[UIScrollView alloc]initWithFrame:self.window.bounds];
    sc.pagingEnabled = YES;
    sc.delegate = self;
    sc.showsHorizontalScrollIndicator = NO;
    sc.showsVerticalScrollIndicator = NO;
    [self.window.rootViewController.view addSubview:sc];
    
    NSArray *arr = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"];
    for (NSInteger i = 0; i<arr.count; i++)
    {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenW*i, 0, kScreenW, self.window.frame.size.height)];
        img.image = [UIImage imageNamed:arr[i]];
        [sc addSubview:img];
        img.userInteractionEnabled = YES;
        if (i == arr.count - 1)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame = CGRectMake((self.window.frame.size.width/2)-50, kScreenH-110, 100, 40);
            btn.backgroundColor = Main_Color;
            [btn setTitle:@"开始体验" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(goToMain) forControlEvents:UIControlEventTouchUpInside];
            [img addSubview:btn];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = Main_Color.CGColor;
        }
    }
    sc.contentSize = CGSizeMake(kScreenW*arr.count, self.window.frame.size.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x>kScreenW *4+30)
    {
        [self goToMain];
    }
}

- (void)goToMain
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:@"isOne" forKey:@"isOne"];
    [user synchronize];
    [self setRoot];
    // self.window.rootViewController = self.viewController;
}

@end
