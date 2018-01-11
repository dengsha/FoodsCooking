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
@property (nonatomic, strong) UIButton *chooseButton;
@property (nonatomic, strong) UIImageView *chooseImage;

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
    
    UIImageView *chooseImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"uncheck"]];
    [self.contentView addSubview:chooseImage];
    [chooseImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(2));
        make.right.equalTo(@(-2));
        make.width.equalTo(@18);
        make.height.equalTo(@18);
    }];
    self.chooseImage = chooseImage;
    
    UIButton *chooseButton = [[UIButton alloc] init];
    [chooseButton addTarget:self action:@selector(makeChoose:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:chooseButton];
    [chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.contentView);
        make.width.equalTo(@35);
        make.height.equalTo(@35);
    }];
    self.chooseButton = chooseButton;
}

- (void)makeChoose:(UIButton *)button{
    self.chooseButton.selected = !self.chooseButton.selected;
    if (self.chooseButton.selected) {
        [self.chooseImage setImage:[UIImage imageNamed:@"check"]];
    }else{
        [self.chooseImage setImage:[UIImage imageNamed:@"uncheck"]];
    }
}

- (void)setCellWithPHAsset:(PHAsset *)asset{
    self.chooseButton.selected = NO;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeZero contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        self.imgView.image = result;
    }];
}

@end
