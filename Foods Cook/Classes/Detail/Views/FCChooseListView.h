//
//  FCChooseListView.h
//  Foods Cook
//
//  Created by 邓莎 on 2018/1/11.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCChooseListView : UIView

@property (nonatomic, copy) NSArray *dataAray;

- (void)setListLeft:(CGFloat)left top:(CGFloat)top;

- (void)show;
- (void)hidden;

@end
