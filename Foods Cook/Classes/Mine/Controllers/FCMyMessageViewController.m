//
//  FCMyMessageViewController.m
//  Foods Cook
//
//  Created by 邓莎 on 2017/10/10.
//  Copyright © 2017年 邓莎. All rights reserved.
//

#import "FCMyMessageViewController.h"

@interface FCMyMessageViewController ()

@end

@implementation FCMyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"收藏"];
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = rect;
    emitter.emitterMode =  kCAEmitterLayerVolume;
    emitter.emitterShape = kCAEmitterLayerPoint;
//    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = CGPointMake(rect.size.width/2.0, 400);
    emitter.emitterSize = rect.size;//CGSizeMake(20, 20);
    [self.view.layer addSublayer:emitter];
    
    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
//    emitterCell.contentsRect = CGRectMake(0, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    emitterCell.contents = (__bridge id _Nullable)[UIImage imageNamed:@"实心收藏"].CGImage;
//    emitterCell.color = [UIColor redColor].CGColor;
    emitterCell.birthRate = 8;
    emitterCell.lifetime = 4;
//    emitterCell.scaleRange = 0.8;
//    emitterCell.scaleSpeed = -0.05;
//    // 制造一个y轴的加速度
//    emitterCell.yAcceleration = 70.0;
//    // 制造一个x轴的加速度
//    emitterCell.xAcceleration = 10.0;
//    //设置粒子透明度的变化范围
//    emitterCell.alphaRange = 0.5;
    
    emitterCell.lifetimeRange=1.5;
    emitterCell.velocity=160;
    emitterCell.velocityRange=80;
    emitterCell.emissionLongitude=M_PI+M_PI_2;
    emitterCell.emissionRange= M_PI_2;
    emitterCell.scaleSpeed=0.3;
//    emitterCell.spin=0.2;
    
    emitter.emitterCells = @[emitterCell];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
