//
//  FCWindowViewController.m
//  Foods Cook
//
//  Created by 邓莎 on 2018/6/8.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import "FCWindowViewController.h"
#import "masonry.h"

static NSString *const cellIdentifier = @"cellIdentifier";

@interface FCWindowViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, copy)NSArray *dataArray;

@end

#pragma mark - Life Cycle
@implementation FCWindowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@"毛玻璃效果",@"半透明效果"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    NSString *str = self.dataArray[indexPath.row];
    cell.textLabel.text = str;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
