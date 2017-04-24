//
//  MovieModel.h
//  Lee_One
//
//  Created by watchman on 2017/4/23.
//  Copyright © 2017年 Hervey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieModel : NSObject
@property (nonatomic, strong)NSString *id;
@property (nonatomic, strong)NSString *item_id;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *forward;
@property (nonatomic, strong)NSString *img_url;
@property (nonatomic,retain)NSNumber *like_count;
@property (nonatomic, strong)NSString *post_date;
@property (nonatomic, strong)NSDictionary *author;
@property (nonatomic, strong)NSString *subtitle;
@property (nonatomic, strong)NSString *movie_story_id;
@property (nonatomic, strong)NSString *content_id;
@property (nonatomic, strong)NSArray *tag_list;


@end
