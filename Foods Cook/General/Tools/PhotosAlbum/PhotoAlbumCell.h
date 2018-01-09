//
//  PhotoAlbumCell.h
//  Foods Cook
//
//  Created by 邓莎 on 2018/1/9.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface PhotoAlbumCell : UITableViewCell

- (void)setCellWithCollection:(PHAssetCollection *)collection;

@end
