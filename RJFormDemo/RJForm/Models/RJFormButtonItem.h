//
//  RJFormButtonItem.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/24.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RJFormBaseItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface RJFormButtonItem : RJFormBaseItem

/********* 文本 *********/
@property (nonatomic, copy) NSString *text;
/********* 文本字体 默认17.0 *********/
@property (nonatomic, strong) UIFont *textFont;
/********* 文本颜色 默认黑色51 *********/
@property (nonatomic, strong) UIColor *textColor;
/********* 间距 默认UIEdgeInsetsMake(0.0, 15.0, 0.0, 15.0) *********/
@property (nonatomic, assign) UIEdgeInsets insets;
/********* 背景 默认34.161.241.1 *********/
@property (nonatomic, strong) UIColor *buttonBackgroudColor;
/********* 圆角半径 默认4.0 *********/
@property (nonatomic, assign) CGFloat cornerRadius;

/********* cell的背景色 默认clearColor *********/
@property (nonatomic, strong) UIColor *cellBackgroudColor;

/********* 点击按钮后，执行控制器的方法,有一个参数,就是按钮 *********/
@property (nonatomic, copy) NSString *clickedSelector;


+ (instancetype)itemWithText:(NSString *)text selector:(NSString *)clickedSelector;

@end

NS_ASSUME_NONNULL_END
