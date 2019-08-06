//
//  RJFormSelectorItem.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/8/6.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormBaseItem.h"
#import "RJFormConstant.h"

@class RJFormOptionItem;
NS_ASSUME_NONNULL_BEGIN

@interface RJFormSelectorItem : RJFormBaseItem

/********* 文本 *********/
@property (nonatomic, copy) NSString *text;
/********* 文本字体 默认16.0 *********/
@property (nonatomic, strong) UIFont *textFont;
/********* 文本颜色 默认黑色51 *********/
@property (nonatomic, strong) UIColor *textColor;

/********* 详情文本字体 默认15.0 *********/
@property (nonatomic, strong) UIFont *detailTextFont;
/********* 详情文本颜色 默认黑色93 *********/
@property (nonatomic, strong) UIColor *detailTextColor;

/********* 没有详情文本占位文字 *********/
@property (nonatomic, copy) NSString *noDetailTextPlaceholder;
/********* 没有详情文本颜色 默认黑色199 *********/
@property (nonatomic, strong) UIColor *noDetailTextColor;

/********* 隐藏箭头 *********/
@property (nonatomic, assign) BOOL hiddenArror;

/********* 选择器标题 *********/
@property (nonatomic, copy) NSString *selectorTitle;
/********* 选择器选项 *********/
@property (nonatomic, strong) NSArray<RJFormOptionItem *> *selectorOptions;
/********* 选中的选项 *********/
@property (nonatomic, strong) RJFormOptionItem *selectedOption;
/********* 选择器类型 默认RJFormSelectorStylePicker *********/
@property (nonatomic, assign) RJFormSelectorStyle selectorStyle;


+ (instancetype)itemWithText:(NSString *)text selectedOption:(RJFormOptionItem * _Nullable)selectedOption;

+ (instancetype)itemWithSelectorStyle:(RJFormSelectorStyle)selectorStyle text:(NSString *)text selectedOption:(RJFormOptionItem * _Nullable)selectedOption;


- (RJFormOptionItem *)itemValue;

@end

NS_ASSUME_NONNULL_END
