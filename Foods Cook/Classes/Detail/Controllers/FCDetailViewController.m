//
//  FCDetailViewController.m
//  Foods Cook
//
//  Created by 邓莎 on 2017/10/10.
//  Copyright © 2017年 邓莎. All rights reserved.
//

#import "FCDetailViewController.h"
#import "FCAllScreenPictureView.h"
#import "FCHttpNetRequest.h"
#import "FCDetailStepViewController.h"
#import <Photos/Photos.h>
#import "PhotoAlbumViewController.h"

@interface FCDetailViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, assign)CGFloat totalScale;
@property (nonatomic, strong)UITapGestureRecognizer *doubleGesture;

@end

@implementation FCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"详情"];
}

- (void)setUpViews{
    UIButton *button1 = [[UIButton alloc] init];
    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
        make.left.equalTo(@10);
        make.width.equalTo(@60);
        make.height.equalTo(@40);
    }];
    button1.backgroundColor = [UIColor redColor];
    [button1 addTarget:self action:@selector(button1:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [[UIButton alloc] init];
    [self.view addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
        make.left.equalTo(button1.mas_right).offset(10);
        make.width.equalTo(@60);
        make.height.equalTo(@40);
    }];
    button2.backgroundColor = [UIColor blueColor];
    [button2 addTarget:self action:@selector(button2:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"花"]];
//    [self.view addSubview:imageView];
//    CGSize size = [UIImage imageNamed:@"花"].size;
//    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@(size.width/2.0));
//        make.height.equalTo(@(size.height/2.0));
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.centerY.equalTo(self.view.mas_centerY);
//    }];
//
//    imageView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigAction:)];
//    gesture.numberOfTapsRequired = 2;
//    [imageView addGestureRecognizer:gesture];
}

- (void)button1:(id)sender{
//    FCHttpNetRequest *request = [FCHttpNetRequest sharedNetRequest];
//    NSLog(@"%p",request);
    FCDetailStepViewController *vc = [[FCDetailStepViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)button2:(id)sender{
//    FCHttpNetRequest *request = [FCHttpNetRequest sharedNetRequest];
//    NSLog(@"%p",request);
    
    ///系统相册
//    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//        return;
//    }else{
//        UIImagePickerController *pic = [[UIImagePickerController alloc] init];
//        pic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        pic.delegate = self;
//        [self presentViewController:pic animated:YES completion:nil];
//    }
    
    PhotoAlbumViewController *vc = [[PhotoAlbumViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)bigAction:(UITapGestureRecognizer *)gesture{
    FCAllScreenPictureView *backView = [[FCAllScreenPictureView alloc] initWithImage:[UIImage imageNamed:@"花"]];
    [backView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
