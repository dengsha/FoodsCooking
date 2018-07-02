//
//  CarouselCollectionViewCell.m
//  Foods Cook
//
//  Created by 邓莎 on 2018/5/30.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import "CarouselCollectionViewCell.h"
#import "masonry.h"

@interface CarouselCollectionViewCell()

@property (nonatomic, strong)UIImageView *imageView;

@end

@implementation CarouselCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}

- (void)setUpView{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = YES;
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    self.imageView = imageView;
}

- (void)setImgString:(NSString *)imgString{
    UIImage *img = [UIImage imageNamed:imgString];
    self.imageView.image = img;
}

@end
