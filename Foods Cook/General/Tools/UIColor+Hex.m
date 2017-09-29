//
//  UIColor+Hex.m
//  Foods Cook
//
//  Created by 邓莎 on 2017/9/29.
//  Copyright © 2017年 邓莎. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHexValue:(unsigned long)hexValue{
    return [self colorWithHexValue:hexValue andAlpha:1];
}

+ (UIColor *)colorWithHexValue:(unsigned long)hexValue andAlpha:(CGFloat)alpha{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:alpha];
}

@end
