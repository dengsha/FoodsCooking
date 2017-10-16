//
//  FCHomePageViewController.m
//  Foods Cook
//
//  Created by 邓莎 on 2017/10/10.
//  Copyright © 2017年 邓莎. All rights reserved.
//

#import "FCHomePageViewController.h"
#import "FCSheetView.h"

@interface FCHomePageViewController ()

@end

@implementation FCHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"首页"];
    
    UIButton *bnt = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    bnt.backgroundColor = [UIColor blueColor];
    [bnt addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bnt];
    
}

- (void)jump:(id)sender{
    FCSheetView *sheet = [[FCSheetView alloc] initWithTitles:@[@"23",@"11"] cancleTitle:@"取消"];
    [self.view addSubview:sheet];
    [sheet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
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
