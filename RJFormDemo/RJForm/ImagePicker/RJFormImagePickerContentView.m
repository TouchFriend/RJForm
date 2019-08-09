//
//  RJFormImagePickerContentView.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/9.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormImagePickerContentView.h"
#import "RJFormImagePickerCollectionViewCell.h"

static NSString * const ID = @"RJFormImagePickerCollectionViewCell";

@interface RJFormImagePickerContentView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@end

@implementation RJFormImagePickerContentView

#pragma mark - Life Cycle Methods

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupInit];
    }
    return self;
}

#pragma mark - Setup Init

- (void)setupInit
{
    self.backgroundColor = [UIColor orangeColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0.0, 15.0, 23.0, 15.0);
    flowLayout.itemSize = CGSizeMake(106.0, 106.0);
    flowLayout.minimumLineSpacing = 8.0;
    flowLayout.minimumInteritemSpacing = 13.0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.scrollEnabled = NO;
    
    [collectionView registerClass:[RJFormImagePickerCollectionViewCell class] forCellWithReuseIdentifier:ID];
    
}

#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RJFormImagePickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout Methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - Override Methods

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Properties Methods

@end
