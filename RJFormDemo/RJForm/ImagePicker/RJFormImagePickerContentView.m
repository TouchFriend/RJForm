//
//  RJFormImagePickerContentView.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/9.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormImagePickerContentView.h"
#import "RJFormImagePickerCollectionViewCell.h"
#import "RJFormImagePickerContentItem.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import <PhotoBrowser/PhotoBrowser.h>
#import <UIImageView+WebCache.h>
#import "RJFormConstant.h"
#import "UIImage+RJFormImage.h"
#import "RJFormPhotoPickerManager.h"
#import "RJFormEmptyTool.h"
#import "RJFormImageTapProtocol.h"

static NSString * const ID = @"RJFormImagePickerCollectionViewCell";
static NSInteger const RJFormImageTotalCount = 6;

@interface RJFormImagePickerContentView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, TZImagePickerControllerDelegate, PBViewControllerDataSource, PBViewControllerDelegate>

/********* collectionView *********/
@property (nonatomic, weak) UICollectionView *collectionView;
/********* 模型 *********/
@property (nonatomic, strong) NSMutableArray<RJFormImagePickerContentItem *> *contentItemArrM;

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
    self.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(20.0, 15.0, 23.0, 15.0);
    CGFloat itemWidth = (RJFormScreenWidth - 56) / 3.0;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
    flowLayout.minimumLineSpacing = 8.0;
    flowLayout.minimumInteritemSpacing = 13.0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    self.collectionView = collectionView;
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
    return self.contentItemArrM.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    RJFormImagePickerContentItem *item = self.contentItemArrM[indexPath.row];
    RJFormImagePickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.contentItem = item;
    cell.deleteBlock = ^(RJFormImagePickerContentItem * _Nonnull contentItem) {
        [weakSelf deleteBtnClick:contentItem];
    };
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout Methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RJFormImagePickerContentItem *item = self.contentItemArrM[indexPath.row];
    
    //添加图片
    if (item.isAdd)
    {
        [self showPickTypes];
        return;
    }
    
    //外部处理图片
    UIViewController *vc = [self viewController];
    if ([vc conformsToProtocol:@protocol(RJFormImageTapProtocol)] && [vc respondsToSelector:@selector(multipleImageTapWithTag:index:images:)])
    {
        [(id<RJFormImageTapProtocol>)vc multipleImageTapWithTag:self.itemTag index:indexPath.row images:[self.contentItemArrM copy]];
        return;
    }
    
    //预览图片
    PBViewController *pbVC = [[PBViewController alloc] init];
    pbVC.pb_dataSource = self;
    pbVC.pb_delegate = self;
    pbVC.pb_startPage = indexPath.row;
    pbVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [[self viewController] presentViewController:pbVC animated:YES completion:nil];
    
    
    
    
}




#pragma mark - TZImagePickerControllerDelegate Methods

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    // 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
    [self pickedImages:photos];
    
    
}



#pragma mark - PBViewControllerDataSource Methods

- (NSInteger)numberOfPagesInViewController:(PBViewController *)viewController
{
    RJFormImagePickerContentItem * item = self.contentItemArrM.lastObject;
    if(item.isAdd == YES)
    {
        return self.contentItemArrM.count - 1;
    }
    
    return self.contentItemArrM.count;
}

- (void)viewController:(PBViewController *)viewController presentImageView:(__kindof UIImageView *)imageView forPageAtIndex:(NSInteger)index progressHandler:(void (^)(NSInteger, NSInteger))progressHandler
{
    RJFormImagePickerContentItem * item = self.contentItemArrM[index];
    if (item.localLargeImage != nil)
    {
        imageView.image = item.localLargeImage;
        return;
    }
    
    if (![RJFormEmptyTool stringIsEmpty:item.webLargeImageUrl])
    {
        [imageView sd_setImageWithURL:[NSURL URLWithString:item.webLargeImageUrl] placeholderImage:[UIImage rj_imageNamedFromMyBundle:@"rjform_placeholder"]];
        return ;
    }
    
    if(item.localImage != nil)
    {
        imageView.image = item.localImage;
        return;
    }
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:item.imageUrl] placeholderImage:[UIImage rj_imageNamedFromMyBundle:@"rjform_placeholder"]];
}

#pragma mark - PBViewControllerDelegate Methods

- (void)viewController:(PBViewController *)viewController didSingleTapedPageAtIndex:(NSInteger)index presentedImage:(__kindof UIImage *)presentedImage
{
    [[self viewController] dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewController:(PBViewController *)viewController didLongPressedPageAtIndex:(NSInteger)index presentedImage:(__kindof UIImage *)presentedImage
{
    
}

#pragma mark - Target Methods

//点击cell的删除按钮
- (void)deleteBtnClick:(RJFormImagePickerContentItem *)item
{
    [self.contentItemArrM removeObject:item];
    
    if(self.contentItemArrM.lastObject.isAdd == NO)
    {
        RJFormImagePickerContentItem * item = [[RJFormImagePickerContentItem alloc] init];
        item.isAdd = YES;
        
        [self.contentItemArrM addObject:item];
    }
    
    [self postRefreshFormNotification];
    
    [self.collectionView reloadData];
}

#pragma mark - Override Methods

#pragma mark - Public Methods

- (void)changeImages:(NSMutableArray<RJFormImagePickerContentItem *> *)imagesM
{
    self.contentItemArrM = imagesM;
    [self.collectionView reloadData];
}

#pragma mark - Private Methods

- (UIViewController *)viewController
{
    id responder = self;
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]])
        {
            return responder;
        }
        responder = [responder nextResponder];
    }
    
    return nil;
}

//发出刷新表单通知
- (void)postRefreshFormNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:RJFormRefreshNotificationName object:nil];
}


/**
 显示选择选项
 */
- (void)showPickTypes
{
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf pickImageFromCamera];
    }];
    UIAlertAction *settingAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf pickImageFromAlbum];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:confirmAction];
    [alertController addAction:settingAction];
    [alertController addAction:cancelAction];
    alertController.modalPresentationStyle = UIModalPresentationFullScreen;
    [[self viewController] presentViewController:alertController animated:YES completion:nil];
}


/**
 从相机选择图片
 */
- (void)pickImageFromCamera
{
    __weak typeof(self) weakSelf = self;
    [[RJFormPhotoPickerManager shareInstance] presentPicker:RJFormPhotoPickerTypeCamera target:[self viewController] completed:^(UIImage * _Nullable image, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"选择图片错误：%@", error);
            return ;
        }
        [weakSelf pickedImages:@[image]];
    }];
}


/**
 从相册选择图片
 */
- (void)pickImageFromAlbum
{
    //选择图片
    TZImagePickerController * imagePickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:RJFormImageTotalCount + 1 - self.contentItemArrM.count delegate:self];
    imagePickerController.allowPickingVideo = NO;
    imagePickerController.allowPickingMultipleVideo = NO;
    imagePickerController.allowPickingOriginalPhoto = NO;
    imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
    [[self viewController] presentViewController:imagePickerController animated:YES completion:nil];
}


/**
 选中了图片

 @param photos 图片
 */
- (void)pickedImages:(NSArray<UIImage *> *)photos
{
    NSInteger count = self.contentItemArrM.count;
    for (NSInteger i = 0; i < photos.count; i++) {
        UIImage * originalImage = photos[i];
        if(count + i < RJFormImageTotalCount)//未达到最大图片数
        {
            RJFormImagePickerContentItem * item = [[RJFormImagePickerContentItem alloc] init];
            item.localImage = originalImage;
            item.imageUrl = @"";
            item.isAdd = NO;
            item.localLargeImage = nil;
            item.webLargeImageUrl = @"";
            [self.contentItemArrM insertObject:item atIndex:self.contentItemArrM.count - 1];
        }
        else//达到最大图片数，替换添加按钮
        {
            RJFormImagePickerContentItem * addItem = self.contentItemArrM[self.contentItemArrM.count - 1];
            addItem.localImage = originalImage;
            addItem.imageUrl = @"";
            addItem.isAdd = NO;
            addItem.localLargeImage = nil;
            addItem.webLargeImageUrl = @"";
            break;
        }
    }
    
    [self.collectionView reloadData];
    
    [self postRefreshFormNotification];
}

#pragma mark - Properties Methods

- (NSMutableArray<RJFormImagePickerContentItem *> *)contentItemArrM
{
    if (_contentItemArrM == nil)
    {
        
        _contentItemArrM = [NSMutableArray array];
    }
    return _contentItemArrM;
}

@end
