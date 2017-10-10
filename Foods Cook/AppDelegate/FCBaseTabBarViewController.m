//
//  FCBaseTabBarViewController.m
//  Foods Cook
//
//  Created by 邓莎 on 2017/10/10.
//  Copyright © 2017年 邓莎. All rights reserved.
//

#import "FCBaseTabBarViewController.h"
#import "FCDetailViewController.h"
#import "FCMyMessageViewController.h"
#import "FCHomePageViewController.h"
#import "FCBaseNavigationViewController.h"

@interface FCBaseTabBarViewController ()

@end

@implementation FCBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -3)];
//    [[UITabBar appearance] setShadowImage:[UIImage new]];
//    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    FCHomePageViewController *homeVC = [[FCHomePageViewController alloc] init];
    [self addChildViewController:homeVC image:@"home" selectImage:@"home_select" itemTitle:@"首页"];
    FCDetailViewController *detailVC = [[FCDetailViewController alloc] init];
    [self addChildViewController:detailVC image:@"message" selectImage:@"message_select" itemTitle:@"详情"];
    FCMyMessageViewController *mineVC = [[FCMyMessageViewController alloc] init];
    [self addChildViewController:mineVC image:@"mine" selectImage:@"mine_select" itemTitle:@"我的"];
}

- (void)addChildViewController:(UIViewController *)childViewController image:(NSString *)image selectImage:(NSString *)selectImage itemTitle:(NSString *)title{
    UIImage *normalImage = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    FCBaseNavigationViewController *nav = [[FCBaseNavigationViewController alloc] initWithRootViewController:childViewController];
    nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:selectedImage];
    [self addChildViewController:nav];
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
