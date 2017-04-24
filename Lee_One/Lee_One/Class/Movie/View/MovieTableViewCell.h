//
//  MovieTableViewCell.h
//  Lee_One
//
//  Created by watchman on 2017/4/23.
//  Copyright © 2017年 Hervey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *typeLabel;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *authorlLabel;
@property (nonatomic, strong)UIImageView *img_url_view;
@property (nonatomic, strong)UILabel *forwardLabel;
@property (nonatomic, strong)UILabel *subtitleLabel;
@property (nonatomic, strong)UILabel *dateLabel;
@property (nonatomic, strong)UILabel *like_count_label;
@property (nonatomic, strong)UIButton *likeBtn;
@property (nonatomic, strong)UIButton *shareBtn;

+ (CGFloat)heightForCellWithText:(NSString *)text width:(CGFloat)width font:(CGFloat)font;
@end
