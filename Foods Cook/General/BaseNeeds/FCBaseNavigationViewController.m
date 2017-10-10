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
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
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
