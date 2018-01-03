//
//  FCDetailStepViewController.m
//  Foods Cook
//
//  Created by 邓莎 on 2018/1/2.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import "FCDetailStepViewController.h"
#import "WeakTimer.h"

@interface FCDetailStepViewController ()
///纵向轮播
@property (nonatomic, strong) UIScrollView *scrollView;
///倒计时
@property (nonatomic, strong) WeakTimer *timer;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label1;

@end

@implementation FCDetailStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 0;
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    
    
    UIView *view1 = [[UIView alloc] init];
    [self.scrollView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@0);
        make.height.equalTo(@40);
    }];
    
    UILabel *label1 = [[UILabel alloc] init];
    [label1 setText:@"123"];
    [label1 setTextColor:ColorWithValue(ThemColor)];
    [view1 addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.centerY.equalTo(view1.mas_centerY);
    }];
    self.label1 = label1;
    
    UIButton *button1 = [[UIButton alloc] init];
    [button1 addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view1);
    }];
    
    UIView *view2 = [[UIView alloc] init];
    [self.scrollView addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@40);
        make.height.equalTo(@40);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    [label2 setTextColor:ColorWithValue(ThemColor)];
    [view2 addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.centerY.equalTo(view2.mas_centerY);
    }];
    self.label2 = label2;
    
    UIButton *button2 = [[UIButton alloc] init];
    [button2 addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view2);
    }];
    
    [WeakTimer scheduledTimerWithTimerInterval:2 target:self selector:@selector(timeCut) userInfo:nil repeats:YES];
}

- (void)touch:(id)sender{
    NSLog(@"%ld",(long)self.count);
}

- (void)loadData{
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
    NSArray *array = @[@"123",@"098",@"567"];
    NSInteger num;
    if (self.count < 0) {
        num = self.count + 1;
    }else{
        num = self.count;
    }
    self.label1.text = array[num];
}

- (void)timeCut{
    self.count ++;
    NSArray *array = @[@"123",@"098",@"567"];
    self.label2.text = array[self.count];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.scrollView setContentOffset:CGPointMake(0, 40)];
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf loadData];
        if (strongSelf.count == 2) {
            strongSelf.count = -1;
        }
    }];
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.contentSize = CGSizeMake(0, 40 * 3);
        _scrollView.backgroundColor = [UIColor yellowColor];
    }
    return _scrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
