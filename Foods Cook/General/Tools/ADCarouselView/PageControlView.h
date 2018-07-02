//
//  PageControlView.h
//  Foods Cook
//
//  Created by 邓莎 on 2018/5/30.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageControlView : UIView

+ (PageControlView *)pageControlViewWithNumber:(NSInteger)number superView:(UIView *)superView;

- (void)setSeletedPageControl:(NSInteger)pageNum;

@end
