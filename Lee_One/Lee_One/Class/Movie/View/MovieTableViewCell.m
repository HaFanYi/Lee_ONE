//
//  MovieTableViewCell.m
//  Lee_One
//
//  Created by watchman on 2017/4/23.
//  Copyright © 2017年 Hervey. All rights reserved.
//

#import "MovieTableViewCell.h"

@implementation MovieTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.typeLabel = [[UILabel alloc]init];
        self.typeLabel.font = [UIFont systemFontOfSize:13.0];
        self.typeLabel.textColor = CommonColor;
        self.typeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.typeLabel];
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(80, 20));
        }];
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.font = [UIFont systemFontOfSize:23.0];
        self.titleLabel.textColor = [UIColor blackColor];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.typeLabel.mas_bottom).with.offset(10);
            make.left.equalTo(self).with.offset(50);
            make.width.equalTo(@(kScreenW-110));
        }];
        self.authorlLabel = [[UILabel alloc]init];
        self.authorlLabel.textColor = CommonColor;
        self.authorlLabel.font = [UIFont systemFontOfSize:16.0];
        [self addSubview:self.authorlLabel];
        [self.authorlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(50);
            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10);
            make.width.equalTo(@(kScreenW-50));
        }];
        self.img_url_view = [[UIImageView alloc]init];
        self.img_url_view.layer.masksToBounds = YES;
        self.img_url_view.layer.cornerRadius = 6;
        [self addSubview:self.img_url_view];
        [self.img_url_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.authorlLabel.mas_bottom).with.offset(10);
            make.left.equalTo(self).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(kScreenW-20, 200));
        }];
        self.forwardLabel = [[UILabel alloc]init];
        self.forwardLabel.font = [UIFont systemFontOfSize:13.0];
        self.forwardLabel.textColor = CommonColor;
        self.forwardLabel.numberOfLines = 0;
        self.forwardLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:self.forwardLabel];
        [self.forwardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.img_url_view.mas_bottom).with.offset(10);
            make.left.equalTo(self).with.offset(48);
            make.width.equalTo(@(kScreenW-110));
        }];
        self.subtitleLabel = [[UILabel alloc]init];
        self.subtitleLabel.font = [UIFont systemFontOfSize:13.0];
        self.subtitleLabel.textAlignment = NSTextAlignmentRight;
        self.subtitleLabel.textColor = CommonColor;
        [self addSubview:self.subtitleLabel];
        [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.forwardLabel.mas_bottom).with.offset(5);
            make.right.equalTo(self).with.offset(-50);
            make.width.equalTo(@(kScreenW-50));
        }];
        self.dateLabel = [[UILabel alloc]init];
        self.dateLabel.textColor = textFontColor;
        self.dateLabel.font = [UIFont systemFontOfSize:10.0];
        [self addSubview:self.dateLabel];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(45);
            make.bottom.equalTo(self.mas_bottom).with.offset(-10);
            make.size.mas_equalTo(CGSizeMake(50, 20));
        }];
        self.shareBtn = [[UIButton alloc]init];
        [self addSubview:self.shareBtn];
        [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).with.offset(-10);
            make.right.equalTo(self).with.offset(-10);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        self.shareBtn.backgroundColor = [UIColor redColor];
        self.likeBtn = [[UIButton alloc]init];
        [self addSubview:self.likeBtn];
        [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).with.offset(-10);
            make.right.equalTo(self.shareBtn.mas_left).with.offset(-20);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        self.likeBtn.backgroundColor = [UIColor greenColor];
        self.like_count_label = [[UILabel alloc]init];
        self.like_count_label.font = [UIFont systemFontOfSize:10.0];
        self.like_count_label.textColor = textFontColor;
        self.like_count_label.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.like_count_label];
        [self.like_count_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).with.offset(-10);
            make.right.equalTo(self.likeBtn.mas_left).with.offset(-5);
            make.size.mas_equalTo(CGSizeMake(80, 20));
        }];
        self.like_count_label.backgroundColor = [UIColor grayColor];
    }
    return self;
}


+ (CGFloat)heightForCellWithText:(NSString *)text width:(CGFloat)width font:(CGFloat)font{
    return  [self detailTextHeight:text width:width font:font];
}

+ (CGFloat)detailTextHeight:(NSString *)text  width:(CGFloat)width font:(CGFloat)font{
    CGRect rectToFit = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]} context:nil];
    return rectToFit.size.height;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
