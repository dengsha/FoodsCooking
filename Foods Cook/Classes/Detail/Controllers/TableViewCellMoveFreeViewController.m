//
//  TableViewCellMoveFreeViewController.m
//  Foods Cook
//
//  Created by 邓莎 on 2018/5/29.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import "TableViewCellMoveFreeViewController.h"
#import "masonry.h"

static NSString *const cellIdentifier = @"cell";

@interface TableViewCellMoveFreeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableArray *pointArray;
@property (nonatomic, strong)NSIndexPath *originIndexpath;
@property (nonatomic, strong)UIView *cellView;

@end

@implementation TableViewCellMoveFreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"tableViewCell拖动"];
    NSArray *array1 = @[@"Apple", @"Pear", @"Balana", @"Stradrawbabry"];
    NSArray *array2 = @[@"Dog", @"Pig", @"Elephant", @"cat", @"ant"];
    self.dataArray = [NSMutableArray arrayWithObjects:array1,array2, nil];
//    self.dataArray = @[array1, array2];
    self.pointArray = [NSMutableArray array];
}

- (void)setUpViews{
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
        UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(cellMoveAction:)];
        gesture.minimumPressDuration = 2;
        [_tableView addGestureRecognizer:gesture];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.dataArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    NSArray *array = self.dataArray[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = array[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

#pragma mark private
- (void)cellMoveAction:(UILongPressGestureRecognizer *)gesture{
    CGPoint location = [gesture locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    UIGestureRecognizerState state = gesture.state;
    switch (state) {
        case UIGestureRecognizerStateBegan:{
            if (indexPath) {
                ///记录初始移动的cell的indexPath
                self.originIndexpath = indexPath;
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                ///绘制cell的图片
                self.cellView = [self getCellView:cell];
                __block CGPoint center = cell.center;
                self.cellView.center = center;
                [self.tableView addSubview:self.cellView];
                
                [UIView animateWithDuration:0.3 animations:^{
                    center.y = location.y;
                    self.cellView.center = center;
                    self.cellView.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    self.cellView.alpha = 0.98;
                    cell.alpha = 0.0;
                } completion:^(BOOL finished) {
                    [cell setHidden:YES];
                }];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:{
            [self.pointArray addObject:[NSValue valueWithCGPoint:location]];
            if (self.pointArray.count > 2) {
                [self.pointArray removeObjectAtIndex:0];
            }
            CGPoint center = self.cellView.center;
            // 快照随触摸点y值移动（当然也可以根据触摸点的y轴移动量来移动）
            center.y = location.y;
            // 快照随触摸点x值改变量移动
            CGPoint Ppoint = [[self.pointArray firstObject] CGPointValue];
            CGPoint Npoint = [[self.pointArray lastObject] CGPointValue];
            CGFloat moveX = Npoint.x - Ppoint.x;
            center.x += moveX;
            self.cellView.center = center;
            if (indexPath && ![indexPath isEqual:self.originIndexpath]) {
                if (indexPath.section == self.originIndexpath.section) {
                    NSArray *array = self.dataArray[indexPath.section];
                    [array.mutableCopy exchangeObjectAtIndex:
                     indexPath.row withObjectAtIndex:self.originIndexpath.row];
                    // 把cell移动至指定行
                    [self.tableView moveRowAtIndexPath:self.originIndexpath toIndexPath:indexPath];
                }else{
                    ///移动前位置
                    NSArray *array_before = self.dataArray[self.originIndexpath.section];
                    NSString *string_before = array_before[self.originIndexpath.row];
                    ///移动后位置
                    NSArray *array_after = self.dataArray[indexPath.section];
                    NSString *string_after = array_after[indexPath.row];
                    ///更新数据源
                    [array_before.mutableCopy replaceObjectAtIndex:self.originIndexpath.row withObject:string_after];
                    [array_after.mutableCopy replaceObjectAtIndex:indexPath.row withObject:string_before];
                    ///如果我们的UITableView是分组的时候，我们如果删除某个分组的最后一条记录时，相应的分组也将被删除。所以，必须保证UITableView的分组，和cell同时被删除。
                    [self.tableView beginUpdates];
                    [self.tableView moveRowAtIndexPath:self.originIndexpath toIndexPath:indexPath];
                    [self.tableView moveRowAtIndexPath:indexPath toIndexPath:self.originIndexpath];
                    [self.tableView endUpdates];
                }
                // 存储改变后indexPath的值，以便下次比较
                self.originIndexpath = indexPath;
            }
        }
            break;
            
        default:{
            // 清除操作
            // 清空数组，非常重要，不然会发生坐标突变！
            [self.pointArray removeAllObjects];
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.originIndexpath];
            cell.hidden = NO;
            cell.alpha = 0.0;
            // 将快照恢复到初始状态
            [UIView animateWithDuration:0.25 animations:^{
                self.cellView.center = cell.center;
                self.cellView.transform = CGAffineTransformIdentity;
                self.cellView.alpha = 0.0;
                cell.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                self.originIndexpath = nil;
                [self.cellView removeFromSuperview];
                self.cellView = nil;
            }];
        }
            break;
    }
}

///绘制cell图
- (UIView *)getCellView:(UIView *)cell{
    UIGraphicsBeginImageContextWithOptions(cell.frame.size, NO, [UIScreen mainScreen].scale);
    [cell.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIView *finalView = [[UIImageView alloc] initWithImage:img];
    finalView.layer.shadowColor = [UIColor blackColor].CGColor;
    finalView.layer.shadowOffset = CGSizeMake(1, 2);
    return finalView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
