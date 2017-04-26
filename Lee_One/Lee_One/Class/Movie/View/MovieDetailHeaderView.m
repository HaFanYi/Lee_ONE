//
//  MovieDetailHeaderView.m
//  Lee_One
//
//  Created by watchman on 2017/4/26.
//  Copyright © 2017年 Hervey. All rights reserved.
//

#import "MovieDetailHeaderView.h"
#import "MovieDetailModel.h"
@implementation MovieDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame data:(NSMutableArray *)dataArr{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageArr = [NSMutableArray arrayWithCapacity:0];
        self.dataArr = dataArr;
        MovieDetailModel *model = dataArr[0];
        NSMutableArray *imgArr = [NSMutableArray arrayWithCapacity:0];
        imgArr = [model.photo mutableCopy];
        [imgArr insertObject:model.detailcover atIndex:0];
        for (int i = 0; i< imgArr.count; i++) {
            [self.imageArr addObject:imgArr[i]];
        }
        self.backgroundColor = [UIColor whiteColor];
        self.leeScrollV = [[LeeScrollView alloc]init];
        [self addSubview:self.leeScrollV];
        [self.leeScrollV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kScreenW, 200));
        }];
        self.leeScrollV.placeholderImage = [UIImage imageNamed:@"LeePlaceholder.png"];
        NSLog(@"%@",self.imageArr);
        self.leeScrollV.imageArray = self.imageArr;
        self.leeScrollV.delegate = self;
        self.leeScrollV.start = NO;
        //设置图片切换的方式
        self.leeScrollV.circlePosition = circleBottomRight;
        self.leeScrollV.changeMode = ChangeModeFade;
    }
    return self;
}

#pragma mark -手势响应事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //清除缓存
    [LeeScrollView clearDiskCache];
    
}
#pragma mark LeeScrollViewDelegate
- (void)leeScrollView:(LeeScrollView *)leeScrollView clickImageAtIndex:(NSInteger)index {
    NSLog(@"click...%ld张图片",index);
}


@end
