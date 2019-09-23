//
//  RJFormImageCell.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/23.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormImageCell.h"
#import "RJFormImageItem.h"
#import "RJFormConstant.h"
#import <UIImageView+WebCache.h>
#import "RJFormEmptyTool.h"
#import "RJFormPhotoPickerManager.h"
#import <PhotoBrowser/PhotoBrowser.h>
#import "UIImage+RJFormImage.h"
#import "RJFormEmptyTool.h"
#import "RJFormImageTapProtocol.h"

@interface RJFormImageCell () <PBViewControllerDataSource, PBViewControllerDelegate>

/********* text *********/
@property (nonatomic, weak) UILabel *textLbl;
/********* icon *********/
@property (nonatomic, weak) UIImageView *iconImageV;
/********* 数据 *********/
@property (nonatomic, weak) RJFormImageItem *data;
/********* 点击手势 *********/
@property (nonatomic, weak) UITapGestureRecognizer *tapContentViewGesture;

@end

@implementation RJFormImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupInit];
    }
    return self;
}



#pragma mark - Setup Init

- (void)setupInit
{
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *textLbl = [[UILabel alloc] init];
    [self.contentView addSubview:textLbl];
    [textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(RJFormRowLeftAndRightMargin);
        make.centerY.mas_equalTo(self.contentView);
    }];
    self.textLbl = textLbl;
    textLbl.text = @"";
    textLbl.font = [UIFont systemFontOfSize:17.0];
    textLbl.textColor = [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
    
    UIImageView *iconImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:iconImageV];
    [iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.contentView).multipliedBy(0.66);
        make.width.mas_equalTo(iconImageV.mas_height);
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
    }];
    self.iconImageV = iconImageV;
    iconImageV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapIconImageViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageViewClick)];
    [iconImageV addGestureRecognizer:tapIconImageViewGesture];
    
    UITapGestureRecognizer *tapContentViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewClick:)];
    [self.contentView addGestureRecognizer:tapContentViewGesture];
    self.tapContentViewGesture = tapContentViewGesture;
}

#pragma mark - Override Methods

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.iconImageV.layer.masksToBounds = NO;
    self.iconImageV.layer.cornerRadius = 0.0;
    self.iconImageV.layer.borderWidth = 0.0;
    self.iconImageV.layer.borderColor = [UIColor blackColor].CGColor;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}



#pragma mark - RJFormCellDataUpdate Methods

- (void)updateViewData:(RJFormImageItem *)data tag:(nonnull NSString *)tag
{
    [super updateViewData:data tag:tag];
    
    self.data = data;
    
    self.textLbl.attributedText = RJFormAsteriskTextRequired(data.required, data.text, data.textColor, data.textFont);
    
    if (data.iconImage)
    {
        self.iconImageV.image = data.iconImage;
    }
    else if (![RJFormEmptyTool stringIsEmpty:data.webImageUrl])
    {
        [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:data.webImageUrl] placeholderImage:data.placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
        }];
    }
    else
    {
        self.iconImageV.image = data.placeholderImage;
    }
    
    CGFloat detailTextRightMargin = data.hiddenArror ? RJFormRowLeftAndRightMargin : 0;
    switch (data.style) {
        case RJFormImageCellStyleLeft:
        {
            [self.iconImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.left.mas_offset(RJFormRowLeftAndRightMargin);
            }];
            [self.textLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.iconImageV.mas_right).mas_offset(15.0);
                make.centerY.mas_equalTo(self.contentView);
            }];
            
        }
            break;
        case RJFormImageCellStyleMiddle:
        {
            [self.textLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(RJFormRowLeftAndRightMargin);
                make.centerY.mas_equalTo(self.contentView);
            }];
            [self.iconImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.left.mas_equalTo(self.textLbl.mas_right).mas_offset(15.0);
            }];
        }
            break;
        case RJFormImageCellStyleRight:
        default:
        {
            [self.textLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(RJFormRowLeftAndRightMargin);
                make.centerY.mas_equalTo(self.contentView);
            }];
            [self.iconImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.right.mas_offset(-detailTextRightMargin);
            }];
            
            
        }
            break;
            
    }
    
    //icon添加size约束
    [self.iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        if (CGSizeEqualToSize(data.iconSize, CGSizeZero))
        {
            make.height.mas_equalTo(self.contentView).multipliedBy(0.66);
            make.width.mas_equalTo(self.iconImageV.mas_height);
        }
        else
        {
            make.size.mas_equalTo(data.iconSize);
        }
    }];
    
    self.iconImageV.layer.masksToBounds = YES;
    self.iconImageV.layer.cornerRadius = data.iconCornerRadius;
    self.iconImageV.layer.borderWidth = data.iconBorderWidth;
    self.iconImageV.layer.borderColor = data.iconBorderColor.CGColor;
    
    self.accessoryType = data.hiddenArror ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
    
    //是否可用
    self.tapContentViewGesture.enabled = data.enabled;
}

#pragma mark - PBViewControllerDataSource Methods

- (NSInteger)numberOfPagesInViewController:(PBViewController *)viewController
{
    return 1;
}

- (void)viewController:(PBViewController *)viewController presentImageView:(__kindof UIImageView *)imageView forPageAtIndex:(NSInteger)index progressHandler:(void (^)(NSInteger, NSInteger))progressHandler
{
    if(self.data.localLargeImage != nil)
    {
        imageView.image = self.data.localLargeImage;
        return;
    }
    
    if (![RJFormEmptyTool stringIsEmpty:self.data.webLargeImageUrl])
    {
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.data.webLargeImageUrl] placeholderImage:[UIImage rj_imageNamedFromMyBundle:@"rjform_placeholder"]];
        return;
    }
    
    if(self.data.iconImage != nil)
    {
        imageView.image = self.data.iconImage;
        return;
    }
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.data.webImageUrl] placeholderImage:[UIImage rj_imageNamedFromMyBundle:@"rjform_placeholder"]];
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

- (void)contentViewClick:(UITapGestureRecognizer *)tapGesture
{
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf pickerImageWithType:RJFormPhotoPickerTypeCamera];
    }];
    UIAlertAction *settingAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf pickerImageWithType:RJFormPhotoPickerTypePhotoLibrary];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:confirmAction];
    [alertController addAction:settingAction];
    [alertController addAction:cancelAction];
    alertController.modalPresentationStyle = UIModalPresentationFullScreen;
    [[self viewController] presentViewController:alertController animated:YES completion:nil];
    
    
}

//点击头像
- (void)iconImageViewClick
{
    UIViewController *vc = [self viewController];
    if ([vc conformsToProtocol:@protocol(RJFormImageTapProtocol)] && [vc respondsToSelector:@selector(singleImageTapWithTag:data:)])
    {
        [(id<RJFormImageTapProtocol>)vc singleImageTapWithTag:self.itemTag data:self.data];
        return;
    }
    
    PBViewController *pbVC = [[PBViewController alloc] init];
    pbVC.pb_dataSource = self;
    pbVC.pb_delegate = self;
    pbVC.pb_startPage = 0;
    pbVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [[self viewController] presentViewController:pbVC animated:YES completion:nil];
}

#pragma mark - Private Methods

//选择照片
- (void)pickerImageWithType:(RJFormPhotoPickerType)type
{
    __weak typeof(self) weakSelf = self;
    [[RJFormPhotoPickerManager shareInstance] presentPicker:type target:[self viewController] completed:^(UIImage * _Nullable image, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"选择图片错误：%@", error);
            return ;
        }
        [weakSelf pickedImage:image];
    }];
}

//选中图片
- (void)pickedImage:(UIImage *)image
{
    self.data.iconImage = image;
    self.data.webImageUrl = @"";
    self.data.localLargeImage = nil;
    self.data.webLargeImageUrl = @"";
    self.iconImageV.image = self.data.iconImage;
}

@end
