//
//  RJFormImagePickerCollectionViewCell.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/9.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormImagePickerCollectionViewCell.h"
#import "RJFormImagePickerContentItem.h"
#import <UIImageView+WebCache.h>
#import "UIImage+RJFormImage.h"
#import <Masonry/Masonry.h>

@interface RJFormImagePickerCollectionViewCell ()

/********* icon *********/
@property (nonatomic, weak) UIImageView *iconImageV;
/********* 删除按钮 *********/
@property (nonatomic, weak) UIButton *closeBtn;

@end

@implementation RJFormImagePickerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupInit];
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.closeBtn.hidden = NO;
}

#pragma mark - Setup Init

- (void)setupInit
{
    self.clipsToBounds = NO;
    
    UIImageView *iconImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:iconImageV];
    [iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    self.iconImageV = iconImageV;
//    iconImageV.image = [UIImage imageNamed:@"zhanweijian"];
    iconImageV.contentMode = UIViewContentModeScaleAspectFill;
    iconImageV.layer.masksToBounds = YES;
    iconImageV.layer.cornerRadius = 5.0;
    
    UIButton *closeBtn = [[UIButton alloc] init];
    [self.contentView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerX.mas_equalTo(self.contentView.mas_right).mas_offset(-7.0);
        make.centerY.mas_equalTo(self.contentView.mas_top).mas_offset(7.0);
    }];
    self.closeBtn = closeBtn;
    [closeBtn setImage:[UIImage rj_imageNamedFromMyBundle:@"rjform_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}


#pragma mark - Target Methods

- (void)closeBtnClick:(UIButton *)closeBtn
{
    if (self.deleteBlock)
    {
        self.deleteBlock(self.contentItem);
    }
}

#pragma mark - Override Methods




#pragma mark - Properties Methods

- (void)setContentItem:(RJFormImagePickerContentItem *)pickerItem
{
    _contentItem = pickerItem;
    if (pickerItem.isAdd)
    {
        self.iconImageV.image = [UIImage rj_imageNamedFromMyBundle:@"rjform_icon_add"];
        self.closeBtn.hidden = YES;
        return;
    }
    
    if (pickerItem.localImage)
    {
        self.iconImageV.image = pickerItem.localImage;
    }
    else
    {
        [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:pickerItem.imageUrl] placeholderImage:[UIImage imageNamed:@"rjform_placeholder"]];
    }
}


@end
