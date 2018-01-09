//
//  ColorMacro.h
//  Foods Cook
//
//  Created by 邓莎 on 2017/9/29.
//  Copyright © 2017年 邓莎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+Hex.h"

#ifndef ColorMacro_h
#define ColorMacro_h

///主题蓝
static const unsigned long ThemColor = 0x1b8bff;
///黑色
static const unsigned long BlackTextColor = 0x333333;
///背景色
static const unsigned long BackGroundColor = 0xf2f2f2;

/**
 根据16进制设置颜色

 @param colorString 16进制
 @return 颜色
 */
static inline UIColor *ColorWithValue(unsigned long colorString){
    return [UIColor colorWithHexValue:colorString];
}

static inline UIColor *ColorWithValueAndAlpha(unsigned long colorString, CGFloat alpha){
    return [UIColor colorWithHexValue:colorString andAlpha:alpha];
}

#endif /* ColorMacro_h */
