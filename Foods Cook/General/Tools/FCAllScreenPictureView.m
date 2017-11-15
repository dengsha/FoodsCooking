//
//  FCAllScreenPictureView.m
//  Foods Cook
//
//  Created by 邓莎 on 2017/10/30.
//  Copyright © 2017年 邓莎. All rights reserved.
//

#import "FCAllScreenPictureView.h"

@interface FCAllScreenPictureView()

@property (nonatomic, strong)UIImage *image;
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, assign)CGFloat totalScale;

@end

@implementation FCAllScreenPictureView

- (instancetype)initWithImage:(UIImage *)image{
    if (self = [super init]) {
        [self setFrame:[UIScreen mainScreen].bounds];
        self.image = image;
        [self setUpView];
    }
    return self;
}

- (void)setUpView{
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setImage:self.image];
    self.imageView = imageView;
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    /*-------------单击手势-------------*/
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    [imageView addGestureRecognizer:tapgesture];
    
    /*-------------缩放手势-------------*/
    UIPinchGestureRecognizer *pinGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinAction:)];
    [imageView addGestureRecognizer:pinGesture];
    self.totalScale = 1.0;
    
    /*-------------双击手势-------------*/
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleAction:)];
    doubleTap.numberOfTapsRequired = 2;
    [imageView addGestureRecognizer:doubleTap];
//    self.doubleGesture = doubleTap;
    
    /*-------------拖移手势-------------*/
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [imageView addGestureRecognizer:panGesture];
/**
 显示

 @return
 */
}
- (void)show{
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

/**
 缩放

 @param gesture gesture
 */
- (void)panAction:(UIPanGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateChanged) {
        UIImageView *imageView = (UIImageView *)gesture.view;
        UIView *backView = imageView.superview;
        CGPoint point = [gesture translationInView:backView];
        self.imageView.transform = CGAffineTransformMakeTranslation(point.x, point.y);
    }else if (gesture.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:1 animations:^{
            self.imageView.transform = CGAffineTransformIdentity;
        }];
    }
}

/**
 退出全屏

 @param gesture gesture
 */
- (void)doubleAction:(UITapGestureRecognizer *)gesture{
    UIImageView *imageView = (UIImageView *)gesture.view;
    UIView *backView = imageView.superview;
    [UIView transitionWithView:backView duration:0.3 options:UIViewAnimationOptionCurveLinear animations:^{
        backView.alpha = 0;
    } completion:^(BOOL finished) {
        [backView removeFromSuperview];
    }];
}

/**
 图片还原

 @param gesture gesture
 */
- (void)backAction:(UITapGestureRecognizer *)gesture{
    //    if (self.doubleGesture.state == UIGestureRecognizerStateBegan) {
    //        return;
    //    }
    
    [UIView animateWithDuration:1 animations:^{
        self.imageView.transform = CGAffineTransformIdentity;
    }];
    self.totalScale = 1.0;
}

/**
 拖移手势

 @param gesture gesture
 */
- (void)pinAction:(UIPinchGestureRecognizer *)gesture{
    CGFloat max = 3;
    CGFloat min = 0.2;
    CGFloat scale = gesture.scale;
    if (scale > 1) {
        if (self.totalScale > max || scale > max) {
            return;
        }
    }
    
    if (scale < 1) {
        if (self.totalScale < min || scale < min) {
            return;
        }
    }
    
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, scale, scale);
    
    self.totalScale *= scale;
    //    gesture.scale = 1.0;
}

@end
