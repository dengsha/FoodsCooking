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

static NSString *const fAllDishesIdentifier = @"fAllDishesIdentifier";

@interface FCHomePageViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray<FCClassesOfDishesModel *> *dishesArray;

@end

@implementation FCHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"菜谱全集"];
    
    UIButton *bnt = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    bnt.backgroundColor = [UIColor blueColor];
    [bnt addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bnt];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self httpGetDishes];
}

#pragma mark lazyInit
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark private
- (void)jump:(id)sender{
//    // 获得NSURLSession对象
//    NSURLSession *session = [NSURLSession sharedSession];
//
//    // 创建请求
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@" "]];
//
//    // 设置请求方法
//    request.HTTPMethod = @"POST";
//
//    // 设置请求体
//    request.HTTPBody = [@" " dataUsingEncoding:NSUTF8StringEncoding];
//
//    // 创建任务
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSLog(@"data ~~~ %@ ~~~ response ~~~ %@ ~~~ error~~~ %@", data, response , error);
//    }];
//
//    // 启动任务
//    [task resume];
    
    
    
    
    
    
//    FCSheetView *sheet = [[FCSheetView alloc] initWithTitles:@[@"23",@"11"] cancleTitle:@"取消"];
//    [self.view addSubview:sheet];
//    [sheet mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
}

- (void)httpGetDishes{
    [[FCHttpNetRequest sharedNetRequest] postWithURLString:@"http://apis.juhe.cn/cook/category" parameters:@{@"parentid":@"10001"} success:^(id responseObject) {
        NSArray *result = responseObject[@"result"];
        NSDictionary *dic = result[0];
        
//        [result objectForKey:@"list"];
//        NSError *error = nil;
//        FCAllDishesModel *model = [[FCAllDishesModel alloc] initWithDictionary:result error:&error];
//        if (!error) {
//            NSLog(@"chengong");
//        }else{
//            NSLog(@"fail");
//        }
//        self.dishesArray = [NSArray arrayWithArray:model.list];
//        [self.tableView reloadData];
    } failture:^(NSError *error) {
        NSLog(@"失败");
    }];
}

#pragma mark UITableViewDelegate && UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dishesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:fAllDishesIdentifier];
    FCClassesOfDishesModel *model = self.dishesArray[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
