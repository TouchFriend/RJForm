//
//  RJFormTextViewItem.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/29.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormBaseItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface RJFormTextViewItem : RJFormBaseItem

/********* 文本 *********/
@property (nonatomic, copy) NSString *text;
/********* 文本字体 默认16.0 *********/
@property (nonatomic, strong) UIFont *textFont;
/********* 文本颜色 默认黑色51 *********/
@property (nonatomic, strong) UIColor *textColor;

/********* 详情文本 *********/
@property (nonatomic, copy) NSString *detailText;
/********* 详情文本字体 默认15.0 *********/
@property (nonatomic, strong) UIFont *detailTextFont;
/********* 详情文本颜色 默认黑色93 *********/
@property (nonatomic, strong) UIColor *detailTextColor;
/********* 详情富文本占位文字 默认 请填写 字体15 颜色199.0 *********/
@property (nonatomic, strong) NSAttributedString *detailAttributedPlaceholder;
/********* 详情文字数量限制 默认无限制 *********/
@property (nonatomic, strong) NSNumber *detailMaxNumberOfCharacters;

+ (instancetype)itemWithText:(NSString *)text detailText:(NSString *)detailText;

- (NSString *)itemValue;

@end

NS_ASSUME_NONNULL_END
