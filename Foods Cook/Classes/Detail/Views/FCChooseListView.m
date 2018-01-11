//
//  FCChooseListView.m
//  Foods Cook
//
//  Created by 邓莎 on 2018/1/11.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import "FCChooseListView.h"

@interface FCChooseListView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *chooseView;

@end

@implementation FCChooseListView

- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        [self setSubViews];
    }
    return self;
}

- (void)setSubViews{
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.3;
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)];
    backView.userInteractionEnabled = YES;
    [backView addGestureRecognizer:gesture];
    
    UIView *chooseView = [[UIView alloc] init];
//    chooseView.backgroundColor = [UIColor whiteColor];
    [self addSubview:chooseView];
    [chooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.height.equalTo(@110);
        make.width.equalTo(@135);
        make.left.equalTo (@0);
    }];
    self.chooseView = chooseView;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"弹窗"]];
    [chooseView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(chooseView);
    }];
    
    [chooseView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(chooseView);
        make.top.equalTo(@10);
    }];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *content = self.dataAray[indexPath.row];
    cell.textLabel.text = content;
    return cell;
}

- (void)setListLeft:(CGFloat)left top:(CGFloat)top{
    [self.chooseView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(left));
        make.top.equalTo(@(top));
    }];
}

- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)hidden{
    if (!self.isHidden) {
        [self removeFromSuperview];
    }
}

@end
