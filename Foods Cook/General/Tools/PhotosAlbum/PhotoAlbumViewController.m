//
//  PhotoAlbumViewController.m
//  Foods Cook
//
//  Created by 邓莎 on 2018/1/9.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import "PhotoAlbumViewController.h"
#import "PhotoAlbumCell.h"
#import <Photos/Photos.h>
#import "PhotoDetailViewController.h"
//#import <AssetsLibrary/AssetsLibrary.h>

static NSString *const PhotoAlbumCellIdentifier = @"PhotoAlbumCellIdentifier";

@interface PhotoAlbumViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<PHAssetCollection *> *dataArray;
//@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;

@end

@implementation PhotoAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"选择相册"];
    self.dataArray = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self getAlbums];
}

- (void)getAlbums{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
//        for (PHAssetCollection *collection in assetCollections) {
//            PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
//            if (assets.count > 0) {
//                [self.dataArray addObject:collection];
//            }
//        }
//    });
    
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in assetCollections) {
        PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        if (assets.count > 0) {
            [self.dataArray addObject:collection];
        }
    }
    [self.tableView reloadData];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 90;
        _tableView.backgroundColor = ColorWithValue(BackGroundColor);
        [_tableView registerClass:[PhotoAlbumCell class] forCellReuseIdentifier:PhotoAlbumCellIdentifier];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PhotoAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:PhotoAlbumCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PHAssetCollection *collection = self.dataArray[indexPath.row];
    [cell setCellWithCollection:collection];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PHAssetCollection *collection = self.dataArray[indexPath.row];
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    NSMutableArray *assetsArray = [NSMutableArray array];
    for (PHAsset *asset in assets) {
        [assetsArray addObject:asset];
    }
    PhotoDetailViewController *controller = [[PhotoDetailViewController alloc] initWithPHColection:assetsArray];
    controller.title = collection.localizedTitle;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
