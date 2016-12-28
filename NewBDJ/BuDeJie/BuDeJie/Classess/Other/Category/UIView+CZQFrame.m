//
//  UIView+CZQFrame.m
//  BuDeJie
//
//  Created by 陈志强 on 16/11/22.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "UIView+CZQFrame.h"

@implementation UIView (CZQFrame)

- (void)setCzq_x:(CGFloat)czq_x{
    CGRect rect = self.frame;
    rect.origin.x = czq_x;
    self.frame = rect;
}

- (CGFloat)czq_x{
    return self.frame.origin.x;
}

- (void)setCzq_y:(CGFloat)czq_y{
    CGRect rect = self.frame;
    rect.origin.y = czq_y;
    self.frame = rect;
}

- (CGFloat)czq_y{
    return self.frame.origin.y;
}

- (void)setCzq_with:(CGFloat)czq_with{
    CGRect rect = self.frame;
    rect.size.width = czq_with;
    self.frame = rect;
}

- (CGFloat)czq_with{
    return self.frame.size.width;
}

- (void)setCzq_hight:(CGFloat)czq_hight{
    CGRect rect = self.frame;
    rect.size.height = czq_hight;
    self.frame = rect;
}

- (CGFloat)czq_hight{
    return self.frame.size.height;
}

- (void)setCzq_centerX:(CGFloat)czq_centerX{
    CGPoint point = self.center;
    point.x = czq_centerX;
    self.center = point;
}

- (CGFloat)czq_centerX{
    return self.center.x;
}

- (void)setCzq_centerY:(CGFloat)czq_centerY{
    CGPoint point = self.center;
    point.y = czq_centerY;
    self.center = point;
}

- (CGFloat)czq_centerY{
    return self.center.y;
}




@end
