//
//  PhotoDetailCollectionViewCell.m
//  Foods Cook
//
//  Created by 邓莎 on 2018/1/9.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import "PhotoDetailCollectionViewCell.h"
#import <Photos/Photos.h>

@interface PhotoDetailCollectionViewCell()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation PhotoDetailCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setSubViews];
    }
    return self;
}

- (void)setSubViews{
    UIImageView *imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    self.imgView = imgView;
}

- (void)setCellWithPHAsset:(PHAsset *)asset{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeZero contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        self.imgView.image = result;
    }];
}

@end
