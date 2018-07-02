//
//  PageControlView.m
//  Foods Cook
//
//  Created by 邓莎 on 2018/5/30.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import "PageControlView.h"
#import "masonry.h"

@interface PageControlView()

@property (nonatomic, assign)NSInteger number;

@end

@implementation PageControlView

+ (PageControlView *)pageControlViewWithNumber:(NSInteger)number superView:(UIView *)superView{
    CGFloat width = (number-1) * 8 + number * 10;
    PageControlView *pageControl = [[self alloc] initWithFrame:CGRectMake(CGRectGetWidth(superView.frame)-width, CGRectGetWidth(superView.frame)-40, width, 40) withNum:number];
    [superView addSubview:pageControl];
    return pageControl;
}

- (instancetype)initWithFrame:(CGRect)frame withNum:(NSInteger)number{
    if (self = [super initWithFrame:frame]) {
        self.number = number;
        [self setUpView];
    }
    return self;
}

- (void)setUpView{
    for (int i = 0; i < self.number; i++) {
        UIView *controlPoint = [[UIView alloc] init];
        controlPoint.tag = 100 + i;
        controlPoint.layer.cornerRadius = 5;
        controlPoint.backgroundColor = [UIColor yellowColor];
        [self addSubview:controlPoint];
        CGFloat left = i * (10 + 8);
        [controlPoint mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(left));
            make.bottom.equalTo(@(-10));
            make.width.height.equalTo(@10);
        }];
    }
}

- (void)setSeletedPageControl:(NSInteger)pageNum{
    NSArray *array = self.subviews;
    [array enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger num = obj.tag;
        if (num-100 == pageNum) {
            obj.backgroundColor = [UIColor blueColor];
        }else{
            obj.backgroundColor = [UIColor yellowColor];
        }
    }];
}

@end
