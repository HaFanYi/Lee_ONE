//
//  LeeRootViewController.h
//  qiongyou--mirror
//
//  Created by watchman on 2017/4/8.
//  Copyright © 2017年 Hervey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSAlertController.h"
#import "CWStatusBarNotification.h"
#define ProgressColor VTColor(9,287,7)
@interface LeeRootViewController : UIViewController
@property (nonatomic,strong)CWStatusBarNotification *statusNotifation;
- (void)messageBar;
/**
 *  是否显示tabbar
 */
@property (nonatomic,assign)Boolean isShowTabbar;

/**
 *  需要登录的提示窗口
 */
@property (nonatomic,strong)MSAlertController *actionSheet;

- (void)createNavBar;

/**
 *  显示没有数据页面
 */
-(void)showNoDataImage;

/**
 *  移除无数据页面
 */
-(void)removeNoDataImage;

/**
 *  需要登录
 */
- (void)showShouldLoginPoint;

/**
 *  加载视图
 */
- (void)showLoadingAnimation;


/**
 *  停止加载
 */
- (void)stopLoadingAnimation;

/**
 *  分享页面
 *
 *  @param url   url
 *  @param title 标题
 */
- (void)shareUrl:(NSString *)url andTitle:(NSString *)title;

- (void)goLogin;

/**
 *  状态栏
 */
- (void)initStatusBar;

- (void)showStatusBarWithTitle:(NSString *)title;

- (void)changeStatusBarTitle:(NSString *)title;
- (void)hiddenStatusBar;


@end
