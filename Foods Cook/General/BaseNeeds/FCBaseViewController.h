//
//  FCBaseViewController.h
//  Foods Cook
//
//  Created by 邓莎 on 2017/9/28.
//  Copyright © 2017年 邓莎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCBaseViewController : UIViewController
/***给导航栏添加按钮***/
- (void)addRightActionWithTitle:(NSString *)title;
- (void)rightBarButtonAction:(id)sender;
- (void)addRightActionWithImage:(NSString *)imageName;

/***实现subViews的布局***/
- (void)setUpViews;

/***加载视图***/
- (void)showLoadingView;
- (void)dismissLoadingView;
- (void)loadingFailedWithMessage:(NSString *)errMsg;

@end
