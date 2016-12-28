//
//  CZQFollowCell.m
//  BuDeJie
//
//  Created by 陈志强 on 16/11/24.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CZQFollowCell.h"
#import "CZQFollowItem.h"
#import <UIImageView+WebCache.h>

@interface CZQFollowCell ()
//图片
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
//标题
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
//子标题数目
@property (weak, nonatomic) IBOutlet UILabel *subLable;

@end

@implementation CZQFollowCell

- (void)setItem:(CZQFollowItem *)item{
    //设置图片
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //设置主题
    self.nameLable.text = item.theme_name;
    //设置子标题数目
    [self resolveNum];
    _item = item;

}

//处理订阅数字
- (void)resolveNum{
    NSString *numStr = [NSString stringWithFormat:@"%@人订阅",_item.sub_number];
    NSInteger num = [_item.sub_number integerValue];
    if (num >= 10000) {
        CGFloat numF = num / 10000.0;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅", numF];
        //去掉整数后面的零
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    self.subLable.text = numStr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //设置头像圆角
    self.iconView.layer.cornerRadius = 30;
    self.iconView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
