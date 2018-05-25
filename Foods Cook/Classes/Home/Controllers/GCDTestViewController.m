//
//  GCDTestViewController.m
//  Foods Cook
//
//  Created by 邓莎 on 2018/5/17.
//  Copyright © 2018年 邓莎. All rights reserved.
//

static NSString *const fCellIdentifier = @"cell";

#import "GCDTestViewController.h"
#import "masonry.h"

@interface GCDTestViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, copy)NSArray *dataArray;

@end

@implementation GCDTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@"异步串行",@"同步串行",@"异步并行",@"同步并行",@"主队列异步",@"同时进行"];
    [self setTitle:@"GCDTest"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:fCellIdentifier];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:fCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            [self testGCD_1];
        }
            break;
        case 1:{
           [self testGCD_2];
        }
            break;
        case 2:{
            [self testGCD_3];
        }
            break;
        case 3:{
            [self testGCD_4];
        }
            break;
        case 4:{
            [self testGCD_main];
        }
            break;
        case 5:{
            [self testGCD_1];
            [self testGCD_2];
            [self testGCD_3];
            [self testGCD_4];
            [self testGCD_main];
        }
            break;
            
        default:
            break;
    }
}

///异步串行
- (void)testGCD_1{
    NSLog(@"main testGCD_1 1");
    dispatch_queue_t globalQueue = dispatch_queue_create("serialQ", DISPATCH_QUEUE_SERIAL);
    dispatch_async(globalQueue, ^{
        NSLog(@"A serialQ_1");
        NSLog(@"#1 %@",[NSThread currentThread]);
    });
    dispatch_async(globalQueue, ^{
        NSLog(@"B serialQ_1");
        NSLog(@"#2 %@",[NSThread currentThread]);
    });
    dispatch_async(globalQueue, ^{
        NSLog(@"C serialQ_1");
        NSLog(@"#3 %@",[NSThread currentThread]);
    });
    NSLog(@"main testGCD_1 2");
}

///同步串行
- (void)testGCD_2{
    NSLog(@"main testGCD_2 1");
    dispatch_queue_t globalQueue = dispatch_queue_create("serialQ", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(globalQueue, ^{
        NSLog(@"serialQ_2 1");
        NSLog(@"#1 %@",[NSThread currentThread]);
    });
    dispatch_sync(globalQueue, ^{
        NSLog(@"serialQ_2 2");
        NSLog(@"#2 %@",[NSThread currentThread]);
    });
    dispatch_sync(globalQueue, ^{
        NSLog(@"serialQ_2 3");
        NSLog(@"#3 %@",[NSThread currentThread]);
    });
    dispatch_sync(globalQueue, ^{
        NSLog(@"serialQ_2 4");
        NSLog(@"#4 %@",[NSThread currentThread]);
    });
    NSLog(@"main testGCD_2 2");
}

///异步并行
- (void)testGCD_3{
    NSLog(@"main testGCD_3 1");
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(quene, ^{
        NSLog(@"A serialQ_3");
        NSLog(@"#1 %@",[NSThread currentThread]);
        NSLog(@"## %@",[NSThread mainThread]);
    });
    dispatch_async(quene, ^{
        NSLog(@"B serialQ_3");
        NSLog(@"#2 %@",[NSThread currentThread]);
    });
    dispatch_async(quene, ^{
        NSLog(@"C serialQ_3");
        NSLog(@"#3 %@",[NSThread currentThread]);
    });
    NSLog(@"main testGCD_3 2");
}

///同步并行
- (void)testGCD_4{
    NSLog(@"main testGCD_3 1");
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_sync(quene, ^{
        NSLog(@"A serialQ_3");
        NSLog(@"#1 %@",[NSThread currentThread]);
        NSLog(@"## %@",[NSThread mainThread]);
    });
    dispatch_sync(quene, ^{
        NSLog(@"B serialQ_3");
        NSLog(@"#2 %@",[NSThread currentThread]);
    });
    dispatch_sync(quene, ^{
        NSLog(@"C serialQ_3");
        NSLog(@"#3 %@",[NSThread currentThread]);
    });
    NSLog(@"main testGCD_3 2");
}

- (void)testGCD_main{
    NSLog(@"GCD_main 1");
    dispatch_queue_t quene = dispatch_get_main_queue();
    dispatch_async(quene, ^{
        NSLog(@"A serialQ_main");
        NSLog(@"#1 %@",[NSThread currentThread]);
        NSLog(@"## %@",[NSThread mainThread]);
    });
    dispatch_async(quene, ^{
        NSLog(@"B serialQ_main");
        NSLog(@"#2 %@",[NSThread currentThread]);
    });
    dispatch_async(quene, ^{
        NSLog(@"C serialQ_main");
        NSLog(@"#3 %@",[NSThread currentThread]);
    });
    NSLog(@"GCD_main 2");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 异步开启新线程，异步串行（开启1条），异步主线程没有开启新的线程。除异步并行，人物并行执行外，其他的都串行执行。异步串行会先执行主线程的代码，再执行block子线程的代码。
 同步不开启新线程，都是串行执行任务，即等block里的人物完成后才会执行下一步。
 */

@end
