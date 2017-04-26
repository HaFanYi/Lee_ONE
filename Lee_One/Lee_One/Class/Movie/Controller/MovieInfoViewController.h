//
//  MovieInfoViewController.h
//  Lee_One
//
//  Created by watchman on 2017/4/25.
//  Copyright © 2017年 Hervey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieInfoViewController : UIViewController<UIScrollViewDelegate>
@property (nonatomic)NSInteger item_id;
@property (nonatomic, strong)NSString *nav_title;

@end
