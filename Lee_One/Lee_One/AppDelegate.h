//
//  AppDelegate.h
//  Lee_One
//
//  Created by watchman on 2017/4/23.
//  Copyright © 2017年 Hervey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic)UIViewController * viewController;

+ (UINavigationController *)rootNavigationController;
@end

