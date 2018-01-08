//
//  MoveScrollView.h
//  Foods Cook
//
//  Created by 邓莎 on 2018/1/8.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoveScrollViewDelegate <NSObject>

@optional

- (void)didSelectedWithIndex:(NSInteger)index;

@end

@interface MoveScrollView : UIView
///数据
@property (nonatomic, copy) NSArray *dataArray;
///默认选择0
@property (nonatomic, assign) NSInteger defaultIndex;

@property (nonatomic, weak) id<MoveScrollViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)array;

@end
