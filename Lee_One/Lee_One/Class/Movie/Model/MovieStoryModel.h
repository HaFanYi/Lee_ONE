//
//  MovieStoryModel.h
//  Lee_One
//
//  Created by watchman on 2017/4/25.
//  Copyright © 2017年 Hervey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieStoryModel : NSObject
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSNumber *praisenum;
@property (nonatomic, strong)NSString *summary;
@property (nonatomic, strong)NSString *charge_edt;
@property (nonatomic, strong)NSString *editor_email;
@property (nonatomic, strong)NSString *copyright;

@property (nonatomic, strong)NSDictionary *user;

@end
