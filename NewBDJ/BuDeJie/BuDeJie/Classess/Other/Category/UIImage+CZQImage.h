//
//  UIImage+CZQImage.h
//  BuDeJie
//
//  Created by 陈志强 on 16/11/21.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CZQImage)
//快速创建没有被渲染的图片
+ (UIImage *)imageOriginalWithName:(NSString *)name;

@end
