//
//  CZQCollectionItem.h
//  BuDeJie
//
//  Created by 陈志强 on 16/11/28.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZQCollectionItem : NSObject
//字典数组转模型数组 url(跳转地址) name icon(图片地址)
@property(nonatomic, copy)NSString *url;
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *icon;
@end
