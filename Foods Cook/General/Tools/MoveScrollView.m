//
//  MoveScrollView.m
//  Foods Cook
//
//  Created by 邓莎 on 2018/1/8.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import "MoveScrollView.h"

@interface MoveScrollView ()

@property (nonatomic, strong) UIScrollView *scrollVeiw;

@property (nonatomic, assign) NSInteger mark;

@end

@implementation MoveScrollView

- (instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)array{
    if (self = [super initWithFrame:frame]) {
        self.dataArray = array;
        
        self.backgroundColor = [UIColor whiteColor];
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        self.scrollVeiw = scrollView;
        [scrollView setShowsHorizontalScrollIndicator:NO];
        scrollView.contentSize = CGSizeMake(100 * array.count, CGRectGetHeight(frame));
        [self addSubview:scrollView];
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        for (int i = 0; i < self.dataArray.count; i++) {
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(i * 100, 0, 100, CGRectGetHeight(frame))];
            backView.backgroundColor = [UIColor whiteColor];
            backView.tag = 100+i;
            [scrollView addSubview:backView];
            
            UIView *line_view = [[UIView alloc] init];
            line_view.backgroundColor = ColorWithValue(ThemColor);
            [backView addSubview:line_view];
            [line_view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@20);
                make.right.equalTo(@(-20));
                make.height.equalTo(@1);
                make.bottom.equalTo(@0);
            }];
            [line_view setHidden:YES];
            line_view.tag = 200+i;
            
            UILabel *label = [[UILabel alloc] init];
            label.text = self.dataArray[i];
            label.textColor = ColorWithValue(BlackTextColor);
            label.textAlignment = NSTextAlignmentCenter;
            [backView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(backView);
            }];
            label.tag = 300+i;
            
            UIButton *button = [[UIButton alloc] init];
            button.tag = i;
            [button addTarget:self action:@selector(touchInside:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(backView);
            }];
            
            if (i == 0) {
                [line_view setHidden:NO];
                [label setTextColor:ColorWithValue(ThemColor)];
            }
        }
    }
    return self;
}

- (void)setDefaultIndex:(NSInteger)defaultIndex{
    _defaultIndex = defaultIndex;
    if (defaultIndex && defaultIndex != 0) {
        UIView *backView = [self.scrollVeiw viewWithTag:defaultIndex + 100];
        UIView *lineView = [backView viewWithTag:defaultIndex + 200];
        UILabel *label = [backView viewWithTag:defaultIndex + 300];
        label.textColor = ColorWithValue(ThemColor);
        [lineView setHidden:NO];
        
        UIView *backView_default = [self.scrollVeiw viewWithTag:0 + 100];
        UIView *lineView_default = [backView_default viewWithTag:0 + 200];
        UILabel *label_default = [backView_default viewWithTag:0 + 300];
        [lineView_default setHidden:YES];
        [label_default setTextColor:ColorWithValue(BlackTextColor)];
    }
    self.mark = defaultIndex;
}

- (void)touchInside:(UIButton *)button{
    NSInteger tag = button.tag;
    if (!self.mark) {
        self.mark = 0;
    }
    if (self.mark == tag) {
        return;
    }
    UIView *view_old = [self.scrollVeiw viewWithTag:self.mark + 100];
    UIView *lineView_old = [view_old viewWithTag:self.mark + 200];
    UILabel *label_old = [view_old viewWithTag:self.mark + 300];
    [label_old setTextColor:ColorWithValue(BlackTextColor)];
    
    UIView *view_new = [self.scrollVeiw viewWithTag:tag + 100];
    UIView *lineView_new = [view_new viewWithTag:tag + 200];
    UILabel *label_new = [view_new viewWithTag:tag + 300];
    [label_new setTextColor:ColorWithValue(ThemColor)];
    
    [UIView animateWithDuration:0.4 animations:^{
        [lineView_old setHidden:YES];
        [lineView_new setHidden:NO];
    } completion:^(BOOL finished) {
        self.mark = tag;
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedWithIndex:)]) {
        [self.delegate didSelectedWithIndex:tag];
    }
}

@end
