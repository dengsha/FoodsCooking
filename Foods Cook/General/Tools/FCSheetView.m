//
//  FCSheetView.m
//  Foods Cook
//
//  Created by 邓莎 on 2017/10/16.
//  Copyright © 2017年 邓莎. All rights reserved.
//

#import "FCSheetView.h"

@interface FCSheetView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UILabel *cancelLabel;
@property (nonatomic, strong)NSArray *titleArray;
@property (nonatomic, copy)NSString *cancelString;
@property (nonatomic, strong)UIView *contentView;

@end

@implementation FCSheetView

- (instancetype)initWithTitles:(NSArray *)titleArray cancleTitle:(NSString *)cancelString{
    if (self = [super init]) {
        self.titleArray = titleArray;
        self.cancelString = cancelString;
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews{
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.equalTo(@(40 + 20 + self.titleArray.count * 40 +30));
    }];
    
    [self.contentView addSubview:self.cancelLabel];
    [self.cancelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-15));
        make.left.equalTo(@15);
        make.right.equalTo(@(-15));
        make.height.equalTo(@(40));
    }];
    
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.cancelLabel.mas_top).offset(-20);
        make.left.equalTo(@15);
        make.right.equalTo(@(-15));
        make.height.equalTo(@(self.titleArray.count * 40));
    }];
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (UILabel *)cancelLabel{
    if (!_cancelLabel) {
        _cancelLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _cancelLabel.textAlignment = NSTextAlignmentCenter;
        _cancelLabel.text = self.cancelString;
    }
    return _cancelLabel;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

@end
