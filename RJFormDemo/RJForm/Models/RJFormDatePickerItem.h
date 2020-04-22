//
//  RJFormDatePickerItem.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/9.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormBaseItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface RJFormDatePickerItem : RJFormBaseItem

/********* 文本 *********/
@property (nonatomic, copy) NSString *text;
/********* 文本字体 默认16.0 *********/
@property (nonatomic, strong) UIFont *textFont;
/********* 文本颜色 默认黑色51 *********/
@property (nonatomic, strong) UIColor *textColor;

/********* 详情文本 也是日期 *********/
@property (nonatomic, copy) NSString *detailText;
/********* 详情文本字体 默认15.0 *********/
@property (nonatomic, strong) UIFont *detailTextFont;
/********* 详情文本颜色 默认黑色93 *********/
@property (nonatomic, strong) UIColor *detailTextColor;

/********* 没有详情文本占位文字 默认 请选择 *********/
@property (nonatomic, copy) NSString *noDetailTextPlaceholder;
/********* 没有详情文本颜色 默认黑色199 *********/
@property (nonatomic, strong) UIColor *noDetailTextColor;

/********* 隐藏箭头 *********/
@property (nonatomic, assign) BOOL hiddenArrow;

/********* 选择器标题 为空，默认使用text属性 *********/
@property (nonatomic, copy) NSString *selectorTitle;
/********* 日期格式 默认yyyy-MM-dd *********/
@property (nonatomic, copy) NSString *dateFormat;

/********* 可以选的最小日期 默认为nil *********/
@property (nullable, nonatomic, strong) NSDate *minimumDate;
/********* 可以选的最大日期 默认为nil *********/
@property (nullable, nonatomic, strong) NSDate *maximumDate;

+ (instancetype)itemWithText:(NSString *)text detailText:(NSString *)detailText;

- (NSString *)itemValue;

@end

NS_ASSUME_NONNULL_END
