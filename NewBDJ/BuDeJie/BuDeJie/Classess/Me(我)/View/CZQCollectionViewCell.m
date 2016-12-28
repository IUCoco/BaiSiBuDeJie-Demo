//
//  CZQCollectionViewCell.m
//  BuDeJie
//
//  Created by 陈志强 on 16/11/28.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CZQCollectionViewCell.h"
#import "CZQCollectionItem.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CZQCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;


@end

@implementation CZQCollectionViewCell

- (void)setItem:(CZQCollectionItem *)item{
    _item = item;
    //图片
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    //标题
    _nameLable.text = item.name;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
