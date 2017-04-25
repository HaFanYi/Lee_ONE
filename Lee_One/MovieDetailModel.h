//
//  MovieDetailModel.h
//  Lee_One
//
//  Created by watchman on 2017/4/25.
//  Copyright © 2017年 Hervey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieDetailModel : NSObject
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *detailcover;
@property (nonatomic, strong)NSString *video;
@property (nonatomic, strong)NSString *info;
@property (nonatomic, strong)NSString *officialstory;
@property (nonatomic, strong)NSString *poster;
@property (nonatomic, strong)NSArray *photo;
@property (nonatomic, strong)NSDictionary *share_list;
@property (nonatomic, strong)NSNumber *commentnum;

@end
