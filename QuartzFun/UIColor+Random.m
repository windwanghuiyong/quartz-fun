//
//  UIColor+Random.m
//  QuartzFun
//
//  Created by wanghuiyong on 30/01/2017.
//  Copyright © 2017 Personal Organization. All rights reserved.
//

#import "UIColor+Random.h"

@implementation UIColor (Random)

+(UIColor *)randomColor {
    // 0.0~1.0的随机数, 256色
    CGFloat red = (CGFloat)(arc4random() % 256) / 255;
    CGFloat blue = (CGFloat)(arc4random() % 256) / 255;
    CGFloat green = (CGFloat)(arc4random() % 256) / 255;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

@end
