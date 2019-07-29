//
//  RJFormInfoItem.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/23.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormBaseItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface RJFormInfoItem : RJFormBaseItem

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

/********* 隐藏箭头 *********/
@property (nonatomic, assign) BOOL hiddenArror;

+ (instancetype)itemWithText:(NSString *)text detailText:(NSString *)detailText;

- (NSString *)itemValue;

@end

NS_ASSUME_NONNULL_END
