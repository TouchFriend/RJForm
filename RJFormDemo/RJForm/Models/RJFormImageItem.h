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
/********* 文本字体 默认16.0 *********/
@property (nonatomic, strong) UIFont *textFont;
/********* 文本颜色 默认黑色51 *********/
@property (nonatomic, strong) UIColor *textColor;

/********* 图片位置样式 默认左边 *********/
@property (nonatomic, assign) RJFormImageCellStyle style;
/********* 本地图片,如果同时设置了iconImage和webImageUrl，优先显示iconImage *********/
@property (nonatomic, strong) UIImage *iconImage;
/********* 网络图片地址 *********/
@property (nonatomic, copy) NSString *webImageUrl;
/********* 占位图片 *********/
@property (nonatomic, copy) UIImage *placeholderImage;


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

+ (instancetype)itemWithText:(NSString *)text iconImage:(UIImage * _Nullable)iconImage style:(RJFormImageCellStyle)style;

+ (instancetype)itemWithText:(NSString *)text webImageUrl:(NSString * _Nullable)webImageUrl style:(RJFormImageCellStyle)style;

+ (instancetype)itemWithText:(NSString *)text webImageUrl:(NSString * _Nullable)webImageUrl placeholderImage:(UIImage *_Nullable)placeholderImage style:(RJFormImageCellStyle)style;

//默认RJFormImageCellStyleLeft
+ (instancetype)itemWithText:(NSString *)text iconImage:(UIImage *_Nullable)iconImage;


/**
 可能返回UIImage对象，也可能是网络图片地址，需要外部自行判断下

 @return UIImage对象或者网络图片地址
 */
- (id)itemValue;

@end

NS_ASSUME_NONNULL_END
