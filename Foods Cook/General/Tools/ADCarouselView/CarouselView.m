//
//  CarouselView.m
//  Foods Cook
//
//  Created by 邓莎 on 2018/5/30.
//  Copyright © 2018年 邓莎. All rights reserved.
//

#import "CarouselView.h"
#import "CarouselCollectionViewCell.h"
#import "masonry.h"
#import "WeakTimer.h"
#import "PageControlView.h"

static NSString *const carouselCollectionCell = @"carouselCollectionCell";

@interface CarouselView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, copy)NSArray *dataArray;
@property (nonatomic, assign)CGSize frame;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, assign)NSInteger scrollItem;
@property (nonatomic, strong)PageControlView *pageControl;

@end

@implementation CarouselView

+ (CarouselView *)carouselViewWithFrame:(CGRect)frame{
    CarouselView *carouselView = [[self alloc] initWithFrame:frame];
    return carouselView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.scrollItem = 0;
        self.dataArray = @[@"花花", @"花", @"实心收藏",@"花花"];
        [self setUpView];
    }
    return self;
}

- (void)setUpView{
    self.timer = [WeakTimer scheduledTimerWithTimerInterval:2 target:self selector:@selector(carouselAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
//    self.pageControl = [PageControlView pageControlViewWithNumber:self.dataArray.count - 1 superView:self];
//    [self.pageControl setSeletedPageControl:self.scrollItem];
    self.pageControl = [[PageControlView alloc] init];
    [self addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.bottom.equalTo(@0);
        make.height.equalTo(@40);
        make.width.equalTo(@((self.dataArray.count-2) * 8 + (self.dataArray.count-1) * 10));
    }];
}

- (void)carouselAction{
    self.scrollItem ++;
    NSIndexPath *indexpath = [NSIndexPath indexPathForItem:self.scrollItem inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    if (self.scrollItem == self.dataArray.count -1) {
        self.scrollItem = 0;
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:self.scrollItem inSection:0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView scrollToItemAtIndexPath:indexpath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        });
    }
    
    [self.pageControl setSeletedPageControl:self.scrollItem];
    
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [_collectionView registerClass:[CarouselCollectionViewCell class] forCellWithReuseIdentifier:carouselCollectionCell];
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CarouselCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:carouselCollectionCell forIndexPath:indexPath];
    NSString *imgStr = self.dataArray[indexPath.row];
    cell.imgString = imgStr;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 200);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    self.timer = [WeakTimer scheduledTimerWithTimerInterval:2 target:self selector:@selector(carouselAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

@end
