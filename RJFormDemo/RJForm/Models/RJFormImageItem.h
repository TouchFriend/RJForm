//
//  RJFormImageItem.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/23.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormBaseItem.h"
#import "RJFormConstant.h"

NS_ASSUME_NONNULL_BEGIN

@interface RJFormImageItem : RJFormBaseItem

/********* 文本 *********/
@property (nonatomic, copy) NSString *text;
/********* 文本字体 默认17.0 *********/
@property (nonatomic, strong) UIFont *textFont;
/********* 文本颜色 默认黑色51 *********/
@property (nonatomic, strong) UIColor *textColor;

/********* 图片位置样式 默认左边 *********/
@property (nonatomic, assign) RJFormImageCellStyle style;
/********* 本地图片 *********/
@property (nonatomic, strong) UIImage *iconImage;
/********* 网络图片地址 *********/
@property (nonatomic, copy) NSString *webImageUrl;

/********* 图片size *********/
@property (nonatomic, assign) CGSize iconSize;
/********* 圆角半径 *********/
@property (nonatomic, assign) CGFloat iconCornerRadius;
/********* 边框宽度 *********/
@property (nonatomic, assign) CGFloat iconBorderWidth;
/********* 边框颜色 *********/
@property (nonatomic, strong) UIColor *iconBorderColor;

/********* 隐藏箭头 *********/
@property (nonatomic, assign) BOOL hiddenArror;

+ (instancetype)itemWithText:(NSString *)text iconImage:(UIImage *)iconImage style:(RJFormImageCellStyle)style;

//默认RJFormImageCellStyleLeft
+ (instancetype)itemWithText:(NSString *)text iconImage:(UIImage *)iconImage;

- (UIImage *)itemValue;

@end

NS_ASSUME_NONNULL_END
