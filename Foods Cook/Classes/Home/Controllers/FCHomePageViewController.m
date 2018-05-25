//
//  FCHomePageViewController.m
//  Foods Cook
//
//  Created by 邓莎 on 2017/10/10.
//  Copyright © 2017年 邓莎. All rights reserved.
//

#import "FCHomePageViewController.h"
#import "FCSheetView.h"
#import "AFHTTPRequestOperationManager.h"
#import "FCHttpNetRequest.h"
#import "FCAllDishesModel.h"
#import "WeakTimer.h"
#import "GCDTestViewController.h"

static NSString *const fAllDishesIdentifier = @"fAllDishesIdentifier";

@interface FCHomePageViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray<FCClassesOfDishesModel *> *dishesArray;
@property (nonatomic, strong)NSArray *array;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation FCHomePageViewController

- (void)dealloc{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"菜谱全集"];
    
//    UIButton *bnt = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
//    bnt.backgroundColor = [UIColor blueColor];
//    [bnt addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:bnt];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    gesture.minimumPressDuration = 3;
    [self.tableView addGestureRecognizer:gesture];
//    [self httpGetDishes];
    
    
//    self.timer = [WeakTimer scheduledTimerWithTimerInterval:2 target:self selector:@selector(test) userInfo:nil repeats:NO];
}

- (void)longPressAction:(UILongPressGestureRecognizer *)gesture{
    CGPoint point = [gesture locationInView:gesture.view];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    if (!indexPath) {
        return;
    }
    
}

#pragma mark lazyInit
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = ColorWithValue(0xf2f2f2);
//        [_tableView setEditing:YES animated:YES];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:fAllDishesIdentifier];
    }
    return _tableView;
}

- (NSArray *)array{
    if (!_array) {
        _array = @[@"CGCDTest",@"HTTP"];
    }
    return _array;
}

#pragma mark private
- (void)test{
    NSLog(@"12434");
}

- (void)httpGetDishes{
    [[FCHttpNetRequest sharedNetRequest] postWithURLString:@"http://apis.juhe.cn/cook/category" parameters:@{@"parentid":@"10001"} success:^(id responseObject) {
        NSArray *result = responseObject[@"result"];
        NSDictionary *dic = result[0];
        NSError *error = nil;
        FCAllDishesModel *model = [[FCAllDishesModel alloc] initWithDictionary:dic error:&error];
        if (!error) {
            NSLog(@"chengong");
        }else{
            NSLog(@"fail");
        }
        self.dishesArray = [NSArray arrayWithArray:model.list];
        [self.tableView reloadData];
    } failture:^(NSError *error) {
        NSLog(@"失败");
    }];
}

#pragma mark UITableViewDelegate && UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dishesArray.count;
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:fAllDishesIdentifier];
//    FCClassesOfDishesModel *model = self.dishesArray[indexPath.row];
    NSString *test = self.array[indexPath.row];
    cell.textLabel.text = test;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            GCDTestViewController *vc = [[GCDTestViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            
        }
            break;
            
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"test";
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewCellEditingStyleNone;
//}
//
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
//    NSString *content = self.array[sourceIndexPath.row];
//    NSMutableArray *mulArray = self.array.mutableCopy;
//    [mulArray removeObject:content];
//    [mulArray insertObject:content atIndex:destinationIndexPath.row];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
