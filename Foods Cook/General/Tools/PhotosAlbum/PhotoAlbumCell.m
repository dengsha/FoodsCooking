//
//  PhotoAlbumCell.m
//  Foods Cook
//
//  Created by 邓莎 on 2018/1/9.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import "PhotoAlbumCell.h"

@interface PhotoAlbumCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *numLabel;

@end

@implementation PhotoAlbumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubViews];
    }
    return self;
}

- (void)setSubViews{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    self.imgView = imageView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    [nameLabel setTextColor:ColorWithValue(BlackTextColor)];
    [nameLabel setFont:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(10);
        make.top.equalTo(imageView.mas_top);
    }];
    self.nameLabel = nameLabel;
    
    UILabel *numLabel = [[UILabel alloc] init];
    [numLabel setTextColor:ColorWithValue(BlackTextColor)];
    [numLabel setFont:[UIFont systemFontOfSize:12]];
    [self.contentView addSubview:numLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(10);
        make.bottom.equalTo(imageView.mas_bottom);
    }];
    self.numLabel = numLabel;
}

- (void)setCellWithCollection:(PHAssetCollection *)collection{
    [self.nameLabel setText:collection.localizedTitle];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    PHAsset *asset = assets.firstObject;
    CGSize size = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        self.imgView.image = result;
    }];
    
    [self.numLabel setText:[NSString stringWithFormat:@"%ld",(long)assets.count]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
