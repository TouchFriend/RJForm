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

@interface RJFormImageCell ()

/********* text *********/
@property (nonatomic, weak) UILabel *textLbl;
/********* icon *********/
@property (nonatomic, weak) UIImageView *iconImageV;

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

- (void)updateViewData:(RJFormImageItem *)data
{
    [super updateViewData:data];
    
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
    
}

@end
