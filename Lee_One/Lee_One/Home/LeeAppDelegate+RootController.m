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
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    UIViewController* vc = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = vc;
}




#pragma mark - Windows
- (void)setTabbarController
{
    
    
    MovieViewController *movieC = [[MovieViewController alloc]init];
    UINavigationController *movieN = [[UINavigationController alloc]initWithRootViewController:movieC];
    UIImage * homaNavi = [UIImage imageNamed:@"icon_home_gray"];
    UIImage * tapHomeNavi = [UIImage imageNamed:@"icon_home_highlight"];
    movieN.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"影视" image:homaNavi selectedImage:tapHomeNavi];
//    AboutChildViewController *child  = [[AboutChildViewController alloc]init];
    //    UINavigationController *chidNav = [[UINavigationController alloc]initWithRootViewController:child];
    
//    CommuntiyViewController *edu = [[CommuntiyViewController alloc]init];
    //    UINavigationController *eduNav = [[UINavigationController alloc]initWithRootViewController:edu];
    
//    SZCourseListViewController *courseList = [[SZCourseListViewController alloc]init];
    //    UINavigationController *courseListNav = [[UINavigationController alloc]initWithRootViewController:courseList];
    
//    AboutMeViewController *about = [[AboutMeViewController alloc]init];
    //    UINavigationController *aboutNav = [[UINavigationController alloc]initWithRootViewController:about];
    UITabBarController *tabbarController = [[UITabBarController alloc]init];
    [tabbarController.tabBar setTranslucent:NO];
    tabbarController.viewControllers = @[movieN];
    tabbarController.selectedIndex = 0;
    self.window.rootViewController = tabbarController;
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
