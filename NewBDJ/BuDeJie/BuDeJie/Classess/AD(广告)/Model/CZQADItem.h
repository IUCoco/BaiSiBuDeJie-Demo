//
//  CZQADItem.h
//  BuDeJie
//
//  Created by 陈志强 on 16/11/24.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZQADItem : NSObject

//json在线格式化工具，接口文档查看
/** 广告地址 */
@property (nonatomic, copy)NSString *w_picurl;
/** 广告地址连接地址 */
@property (nonatomic, copy)NSString *ori_curl;
/** 广告高度 */
@property (nonatomic, assign)CGFloat h;
/** 广告宽度 */
@property (nonatomic, assign)CGFloat w;




@end
