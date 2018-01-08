//
//  FCDrectionCarouselView.h
//  Foods Cook
//
//  Created by 邓莎 on 2018/1/4.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import <UIKit/UIKit.h>
/**纵向轮播器**/
@protocol FCDrectionCarouselViewDelegate <NSObject>

@optional
///轮播点击
- (void)crouselViewDidSelectIndex:(NSInteger)index;

@end

@interface FCDrectionCarouselView : UIView

@property (nonatomic, weak)id <FCDrectionCarouselViewDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;///改初始化方法不可用

- (instancetype)initWithFrame:(CGRect)frame;

- (void)setDataWithArray:(NSArray<NSString *> *)array;

@end
