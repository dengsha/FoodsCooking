//
//  FCBaseNavigationViewController.m
//  Foods Cook
//
//  Created by 邓莎 on 2017/10/10.
//  Copyright © 2017年 邓莎. All rights reserved.
//

#import "FCBaseNavigationViewController.h"

@interface FCBaseNavigationViewController ()

@end

@implementation FCBaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ColorWithValue(ThemColor),NSFontAttributeName:[UIFont systemFontOfSize:18]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
