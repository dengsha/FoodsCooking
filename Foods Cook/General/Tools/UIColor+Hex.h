//
//  UIColor+Hex.h
//  Foods Cook
//
//  Created by 邓莎 on 2017/9/29.
//  Copyright © 2017年 邓莎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHexValue:(unsigned long)hexValue;
+ (UIColor *)colorWithHexValue:(unsigned long)hexValue andAlpha:(CGFloat)alpha;

@end
