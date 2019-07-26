//
//  RJFormBaseItem.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/24.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RJFormItemValue.h"

NS_ASSUME_NONNULL_BEGIN

@interface RJFormBaseItem : NSObject <RJFormItemValue>

#warning 下列属性未设置生效
/********* 背景颜色 *********/
@property (nonatomic, strong) UIColor *backgroundColor;
/********* 选中的背景颜色 *********/
@property (nonatomic, strong) UIColor *selectedBackgroundColor;
/********* cell的选中样式 默认 UITableViewCellSelectionStyleDefault *********/
@property (nonatomic, assign) UITableViewCellSelectionStyle selectionStyle;
/********* 分割线左右间距 默认左边15.0，右边0 *********/
@property (nonatomic, assign) UIEdgeInsets separatorInset;
/********* 是否必须的,就值不为空 默认NO *********/
@property (nonatomic, assign, getter=isRequired) BOOL required;
/********* 值为空时，显示的提示 *********/
@property (nonatomic, copy) NSString *requireMsg;
/********* tag(标签) *********/
@property (nonatomic, copy) NSString *tag;



@end

NS_ASSUME_NONNULL_END
