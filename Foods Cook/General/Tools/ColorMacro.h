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

static inline UIColor *ColorWithValue(unsigned long colorString){
    return [UIColor colorWithHexValue:colorString];
}

static inline UIColor *ColorWithValueAndAlpha(unsigned long colorString, CGFloat alpha){
    return [UIColor colorWithHexValue:colorString andAlpha:alpha];
}

#endif /* ColorMacro_h */
