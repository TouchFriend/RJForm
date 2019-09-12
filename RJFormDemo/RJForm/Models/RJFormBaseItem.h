//
//  RJFormBaseItem.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/24.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RJFormItemValue.h"

@protocol RJFormValidatorProtocol;
NS_ASSUME_NONNULL_BEGIN

@interface RJFormBaseItem : NSObject <RJFormItemValue>

#warning 下列属性未设置生效
/********* 背景颜色 *********/
@property (nonatomic, strong) UIColor *backgroundColor;
/********* 选中的背景颜色 *********/
@property (nonatomic, strong) UIColor *selectedBackgroundColor;
/********* cell的选中样式 默认 UITableViewCellSelectionStyleDefault *********/
@property (nonatomic, assign) UITableViewCellSelectionStyle selectionStyle;
/********* 分割线左右间距 默认UIEdgeInsetsZero，即不设置。统一设置，请通过tableView的separatorInset来设置 *********/
@property (nonatomic, assign) UIEdgeInsets separatorInset;

#warning 上面属性未设置生效
/**
 头部分割线隐藏 (分组第一个cell有) 默认为NO
 在tableView显示分割线的基础上，隐藏某些cell的分割线
 统一设置，请通过tableView的UITableViewCellSeparatorStyle来设置
 **/
@property (nonatomic, assign) BOOL topSeparatorViewHidden;
/********* 底部分割线移除 默认为NO *********/
@property (nonatomic, assign) BOOL bottomSeparatorViewHidden;


/********* 是否必须的,就值不为空 默认NO *********/
@property (nonatomic, assign, getter=isRequired) BOOL required;
/********* 值为空时，显示的提示 *********/
@property (nonatomic, copy) NSString *requireMsg;

/********* 是否可用 默认YES *********/
@property (nonatomic, assign) BOOL enabled;


/********* 正则表达式 *********/
@property (readonly, nonatomic, strong) NSMutableArray<id<RJFormValidatorProtocol>> *regexValidators;
/**
 添加正则表达式

 @param validator 正则表达式
 */
- (void)addValidator:(id<RJFormValidatorProtocol >)validator;

/**
 删除正则表达式

 @param validator 正则表达式
 */
- (void)removeValidator:(id<RJFormValidatorProtocol >)validator;


/**
 删除所有正则表达式
 */
- (void)removeAllValidators;

/********* tag(标签) *********/
@property (nonatomic, copy) NSString *tag;



@end

NS_ASSUME_NONNULL_END
