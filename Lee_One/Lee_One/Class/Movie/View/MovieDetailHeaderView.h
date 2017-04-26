//
//  MovieDetailHeaderView.h
//  Lee_One
//
//  Created by watchman on 2017/4/26.
//  Copyright © 2017年 Hervey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailHeaderView : UIView<LeeScrollViewDelegate>
@property (nonatomic, strong)LeeScrollView *leeScrollV;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)NSMutableArray *imageArr;

- (instancetype)initWithFrame:(CGRect)frame data:(NSMutableArray *)dataArr;
@end
