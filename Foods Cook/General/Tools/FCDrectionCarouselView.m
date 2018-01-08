//
//  FCDrectionCarouselView.m
//  Foods Cook
//
//  Created by 邓莎 on 2018/1/4.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import "FCDrectionCarouselView.h"
#import "WeakTimer.h"

@interface FCDrectionCarouselView()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *bottomLabel;
///标记当前显示的位置
@property (nonatomic, assign) NSInteger index;
///数据源
@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation FCDrectionCarouselView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.index = 0;
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(frame),  CGRectGetHeight(frame) * 2);
        [self addSubview:self.scrollView];
        
        UIView *topView = [[UIView alloc] init];
        [self.scrollView addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.right.equalTo(self);
            make.height.equalTo(@(CGRectGetHeight(frame)));
        }];
        self.topLabel = [[UILabel alloc] init];
        [topView addSubview:self.topLabel];
        [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.centerY.equalTo(topView.mas_centerY);
        }];
        UIButton *topButton = [[UIButton alloc] init];
        [topButton addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:topButton];
        [topButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(topView);
        }];
        
        UIView *bottomView = [[UIView alloc] init];
        [self.scrollView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(CGRectGetHeight(frame)));
            make.left.right.equalTo(self);
            make.height.equalTo(@(CGRectGetHeight(frame)));
        }];
        self.bottomLabel = [[UILabel alloc] init];
        [bottomView addSubview:self.bottomLabel];
        [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.centerY.equalTo(bottomView.mas_centerY);
        }];
        UIButton *bottomButton = [[UIButton alloc] init];
        [bottomButton addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:bottomButton];
        [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(bottomView);
        }];
    }
    return self;
}


/**
 轮播器点击button点击

 @param sender sender
 */
- (void)touchUp:(id)sender{
    NSInteger num;
    if (self.index == -1) {
        num = self.dataArray.count - 1;
    }else{
        num = self.index;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(crouselViewDidSelectIndex:)]) {
        [self.delegate crouselViewDidSelectIndex:num];
    }
}


/**
 设置数据

 @param array 数据（nsstring）
 */
- (void)setDataWithArray:(NSArray<NSString *> *)array{
    self.dataArray = array;
    if (array.count == 0) {
        return;
    }
    self.topLabel.text = array[0];
    [WeakTimer scheduledTimerWithTimerInterval:2 target:self selector:@selector(timeCirculation) userInfo:nil repeats:YES];
}

/**
 scrollView偏移位回到原位

 @param content 当前轮播器的显示
 */
- (void)setOriginWithContent:(NSString *)content{
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
    self.topLabel.text = content;
}

/**
 定时循环
 */
- (void)timeCirculation{
    self.index ++;
    [UIView animateWithDuration:0.3 animations:^{
        [self.scrollView setContentOffset:CGPointMake(0, CGRectGetHeight(self.frame))];
        [self.bottomLabel setText:self.dataArray[self.index]];
    } completion:^(BOOL finished) {
        [self setOriginWithContent:self.dataArray[self.index]];
        if (self.index == self.dataArray.count - 1) {
            self.index = -1;
        }
    }];
}

@end
