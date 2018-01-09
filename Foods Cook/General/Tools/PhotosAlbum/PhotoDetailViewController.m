//
//  PhotoDetailViewController.m
//  Foods Cook
//
//  Created by 邓莎 on 2018/1/9.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "PhotoDetailCollectionViewCell.h"

static NSString *const photoDetailCellIdentifier = @"photoDetailCellIdentifier";

@interface PhotoDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray *collectionArray;

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self addRightButton];
}

- (void)addRightButton{
    
}

- (instancetype)initWithPHColection:(NSArray *)collectionArray{
    if (self = [super init]) {
        self.collectionArray = collectionArray;
    }
    return self;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        CGFloat width = (CGRectGetWidth(self.view.frame)-25)/4;
        layout.itemSize = CGSizeMake(width, width);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[PhotoDetailCollectionViewCell class] forCellWithReuseIdentifier:photoDetailCellIdentifier];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoDetailCellIdentifier forIndexPath:indexPath];
    PHAsset *asset = self.collectionArray[indexPath.row];
    [cell setCellWithPHAsset:asset];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
