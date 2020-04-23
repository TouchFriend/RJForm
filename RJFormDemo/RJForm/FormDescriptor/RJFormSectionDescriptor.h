//
//  RJFormSectionDescriptor.h
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/23.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RJFormRowDescriptor;

NS_ASSUME_NONNULL_BEGIN

@interface RJFormSectionDescriptor : NSObject

/********* 分组头部高度 默认0.1 *********/
@property (nonatomic, assign) CGFloat sectionHeaderHeight;
/********* 分组尾部高度 默认0.1 *********/
@property (nonatomic, assign) CGFloat sectionFooterHeight;
/********* 分组头部标题 *********/
@property (nonatomic, copy) NSString *sectionHeaderTitle;
/********* 分组尾部标题 *********/
@property (nonatomic, copy) NSString *sectionFooterTitle;
#warning 后面支持自定义头部和尾部view

/********* 行数据 *********/
@property (nonatomic, strong) NSMutableArray<RJFormRowDescriptor *> *formRows;

+ (instancetype)sectionWithSectionHeaderHeight:(CGFloat)sectionHeaderHeight sectionFooterHeight:(CGFloat)sectionFooterHeight;

/// 添加行
/// @param row 行模型
/// @return 添加结果
- (BOOL)addFormRow:(RJFormRowDescriptor *)row;

/// 通过索引移除行
/// @param index 索引
/// @return 移除结果
- (BOOL)removeFormRowAtIndex:(NSUInteger)index;

/// 移除行
/// @param row 行模型
/// @return 移除结果
- (BOOL)removeFormRow:(RJFormRowDescriptor *)row;

@end

NS_ASSUME_NONNULL_END
