//
//  FCBaseViewController.m
//  Foods Cook
//
//  Created by 邓莎 on 2017/9/28.
//  Copyright © 2017年 邓莎. All rights reserved.
//

#import "FCBaseViewController.h"

@interface FCBaseViewController ()

@end

@implementation FCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
    self.view.backgroundColor = ColorWithValue(0xf2f2f2);
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)setUpViews {
    
}

#pragma mark UINavigation Setting
- (void)addRightActionWithTitle:(NSString *)title{
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction:)];
    [buttonItem setTintColor:ColorWithValue(0x1b8bff)];
    self.navigationItem.rightBarButtonItem = buttonItem;
}

- (void)rightBarButtonAction:(id)sender{
    
}

- (void)addRightActionWithImage:(NSString *)imageName{
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageName] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction:)];
    self.navigationItem.rightBarButtonItem = buttonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showLoadingView{
    
}

- (void)dismissLoadingView{
    
}

- (void)loadingFailedWithMessage:(NSString *)errMsg{
    
}

@end
