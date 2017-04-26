//
//  MovieCommentModel.h
//  Lee_One
//
//  Created by watchman on 2017/4/25.
//  Copyright © 2017年 Hervey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieCommentModel : NSObject
@property (nonatomic, strong)NSString *id;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSString *input_date;
@property (nonatomic, strong)NSDictionary *user;
@property (nonatomic, strong)NSString *quote;
@property (nonatomic, strong)NSDictionary *toyser;
@property (nonatomic, strong)NSNumber *type;

@end
