//
//  FCDetailStepViewController.m
//  Foods Cook
//
//  Created by 邓莎 on 2018/1/2.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import "FCDetailStepViewController.h"
#import "WeakTimer.h"
#import "FCDrectionCarouselView.h"
#import "MoveScrollView.h"

@interface FCDetailStepViewController ()<FCDrectionCarouselViewDelegate, MoveScrollViewDelegate>
///纵向轮播
@property (nonatomic, strong) UIScrollView *scrollView;
///倒计时
@property (nonatomic, strong) WeakTimer *timer;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, copy) NSArray *array;
@property (nonatomic, assign) NSInteger mark;

@property (nonatomic, strong) MoveScrollView *moveView;

@end

@implementation FCDetailStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FCDrectionCarouselView *carouselView = [[FCDrectionCarouselView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    carouselView.delegate = self;
    [carouselView setDataWithArray:@[@"342",@"1111",@"0809",@"325436"]];
    [self.view addSubview:carouselView];
    
    MoveScrollView *move = [[MoveScrollView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50) withDataArray:@[@"重庆",@"成都",@"长沙",@"北京",@"杭州",@"天津"]];
    move.delegate = self;
    [self.view addSubview:move];
}

#pragma mark FCDrectionCarouselViewDelegate

- (void)crouselViewDidSelectIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);
}

- (void)didSelectedWithIndex:(NSInteger)index{
    NSLog(@"横滑%ld",(long)index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
