//
//  ADCarouselViewController.m
//  Foods Cook
//
//  Created by 邓莎 on 2018/5/29.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import "ADCarouselViewController.h"
#import "masonry.h"
#import "CarouselView.h"

@interface ADCarouselViewController ()

@property (nonatomic, strong)CarouselView *carouselView;

@end

@implementation ADCarouselViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"轮播器"];
}

- (void)setUpViews{
//    self.carouselView = [CarouselView carouselViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    self.carouselView = [[CarouselView alloc] init];
    [self.view addSubview:self.carouselView];
    [self.carouselView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
        make.height.equalTo(@200);
    }];
}

//- (CarouselView *)carouselView{
//    if (!_carouselView) {
//        _carouselView = [[CarouselView alloc] init];
//    }
//    return _carouselView;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
